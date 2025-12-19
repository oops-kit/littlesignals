import 'package:freezed_annotation/freezed_annotation.dart';

part 'balloon_data.freezed.dart';

/// 충동성 테스트의 게임 상태
enum ImpulsivityGameState { intro, playing, finished }

/// 충동성 테스트에서 사용되는 풍선 데이터
@freezed
abstract class BalloonData with _$BalloonData {
  const factory BalloonData({
    required int id,
    required bool isBlue,
    required double x,
    required double y,
    required DateTime spawnTime,
  }) = _BalloonData;
}
