import 'package:littlesignals/core/domain/event_logger.dart';
import 'package:littlesignals/models/balloon_data.dart';
import 'package:littlesignals/models/test_event_log.dart';

/// 풍선 터치 결과
sealed class BalloonTapResult {
  const BalloonTapResult();
}

/// 파란 풍선 성공적으로 터치
class BlueBalloonSuccess extends BalloonTapResult {
  const BlueBalloonSuccess({required this.reactionTimeMs});

  final int reactionTimeMs;
}

/// 빨간 풍선 터치 (충동성 오류)
class RedBalloonError extends BalloonTapResult {
  const RedBalloonError();
}

/// 풍선 터치 핸들러
///
/// SRP: 풍선 터치 처리 및 결과 분석만 담당합니다.
class BalloonTapHandler {
  BalloonTapHandler({required EventLogger logger}) : _logger = logger;

  final EventLogger _logger;

  /// 풍선 터치 처리
  ///
  /// [balloon]: 터치된 풍선
  /// [currentCommissionErrors]: 현재 충동성 오류 횟수 (로깅용)
  ///
  /// 반환: 터치 결과
  BalloonTapResult handleTap({
    required BalloonData balloon,
    required int currentCommissionErrors,
  }) {
    final reactionTime = DateTime.now()
        .difference(balloon.spawnTime)
        .inMilliseconds;

    if (balloon.isBlue) {
      _logger.add(
        TestEventType.blueBalloonTap,
        '파란 풍선 터치 성공! (${reactionTime}ms)',
        value: reactionTime,
      );
      return BlueBalloonSuccess(reactionTimeMs: reactionTime);
    } else {
      _logger.add(
        TestEventType.redBalloonTap,
        '빨간 풍선 터치! (충동성 오류 ${currentCommissionErrors + 1}회)',
      );
      return const RedBalloonError();
    }
  }

  /// 풍선 타임아웃 처리 (파란 풍선 놓침)
  ///
  /// [isBlue]: 파란 풍선인지 여부
  /// [currentOmissionErrors]: 현재 부주의 오류 횟수 (로깅용)
  void handleTimeout({
    required bool isBlue,
    required int currentOmissionErrors,
  }) {
    if (isBlue) {
      _logger.add(
        TestEventType.blueBalloonMiss,
        '파란 풍선 놓침 (부주의 ${currentOmissionErrors + 1}회)',
      );
    }
  }

  /// 예측 반응 처리 (풍선이 없을 때 화면 터치)
  ///
  /// [currentAnticipatoryResponses]: 현재 예측 반응 횟수 (로깅용)
  void handleAnticipatoryTap({required int currentAnticipatoryResponses}) {
    _logger.add(
      TestEventType.anticipatoryTap,
      '풍선이 없을 때 터치 (예측 반응 ${currentAnticipatoryResponses + 1}회)',
    );
  }
}
