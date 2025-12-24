#!/bin/bash

# Firebase 배포 스크립트
# .firebase_token 파일 또는 환경 변수 FIREBASE_TOKEN을 사용하여 배포합니다.
# 배포 완료 후 버전 태그를 git에 자동으로 생성합니다.
# 기존 태그가 있으면 빌드 번호를 자동으로 증가시킵니다.
#
# 사용법:
#   ./scripts/deploy.sh           # 배포 + 태그 생성 (태그 중복 시 자동 증가)
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

# 빌드 번호 추출 (1.0.3+4 -> 4)
get_build_number() {
  local version=$1
  echo "${version#*+}"
}

# 버전 문자열 추출 (1.0.3+4 -> 1.0.3)
get_version_string() {
  local version=$1
  echo "${version%+*}"
}

# pubspec.yaml 버전 업데이트
update_version() {
  local new_version=$1
  sed -i '' "s/^version: .*/version: $new_version/" pubspec.yaml
  echo "📝 pubspec.yaml 버전 업데이트: $new_version"
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

echo "📦 현재 버전: $VERSION"
echo "🏷️  예정 태그: $TAG_NAME"
echo ""

# 태그 중복 확인 및 자동 증가
if [ "$CREATE_TAG" = true ]; then
  while git tag -l "$TAG_NAME" | grep -q "$TAG_NAME"; do
    echo "⚠️  태그 '$TAG_NAME'이(가) 이미 존재합니다. 빌드 번호를 증가시킵니다."
    
    # 빌드 번호 증가
    VERSION_STR=$(get_version_string "$VERSION")
    BUILD_NUM=$(get_build_number "$VERSION")
    NEW_BUILD_NUM=$((BUILD_NUM + 1))
    VERSION="${VERSION_STR}+${NEW_BUILD_NUM}"
    TAG_NAME=$(version_to_tag "$VERSION")
    
    echo "📦 새 버전: $VERSION"
    echo "🏷️  새 태그: $TAG_NAME"
  done
  
  # pubspec.yaml 업데이트 (버전이 변경된 경우)
  CURRENT_VERSION=$(get_version)
  if [ "$VERSION" != "$CURRENT_VERSION" ]; then
    update_version "$VERSION"
  fi
fi

echo ""

echo "🔨 Building Flutter web..."
flutter build web --release --no-tree-shake-icons

echo "🚀 Deploying to Firebase..."
firebase deploy --only hosting --token "$FIREBASE_TOKEN"

echo "✅ Deploy complete!"
echo "🌐 https://littlesignals.web.app"

# Git 태그 생성
if [ "$CREATE_TAG" = true ]; then
  echo ""
  
  # pubspec.yaml이 변경되었으면 커밋
  if git diff --quiet pubspec.yaml 2>/dev/null; then
    echo "📝 pubspec.yaml 변경 없음"
  else
    echo "📝 버전 변경사항 커밋 중..."
    git add pubspec.yaml
    git commit -m "chore: 버전 $VERSION 으로 업데이트"
  fi
  
  echo "🏷️  Creating git tag: $TAG_NAME"
  
  # 현재 날짜/시간
  DEPLOY_DATE=$(date '+%Y-%m-%d %H:%M:%S')
  
  # 태그 생성 (annotated tag)
  git tag -a "$TAG_NAME" -m "Release $VERSION - Deployed on $DEPLOY_DATE"
  
  echo "📤 Pushing changes and tag to remote..."
  git push origin HEAD
  git push origin "$TAG_NAME"
  
  echo "✅ Tag '$TAG_NAME' created and pushed!"
fi

echo ""
echo "🎉 All done!"
