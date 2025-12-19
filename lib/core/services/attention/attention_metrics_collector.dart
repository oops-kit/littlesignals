import 'package:littlesignals/core/domain/event_logger.dart';
import 'package:littlesignals/features/attention_test/providers/attention_test_state.dart';
import 'package:littlesignals/models/test_event_log.dart';

/// 주의력 테스트 관찰 지표 수집 서비스
///
/// SRP: 관찰 지표 수집 및 분석만 담당합니다.
/// - 무작위 터치 감지
/// - 즉시 반복 오류 감지
/// - 터치 패턴 분석
class AttentionMetricsCollector {
  AttentionMetricsCollector({
    required EventLogger logger,
    this.rapidTapThresholdMs = 300,
  }) : _logger = logger;

  final EventLogger _logger;

  /// 무작위 터치 감지 기준 (ms)
  final int rapidTapThresholdMs;

  /// 무작위 터치 여부 분석 (이미 뒤집힌/매치된 카드 터치)
  ///
  /// 반환: 무작위 터치 횟수 증가분 (0 또는 1)
  int checkInvalidTap({required bool isFlipped, required bool isMatched}) {
    if (isFlipped || isMatched) {
      final reason = isMatched ? '이미 맞춘 카드' : '이미 뒤집힌 카드';
      _logger.add(TestEventType.randomTap, '$reason를 다시 터치 (무작위 터치)');
      return 1;
    }
    return 0;
  }

  /// 빠른 연속 터치 감지
  ///
  /// 반환: (무작위 터치 증가분, 빠른 터치 여부)
  ({int randomTapIncrease, bool isRapidTap}) checkRapidTap({
    required DateTime currentTapTime,
    required List<TapRecord> tapRecords,
  }) {
    if (tapRecords.isEmpty) {
      return (randomTapIncrease: 0, isRapidTap: false);
    }

    final lastTap = tapRecords.last;
    final timeDiff = currentTapTime
        .difference(lastTap.timestamp)
        .inMilliseconds;

    if (timeDiff < rapidTapThresholdMs) {
      _logger.add(
        TestEventType.randomTap,
        '빠른 연속 터치 (${rapidTapThresholdMs}ms 이내)',
      );
      return (randomTapIncrease: 1, isRapidTap: true);
    }

    return (randomTapIncrease: 0, isRapidTap: false);
  }

  /// 즉시 반복 오류 감지 (방금 확인한 카드를 바로 다시 터치)
  ///
  /// 반환: (즉시 반복 오류 증가분, 즉시 반복 여부)
  ({int errorIncrease, bool isImmediateRepeat}) checkImmediateRepeat({
    required int cardId,
    required List<int> recentlyFlippedCardIds,
  }) {
    if (recentlyFlippedCardIds.contains(cardId)) {
      _logger.add(TestEventType.immediateRepeat, '방금 본 카드를 다시 터치 (작업기억 오류)');
      return (errorIncrease: 1, isImmediateRepeat: true);
    }
    return (errorIncrease: 0, isImmediateRepeat: false);
  }

  /// 카드 뒤집기 이벤트 로깅
  void logCardFlip(int level) {
    _logger.add(TestEventType.cardFlip, '카드 뒤집기 (레벨 $level)');
  }
}
