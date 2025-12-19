import 'package:littlesignals/core/domain/event_logger.dart';
import 'package:littlesignals/models/card_data.dart';
import 'package:littlesignals/models/test_event_log.dart';

/// 카드 매칭 결과
enum MatchResult {
  /// 매칭 성공
  success,

  /// 매칭 실패
  failure,
}

/// 카드 매칭 서비스
///
/// SRP: 카드 매칭 로직만 담당합니다.
/// - 두 카드가 같은지 확인
/// - 매칭 결과 로깅
class CardMatchingService {
  CardMatchingService({required EventLogger logger}) : _logger = logger;

  final EventLogger _logger;

  /// 두 카드가 매칭되는지 확인
  ///
  /// [cards]: 전체 카드 목록
  /// [flippedIds]: 뒤집힌 카드 ID 목록 (2개)
  /// [currentErrorCount]: 현재 오류 횟수 (로깅용)
  ///
  /// 반환: 매칭 결과
  MatchResult checkMatch({
    required List<CardData> cards,
    required List<int> flippedIds,
    required int currentErrorCount,
  }) {
    if (flippedIds.length != 2) {
      throw ArgumentError('flippedIds must contain exactly 2 card IDs');
    }

    final card1 = cards.firstWhere((c) => c.id == flippedIds[0]);
    final card2 = cards.firstWhere((c) => c.id == flippedIds[1]);

    if (card1.name == card2.name) {
      _logger.add(TestEventType.matchSuccess, '짝 찾기 성공! 🎉');
      return MatchResult.success;
    } else {
      _logger.add(
        TestEventType.matchFail,
        '짝이 아니에요 (오류 ${currentErrorCount + 1}회)',
      );
      return MatchResult.failure;
    }
  }

  /// 매칭된 카드들을 업데이트
  ///
  /// [cards]: 전체 카드 목록
  /// [flippedIds]: 매칭된 카드 ID 목록
  ///
  /// 반환: 업데이트된 카드 목록
  List<CardData> markAsMatched({
    required List<CardData> cards,
    required List<int> flippedIds,
  }) {
    return cards.map((c) {
      if (flippedIds.contains(c.id)) {
        return c.copyWith(isMatched: true);
      }
      return c;
    }).toList();
  }

  /// 카드 뒤집기 취소 (매칭 실패 시)
  ///
  /// [cards]: 전체 카드 목록
  /// [flippedIds]: 뒤집힌 카드 ID 목록
  ///
  /// 반환: 업데이트된 카드 목록
  List<CardData> flipBack({
    required List<CardData> cards,
    required List<int> flippedIds,
  }) {
    return cards.map((c) {
      if (flippedIds.contains(c.id)) {
        return c.copyWith(isFlipped: false);
      }
      return c;
    }).toList();
  }

  /// 모든 카드가 매칭되었는지 확인
  bool isAllMatched(List<CardData> cards) {
    return cards.every((c) => c.isMatched);
  }
}
