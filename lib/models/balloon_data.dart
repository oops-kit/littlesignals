import 'package:freezed_annotation/freezed_annotation.dart';

part 'balloon_data.freezed.dart';

/// 충동성 테스트의 게임 상태
enum ImpulsivityGameState { intro, countdown, playing, finished }

/// 풍선 탭 상태
enum BalloonTapState {
  /// 아직 터치되지 않음
  none,

  /// 파란 풍선 정확히 터치 (성공)
  correctTap,

  /// 빨간 풍선 터치 (실수)
  incorrectTap,

  /// 시간 초과로 사라짐
  timeout,
}

/// 충동성 테스트에서 사용되는 풍선 데이터
@freezed
abstract class BalloonData with _$BalloonData {
  const factory BalloonData({
    required int id,
    required bool isBlue,
    required double x,
    required double y,
    required DateTime spawnTime,
    @Default(BalloonTapState.none) BalloonTapState tapState,
  }) = _BalloonData;
}
