# 결과 화면 알고리즘 및 정책 문서

이 문서는 Little Signals 앱의 테스트 결과 화면이 어떻게 생성되는지에 대한 알고리즘과 정책을 설명합니다.

## 📋 목차

1. [개요](#개요)
2. [주의력 테스트 결과 알고리즘](#주의력-테스트-결과-알고리즘)
3. [충동성 테스트 결과 알고리즘](#충동성-테스트-결과-알고리즘)
4. [Z점수 계산 및 시각화](#z점수-계산-및-시각화)
5. [월령별 규준값](#월령별-규준값)
6. [행동 패턴 분류](#행동-패턴-분류)
7. [결과 표시 정책](#결과-표시-정책)
8. [참고문헌](#참고문헌)

---

## 개요

결과 화면은 **Strategy 패턴**을 사용하여 테스트 타입(주의력/충동성)에 따라 다른 계산 로직을 적용합니다.

```
TestResult → ReportCalculator → ReportData → UI 렌더링
```

### 핵심 구성요소

| 구성요소 | 설명 |
|---------|------|
| `AttentionReportCalculator` | 주의력 테스트 결과 계산기 |
| `ImpulsivityReportCalculator` | 충동성 테스트 결과 계산기 |
| `ZScoreCalculator` | Z점수 계산 유틸리티 |
| `ReportData` | 결과 화면에 표시할 데이터 모델 |

---

## 주의력 테스트 결과 알고리즘

### 테스트 설계 (기획서 기준)

| 항목 | 값 | 설명 |
|-----|-----|------|
| 격자 구성 | 3x2 (6장, 3쌍) | 고정 |
| 오답 피드백 노출 | 1500ms | 시각 정보 저장 시간 보장 |
| 입력 차단 (Cool-down) | 400ms | 충동성 연타 방지 |
| 힌트 딜레이 | 8초 | 입력이 없을 때 힌트 표시 |
| 힌트 사용 패널티 | MER -0.05/회 | 힌트 사용 시 점수 차감 |

### 입력 데이터 (AttentionResult)

| 필드 | 타입 | 설명 |
|-----|------|------|
| `durationSeconds` | double | 테스트 소요 시간 (초) |
| `totalMoves` | int | 총 이동(터치) 횟수 |
| `errors` | int | 오류 횟수 |
| `revisitCount` | int | 재확인 횟수 (이미 확인한 카드를 다시 뒤집은 횟수) |
| `uniqueCardsRevealed` | int | 확인한 고유 카드 수 |
| `totalTurns` | int | 총 턴 수 (카드 2장 뒤집기 = 1턴) |
| `reactionTimesMs` | List\<int\> | 개별 반응 시간 목록 (ms) |
| `hintUsedCount` | int | 힌트 사용 횟수 |

### 1. MER (Memory Efficiency Ratio) 계산

**MER**은 기억 효율성 비율로, 아이가 카드 매칭 과제를 얼마나 효율적으로 수행했는지를 나타냅니다.

```dart
// 실제 턴 수 계산
actualTurns = totalTurns > 0 ? totalTurns : (totalMoves / 2).ceil()

// 기본 MER 계산
baseMER = baselineTurns / actualTurns

// 힌트 패널티 적용 (기획서: 힌트 사용 시 0.5점 차감 → MER 0.05 차감)
MER = (baseMER - (hintUsedCount * 0.05)).clamp(0.0, 1.0)
```

- **baselineTurns**: 6 (3쌍의 카드를 완벽하게 맞추는 최소 턴 수)
- **MER 범위**: 0.0 ~ 1.0 (1.0이면 완벽한 효율)
- **힌트 패널티**: 힌트 1회 사용 시 MER에서 0.05 차감

**예시:**
- 6턴에 완료, 힌트 0회 → MER = 6/6 = 1.0 (완벽)
- 10턴에 완료, 힌트 0회 → MER = 6/10 = 0.6
- 10턴에 완료, 힌트 2회 → MER = 0.6 - 0.1 = 0.5

### 2. 재확인율 (Revisiting Rate) 계산

**재확인율**은 이미 확인한 카드를 다시 뒤집는 비율로, 작업기억 상태를 반영합니다.

```dart
revisitingRate = revisitCount / totalMoves
```

- **범위**: 0.0 ~ 1.0
- **해석**: 낮을수록 좋음 (기억을 잘 유지함)

### 3. 평균 반응시간 계산

```dart
if (reactionTimesMs.isNotEmpty) {
  avgReactionTime = reactionTimesMs.average / 1000  // 초 단위로 변환
} else {
  avgReactionTime = durationSeconds / totalMoves
}
```

### 4. Z점수 계산

각 지표에 대해 월령별 규준과 비교하여 Z점수를 계산합니다.

```dart
// MER Z점수 (높을수록 좋음)
merZ = (observedMER - peerMean) / peerStdDev

// 재확인율 Z점수 (낮을수록 좋으므로 방향 반전)
revisitZ = (peerMean - observedRevisitingRate) / peerStdDev
```

---

## 충동성 테스트 결과 알고리즘

### 테스트 설계 (기획서 기준)

| 항목 | 값 | 설명 |
|-----|-----|------|
| 자극 노출 시간 | 1500ms | 풍선이 화면에 머무는 시간 |
| 자극 간 간격 (ISI) | 1500ms | 고정, 다음 풍선까지 대기 시간 |
| 파란 풍선 비율 (Go) | 75% | 터치해야 하는 자극 |
| 빨간 풍선 비율 (No-Go) | 25% | 터치하면 안 되는 자극 |
| 총 자극 수 | 15개 | 테스트당 풍선 수 |

### 입력 데이터 (ImpulsivityResult)

| 필드 | 타입 | 설명 |
|-----|------|------|
| `reactionTimeAverage` | double | 평균 반응 시간 (ms) |
| `commissionErrors` | int | 오경보 오류 (No-go 자극에 반응한 횟수) |
| `omissionErrors` | int | 누락 오류 (Go 자극에 반응하지 않은 횟수) |
| `totalStimuli` | int | 총 자극 수 |
| `anticipatoryResponses` | int | 예측 반응 횟수 |
| `reactionTimes` | List\<int\> | 개별 반응 시간 목록 |

### 1. 억제 비율 (Inhibition Rate) 계산

**억제 비율**은 No-go 자극에 대해 얼마나 잘 반응을 억제했는지를 나타냅니다.

```dart
// No-go 자극 수 (전체의 25%, 기획서 기준)
noGoCount = (totalStimuli * 0.25).round()

// 정확히 억제한 수
correctInhibitions = noGoCount - commissionErrors

// 억제 비율 계산
inhibitionRate = correctInhibitions / noGoCount
```

- **범위**: 0.0 ~ 1.0
- **해석**: 높을수록 좋음 (자기통제 능력이 좋음)

### 2. 빠른 반응자 판정

```dart
isFastReactor = avgReactionTime < peerMeanReactionTime
```

### 3. Z점수 계산

```dart
inhibitionZ = (observedInhibitionRate - peerMean) / peerStdDev
```

---

## Z점수 계산 및 시각화

### Z점수 범위와 해석

| Z점수 범위 | 해석 | UI 색상 |
|-----------|------|---------|
| z > +1 | 또래 평균 이상 | 🔵 파란색 |
| -1 ≤ z ≤ +1 | 또래 평균 범위 | 🟢 초록색 |
| z < -1 | 발달 중 | 🟠 주황색 |

### Z점수 → 시각화 점수 변환

결과 차트에서 Z점수를 0~100 범위의 시각적 위치로 변환합니다.

```dart
// Z점수를 -2 ~ +2 범위로 클램핑
clampedZ = zScore.clamp(-2.0, 2.0)

// 0-100 범위로 변환
// -2 → 0%, 0 → 50%, +2 → 100%
visualPosition = ((clampedZ + 2) / 4) * 100
```

**변환 예시:**
| Z점수 | 시각화 위치 |
|-------|-----------|
| -2.0 | 0% |
| -1.0 | 25% |
| 0.0 | 50% |
| +1.0 | 75% |
| +2.0 | 100% |

### 결과 차트 구성

```
[발달 중] ─────[회색 띠: 또래 평균 범위]───── [우수]
           25%          50%          75%
                     (z=0)
```

- **회색 띠**: Z점수 -1 ~ +1 범위 (또래 평균 범위)
- **파란 점**: 내 아이의 위치

---

## 월령별 규준값

### 주의력 테스트 규준

연구 기반 참고 규준값입니다.

#### MER (Memory Efficiency Ratio)

| 월령 | 평균 (Mean) | 표준편차 (SD) |
|-----|------------|--------------|
| 36-41개월 | 0.42 | 0.15 |
| 42-47개월 | 0.55 | 0.14 |
| 48-53개월 | 0.68 | 0.12 |
| 54-60개월 | 0.78 | 0.10 |

#### 재확인율 (Revisiting Rate)

| 월령 | 평균 (Mean) | 표준편차 (SD) |
|-----|------------|--------------|
| 36-41개월 | 0.30 | 0.10 |
| 42-47개월 | 0.22 | 0.08 |
| 48-53개월 | 0.14 | 0.06 |
| 54-60개월 | 0.08 | 0.05 |

#### 반응시간 (초)

| 월령 | 최소 | 최대 |
|-----|-----|-----|
| 36-41개월 | 3.0 | 4.5 |
| 42-47개월 | 2.5 | 3.5 |
| 48-53개월 | 2.0 | 3.0 |
| 54-60개월 | 1.5 | 2.5 |

### 충동성 테스트 규준

Wiebe SA (2012) 연구 기반.

#### 억제 비율 (Inhibition Rate)

| 월령 | 평균 (Mean) | 표준편차 (SD) |
|-----|------------|--------------|
| 36-47개월 | 0.74 | 0.312 |
| 48-59개월 | 0.84 | 0.206 |
| 60-72개월 | 0.89 | 0.137 |

#### 반응시간 (ms)

| 월령 | 평균 (Mean) | 표준편차 (SD) |
|-----|------------|--------------|
| 36-47개월 | 934 | 200 |
| 48-59개월 | 835 | 180 |
| 60-72개월 | 733 | 150 |

---

## 행동 패턴 분류

### 주의력 테스트 - 4가지 행동 패턴

분류 기준:
- **MER 수준**: Z점수 ≥ 0 (평균 이상) vs Z점수 < 0 (평균 이하)
- **재확인율 수준**: Z점수 ≥ 0 (평균 이하, 좋음) vs Z점수 < 0 (평균 이상, 높음)
- **반응속도**: 중앙값 기준 빠름 vs 느림

| 패턴 | MER | 재확인율 | 반응속도 | 설명 |
|-----|-----|---------|---------|------|
| 🔬 **신중한 탐색가** (Careful Explorer) | 높음 | 낮음 | 느림 | 차분하게 생각하며 정확하게 기억하는 타입 |
| ⚡ **빠른 처리형** (Quick Processor) | 높음 | 낮음 | 빠름 | 빠르게 처리하면서도 정확한 타입 |
| 🌪️ **에너지 탐색형** (Energetic Explorer) | 낮음 | 높음 | 빠름 | 활발하게 탐색하며 경험을 쌓는 타입 |
| 📚 **성실한 시도형** (Diligent Trier) | 낮음 | 높음 | 느림 | 꼼꼼하게 확인하며 학습하는 타입 |

```dart
if (isHighMer && isLowRevisit) {
  // MER 높고 재확인율 낮음
  return isSlowReaction 
    ? carefulExplorer 
    : quickProcessor;
} else {
  // MER 낮거나 재확인율 높음
  return isSlowReaction 
    ? diligentTrier 
    : energeticExplorer;
}
```

### 충동성 테스트 - 4분면 행동 패턴

분류 기준:
- **억제 비율 수준**: Z점수 ≥ 0 (평균 이상, 높음) vs Z점수 < 0 (평균 이하, 낮음)
- **반응 속도**: 또래 평균보다 빠름 vs 느림

| 패턴 | 억제비율 | 반응속도 | 설명 |
|-----|---------|---------|------|
| ⚡ **빠르게 반응하지만 멈출 줄 아는 아이** (Quick & Controlled) | 높음 | 빠름 | 빠르게 반응하면서도 자기통제가 좋음 |
| 🔥 **에너지가 먼저 나오는 아이** (Energy First) | 낮음 | 빠름 | 활발하고 즉각적으로 반응하는 성향 |
| 🧘 **차분하고 안정적인 아이** (Calm & Stable) | 높음 | 느림 | 신중하게 생각하고 자기통제가 좋음 |
| 📖 **천천히 익혀가는 단계의 아이** (Learning at Own Pace) | 낮음 | 느림 | 자기 속도로 배워가는 단계 |

```dart
if (isFastReactor) {
  return isHighInhibition 
    ? quickAndControlled 
    : energyFirst;
} else {
  return isHighInhibition 
    ? calmAndStable 
    : learningAtOwnPace;
}
```

---

## 결과 표시 정책

### 1. 숫자 Z점수 비노출 정책

- **정책**: Z점수 숫자 값은 UI에 직접 노출하지 않음
- **이유**: 부모가 불필요한 수치에 집착하는 것을 방지
- **대안**: 텍스트 라벨로 표시 (예: "또래 평균", "기억력 발달 중", "뛰어난 자기통제")

### 2. 긍정적 프레이밍 정책

모든 결과는 부정적인 표현 대신 긍정적/중립적 표현을 사용합니다.

| 영역 | 낮은 점수 | 평균 | 높은 점수 |
|-----|----------|-----|----------|
| 주의력 | "발달 중인 기억력" | "또래 평균" | "높은 기억 효율" |
| 충동성 | "높은 에너지" | "또래 평균" | "좋은 자기통제" |

### 3. 색상 코딩

| 상태 | 색상 | 의미 |
|-----|------|------|
| 🟢 초록 | `Colors.green` | 또래 평균 범위 내 |
| 🔵 파랑 | `Colors.blue` | 또래 평균 이상 |
| 🟠 주황 | `Colors.orange` | 발달 중 (관심 필요) |

### 4. 레거시 모드 지원

월령 정보가 없는 경우 기존 방식으로 계산:

```dart
// 주의력 테스트 레거시
errorPenalty = (errors * 10).clamp(0, 50)
durationPenalty = (durationSeconds / 2).clamp(0, 40)
visualScore = 100 - (errorPenalty + durationPenalty)

// 충동성 테스트 레거시
visualScore = (100 - (commissionErrors * 15)).clamp(10, 90)
```

---

## 결과 데이터 구조

### ReportData 모델

```dart
class ReportData {
  // 시각화용 점수 (0-100, Z점수 기반으로 변환됨)
  final double visualScore;
  
  // 행동 스타일 제목 (예: "신중한 탐색가")
  final String title;
  
  // 행동 스타일 설명
  final String description;
  
  // 양육 팁 목록
  final List<String> tips;
  
  // 그래프 왼쪽/오른쪽 라벨
  final String lowLabel;
  final String highLabel;
  
  // Z점수 결과 (선택적)
  final ZScoreResult? zScoreResult;
  
  // 상세 분석 결과 (선택적)
  final AttentionAnalysisResult? attentionAnalysis;
  final ImpulsivityAnalysisResult? impulsivityAnalysis;
}
```

---

## 참고문헌

1. Abdul Rahman A, et al. (2017). *Development of visual working memory in preschoolers*. Dev Neuropsychol.

2. Oeri N, et al. (2019). *The development of inhibitory control in early childhood*. Front. Psychol.

3. Wiebe SA, et al. (2012). *The development of executive function in early childhood*. Child Dev.

---

## 파일 구조

```
lib/
├── features/report/
│   ├── calculators/
│   │   ├── attention_report_calculator.dart   # 주의력 결과 계산기
│   │   └── impulsivity_report_calculator.dart # 충동성 결과 계산기
│   ├── providers/
│   │   └── report_provider.dart               # 리포트 Provider
│   ├── widgets/
│   │   ├── behavior_style_card.dart           # 행동 스타일 카드
│   │   ├── key_metrics_card.dart              # 핵심 지표 카드
│   │   ├── result_chart.dart                  # Z점수 기반 차트
│   │   ├── result_interpretation_card.dart    # 결과 해석 카드
│   │   └── parenting_tips_card.dart           # 양육 팁 카드
│   └── report_screen.dart                     # 결과 화면
├── core/
│   ├── constants/
│   │   └── age_norms.dart                     # 월령별 규준값
│   ├── domain/
│   │   └── report_calculator.dart             # 계산기 인터페이스
│   └── utils/
│       └── z_score_calculator.dart            # Z점수 계산 유틸리티
└── models/
    ├── attention_result.dart                  # 주의력 결과 모델
    ├── impulsivity_result.dart                # 충동성 결과 모델
    ├── report_data.dart                       # 리포트 데이터 모델
    └── z_score_result.dart                    # Z점수 결과 모델
```

---

*Last Updated: 2024-12-24*
*Updated: 기획서(12/22 웹페이지 판단 알고리즘 구성) 반영*

