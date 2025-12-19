import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:littlesignals/models/card_data.dart';
import 'package:littlesignals/models/test_event_log.dart';

part 'attention_test_state.freezed.dart';

/// 주의력 테스트의 게임 상태
enum AttentionGameState { countdown, playing, finished }

/// 터치 기록 데이터 (지속성 분석용)
@freezed
abstract class TapRecord with _$TapRecord {
  const factory TapRecord({required DateTime timestamp, required int cardId}) =
      _TapRecord;
}

/// 주의력 테스트의 상태
@freezed
abstract class AttentionTestState with _$AttentionTestState {
  const factory AttentionTestState({
    @Default(AttentionGameState.countdown) AttentionGameState gameState,
    @Default(null) int? countdownValue,
    @Default(1) int level,
    @Default([]) List<CardData> cards,
    @Default([]) List<int> flippedCardIds,
    @Default(false) bool isProcessing,
    @Default(null) DateTime? startTime,
    @Default(0) int moves,
    @Default(0) int errors,
    @Default(null) int? hintCardId,
    @Default(false) bool isCompleted,
    // === 관찰 지표 필드 ===
    /// 무작위 터치 횟수 (짧은 시간 내 연속 터치, 패턴 없이 터치)
    @Default(0) int randomTaps,

    /// 즉시 반복 오류 (방금 확인한 카드를 바로 다시 터치)
    @Default(0) int immediateRepeatErrors,

    /// 모든 터치 기록 (지속성 분석용)
    @Default([]) List<TapRecord> tapRecords,

    /// 마지막으로 뒤집은 카드 ID 목록 (최근 2개)
    @Default([]) List<int> recentlyFlippedCardIds,

    /// 전반부 완료 시간 (첫 번째 레벨 또는 전반 50% 완료)
    @Default(null) DateTime? firstHalfEndTime,

    /// 전반부 터치 횟수
    @Default(0) int firstHalfTaps,

    /// 후반부 터치 횟수
    @Default(0) int secondHalfTaps,

    /// 이벤트 로그 (테스트 중 발생한 모든 이벤트)
    @Default([]) List<TestEventLog> eventLogs,
  }) = _AttentionTestState;
}
