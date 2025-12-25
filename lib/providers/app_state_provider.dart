import 'dart:developer' as developer;
import 'package:littlesignals/models/app_state.dart';
import 'package:littlesignals/models/attention_result.dart';
import 'package:littlesignals/models/child_profile.dart';
import 'package:littlesignals/models/impulsivity_result.dart';
import 'package:littlesignals/providers/debug_log_provider.dart';
import 'package:littlesignals/providers/debug_mode_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AppStateNotifier extends _$AppStateNotifier {
  @override
  AppState build() {
    // #region agent log
    developer.log(
      '[DEBUG][HypH] AppStateNotifier.build() called - provider (re)initialized',
      name: 'AppState',
    );
    // #endregion
    return const AppState();
  }

  void setProfile(ChildProfile profile) {
    state = state.copyWith(profile: profile);
  }

  void setActiveTest(TestType testType) {
    // #region agent log
    developer.log(
      '[DEBUG][HypA] setActiveTest called: $testType, before state=$state',
      name: 'AppState',
    );
    // #endregion
    state = state.copyWith(activeTest: testType);
    // #region agent log
    developer.log(
      '[DEBUG][HypG] setActiveTest after: state.activeTest=${state.activeTest}',
      name: 'AppState',
    );
    // #endregion
  }

  void clearActiveTest() {
    state = state.copyWith(activeTest: null);
  }

  void setAttentionResult(AttentionResult result) {
    // #region agent log
    developer.log(
      '[DEBUG][HypC,E] setAttentionResult called: $result',
      name: 'AppState',
    );
    // #endregion
    state = state.copyWith(attentionResult: result);
    
    // 디버그 로그에 결과 메트릭 추가
    if (ref.read(debugModeProvider)) {
      _logAttentionMetrics(result);
    }
  }
  
  void _logAttentionMetrics(AttentionResult result) {
    final debugLog = ref.read(debugLogProvider.notifier);
    
    debugLog.addLog(
      '===== 집중력 테스트 결과 =====',
      level: DebugLogLevel.success,
    );
    
    // 기본 정보
    debugLog.addLog(
      '⏱ 소요 시간: ${result.durationSeconds.toStringAsFixed(1)}초',
      level: DebugLogLevel.info,
    );
    
    debugLog.addLog(
      '✅ 완료 상태: ${result.completionStatus.name}',
      level: result.isCompleted ? DebugLogLevel.success : DebugLogLevel.warning,
    );
    
    // 이동 및 카드 정보
    debugLog.addLog(
      '🎯 총 이동 횟수: ${result.totalMoves}회',
      level: DebugLogLevel.info,
    );
    
    debugLog.addLog(
      '🎴 확인한 카드: ${result.uniqueCardsRevealed}장',
      level: DebugLogLevel.info,
    );
    
    debugLog.addLog(
      '🔄 총 턴 수: ${result.totalTurns}턴',
      level: DebugLogLevel.info,
    );
    
    // 오류 정보
    debugLog.addLog(
      '❌ 총 오류 횟수: ${result.errors}회',
      level: result.errors > 5 ? DebugLogLevel.warning : DebugLogLevel.info,
    );
    
    debugLog.addLog(
      '🔄 재확인 오류: ${result.revisitCount}회',
      level: DebugLogLevel.info,
    );
    
    debugLog.addLog(
      '🧠 작업기억 오류: ${result.immediateRepeatErrors}회',
      level: result.immediateRepeatErrors > 3 ? DebugLogLevel.warning : DebugLogLevel.info,
    );
    
    debugLog.addLog(
      '🎲 무작위 터치: ${result.randomTapCount}회',
      level: result.randomTapCount > 5 ? DebugLogLevel.warning : DebugLogLevel.info,
    );
    
    // 효율성 지표
    final mer = result.uniqueCardsRevealed > 0 
        ? result.totalMoves / (result.uniqueCardsRevealed / 2) 
        : 0.0;
    debugLog.addLog(
      '📊 기억 효율(MER): ${mer.toStringAsFixed(2)}',
      level: DebugLogLevel.info,
    );
    
    final revisitRate = result.totalMoves > 0
        ? (result.revisitCount / result.totalMoves * 100) 
        : 0.0;
    debugLog.addLog(
      '🔁 재확인율: ${revisitRate.toStringAsFixed(1)}%',
      level: DebugLogLevel.info,
    );
    
    // 전반부/후반부 비교
    debugLog.addLog(
      '📈 전반부: ${result.firstHalfDurationSeconds.toStringAsFixed(1)}초 (${result.firstHalfTaps}회)',
      level: DebugLogLevel.info,
    );
    
    debugLog.addLog(
      '📉 후반부: ${result.secondHalfDurationSeconds.toStringAsFixed(1)}초 (${result.secondHalfTaps}회)',
      level: DebugLogLevel.info,
    );
    
    // 지속성 분석
    if (result.firstHalfDurationSeconds > 0 && result.secondHalfDurationSeconds > 0) {
      final speedRatio = result.secondHalfDurationSeconds / result.firstHalfDurationSeconds;
      debugLog.addLog(
        '⚡ 속도 변화: ${speedRatio > 1 ? "느려짐" : "빨라짐"} (${(speedRatio * 100).toStringAsFixed(0)}%)',
        level: speedRatio > 1.2 ? DebugLogLevel.warning : DebugLogLevel.info,
      );
    }
    
    // 반응 시간 통계
    if (result.reactionTimesMs.isNotEmpty) {
      final avgReaction = result.reactionTimesMs.reduce((a, b) => a + b) / result.reactionTimesMs.length;
      final minReaction = result.reactionTimesMs.reduce((a, b) => a < b ? a : b);
      final maxReaction = result.reactionTimesMs.reduce((a, b) => a > b ? a : b);
      
      debugLog.addLog(
        '⏱ 평균 반응: ${avgReaction.toStringAsFixed(0)}ms',
        level: DebugLogLevel.info,
      );
      
      debugLog.addLog(
        '🏃 최소/최대: ${minReaction}ms / ${maxReaction}ms',
        level: DebugLogLevel.info,
      );
    }
    
    // 힌트 사용
    if (result.hintUsedCount > 0) {
      debugLog.addLog(
        '💡 힌트 사용: ${result.hintUsedCount}회',
        level: DebugLogLevel.warning,
      );
    }
    
    debugLog.addLog(
      '===========================',
      level: DebugLogLevel.success,
    );
  }

  void setImpulsivityResult(ImpulsivityResult result) {
    // #region agent log
    developer.log(
      '[DEBUG][HypC,E] setImpulsivityResult called: $result',
      name: 'AppState',
    );
    // #endregion
    state = state.copyWith(impulsivityResult: result);
    
    // 디버그 로그에 결과 메트릭 추가
    if (ref.read(debugModeProvider)) {
      _logImpulsivityMetrics(result);
    }
  }
  
  void _logImpulsivityMetrics(ImpulsivityResult result) {
    final debugLog = ref.read(debugLogProvider.notifier);
    
    debugLog.addLog(
      '===== 충동성 테스트 결과 =====',
      level: DebugLogLevel.success,
    );
    
    // 기본 정보
    debugLog.addLog(
      '⏱ 소요 시간: ${result.durationSeconds.toStringAsFixed(1)}초',
      level: DebugLogLevel.info,
    );
    
    debugLog.addLog(
      '✅ 완료 상태: ${result.completionStatus}',
      level: result.isCompleted ? DebugLogLevel.success : DebugLogLevel.warning,
    );
    
    debugLog.addLog(
      '🎈 총 자극 개수: ${result.totalStimuli}개',
      level: DebugLogLevel.info,
    );
    
    // 오류 정보
    final totalErrors = result.commissionErrors + result.omissionErrors;
    debugLog.addLog(
      '❌ 총 오류: ${totalErrors}회',
      level: totalErrors > 8 ? DebugLogLevel.warning : DebugLogLevel.info,
    );
    
    debugLog.addLog(
      '💥 충동성 오류: ${result.commissionErrors}회',
      level: result.commissionErrors > 5 ? DebugLogLevel.warning : DebugLogLevel.info,
    );
    
    debugLog.addLog(
      '😴 부주의 오류: ${result.omissionErrors}회',
      level: result.omissionErrors > 3 ? DebugLogLevel.warning : DebugLogLevel.info,
    );
    
    debugLog.addLog(
      '⏰ 조급한 반응: ${result.anticipatoryResponses}회',
      level: result.anticipatoryResponses > 3 ? DebugLogLevel.warning : DebugLogLevel.info,
    );
    
    // 정확도 및 억제율
    final accuracy = result.totalStimuli > 0
        ? ((result.totalStimuli - totalErrors) / result.totalStimuli * 100)
        : 0.0;
    debugLog.addLog(
      '🎯 정확도: ${accuracy.toStringAsFixed(1)}%',
      level: DebugLogLevel.info,
    );
    
    final inhibitionRate = result.totalStimuli > 0
        ? ((result.totalStimuli - result.commissionErrors) / result.totalStimuli * 100)
        : 0.0;
    debugLog.addLog(
      '🛑 억제율: ${inhibitionRate.toStringAsFixed(1)}%',
      level: DebugLogLevel.info,
    );
    
    // 반응 시간 통계
    debugLog.addLog(
      '⚡ 평균 반응: ${result.reactionTimeAverage.toStringAsFixed(0)}ms',
      level: DebugLogLevel.info,
    );
    
    if (result.reactionTimes.isNotEmpty) {
      final minReaction = result.reactionTimes.reduce((a, b) => a < b ? a : b);
      final maxReaction = result.reactionTimes.reduce((a, b) => a > b ? a : b);
      final validReactions = result.reactionTimes.where((t) => t > 0).toList();
      
      debugLog.addLog(
        '🏃 최소/최대: ${minReaction}ms / ${maxReaction}ms',
        level: DebugLogLevel.info,
      );
      
      debugLog.addLog(
        '📊 반응 횟수: ${validReactions.length}회',
        level: DebugLogLevel.info,
      );
      
      // 반응 시간 분산 (일관성)
      if (validReactions.length > 1) {
        final mean = validReactions.reduce((a, b) => a + b) / validReactions.length;
        final variance = validReactions
            .map((t) => (t - mean) * (t - mean))
            .reduce((a, b) => a + b) / validReactions.length;
        final stdDev = variance < 0 ? 0.0 : variance;
        
        debugLog.addLog(
          '📐 반응 일관성: ${stdDev.toStringAsFixed(0)} (낮을수록 일관적)',
          level: DebugLogLevel.info,
        );
      }
    }
    
    debugLog.addLog(
      '===========================',
      level: DebugLogLevel.success,
    );
  }

  void clearResults() {
    state = state.copyWith(attentionResult: null, impulsivityResult: null);
  }

  void reset() {
    state = const AppState();
  }
}
