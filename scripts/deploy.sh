#!/bin/bash

# Firebase 배포 스크립트
# .firebase_token 파일 또는 환경 변수 FIREBASE_TOKEN을 사용하여 배포합니다.
#
# 사용법:
#   ./scripts/deploy.sh

set -e

# 프로젝트 루트로 이동
cd "$(dirname "$0")/.."

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

echo "🔨 Building Flutter web..."
flutter build web --release --no-tree-shake-icons

echo "🚀 Deploying to Firebase..."
firebase deploy --only hosting --token "$FIREBASE_TOKEN"

echo "✅ Deploy complete!"
echo "🌐 https://littlesignals.web.app"
