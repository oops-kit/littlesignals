#!/bin/bash

# Firebase 배포 스크립트
# .firebase_token 파일 또는 환경 변수 FIREBASE_TOKEN을 사용하여 배포합니다.
# 배포 완료 후 버전 태그를 git에 자동으로 생성합니다.
#
# 사용법:
#   ./scripts/deploy.sh           # 배포 + 태그 생성
#   ./scripts/deploy.sh --no-tag  # 배포만 (태그 생성 안 함)

set -e

# 프로젝트 루트로 이동
cd "$(dirname "$0")/.."

# 옵션 파싱
CREATE_TAG=true
for arg in "$@"; do
  case $arg in
    --no-tag)
      CREATE_TAG=false
      shift
      ;;
  esac
done

# pubspec.yaml에서 버전 읽기
get_version() {
  grep "^version:" pubspec.yaml | sed 's/version: //' | tr -d ' '
}

# 버전을 태그 형식으로 변환 (1.0.3+4 -> v1.0.3.4)
version_to_tag() {
  local version=$1
  echo "v${version//+/.}"
}

# 토큰 파일에서 읽기 (환경 변수가 없으면)
if [ -z "$FIREBASE_TOKEN" ] && [ -f ".firebase_token" ]; then
  FIREBASE_TOKEN=$(cat .firebase_token)
fi

# 토큰 확인
if [ -z "$FIREBASE_TOKEN" ]; then
  echo "❌ Error: Firebase 토큰이 없습니다."
  echo ""
  echo "다음 중 하나를 설정하세요:"
  echo "  1. .firebase_token 파일 생성"
  echo "  2. export FIREBASE_TOKEN=\"your-token\""
  exit 1
fi

# 현재 버전 가져오기
VERSION=$(get_version)
TAG_NAME=$(version_to_tag "$VERSION")

echo "📦 Version: $VERSION"
echo "🏷️  Tag: $TAG_NAME"
echo ""

# 태그 중복 확인
if [ "$CREATE_TAG" = true ]; then
  if git tag -l "$TAG_NAME" | grep -q "$TAG_NAME"; then
    echo "⚠️  Warning: 태그 '$TAG_NAME'이(가) 이미 존재합니다."
    read -p "계속 진행하시겠습니까? (y/N): " confirm
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
      echo "❌ 배포가 취소되었습니다."
      exit 1
    fi
  fi
fi

echo "🔨 Building Flutter web..."
flutter build web --release --no-tree-shake-icons

echo "🚀 Deploying to Firebase..."
firebase deploy --only hosting --token "$FIREBASE_TOKEN"

echo "✅ Deploy complete!"
echo "🌐 https://littlesignals.web.app"

# Git 태그 생성
if [ "$CREATE_TAG" = true ]; then
  echo ""
  echo "🏷️  Creating git tag: $TAG_NAME"
  
  # 현재 날짜/시간
  DEPLOY_DATE=$(date '+%Y-%m-%d %H:%M:%S')
  
  # 태그 생성 (annotated tag)
  git tag -a "$TAG_NAME" -m "Release $VERSION - Deployed on $DEPLOY_DATE"
  
  echo "📤 Pushing tag to remote..."
  git push origin "$TAG_NAME"
  
  echo "✅ Tag '$TAG_NAME' created and pushed!"
fi

echo ""
echo "🎉 All done!"
