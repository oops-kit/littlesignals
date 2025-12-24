import 'dart:async';
import 'dart:math';

import 'package:littlesignals/models/balloon_data.dart';

/// 풍선 스폰 관리 클래스
///
/// 충동성 테스트에서 풍선 생성과 타이머를 관리합니다.
class BalloonSpawnController {
  BalloonSpawnController({
    required this.minIntervalMs,
    required this.maxIntervalMs,
    required this.balloonDurationMs,
    required this.blueRatio,
    required this.onSpawn,
    required this.onTimeout,
  });

  /// 풍선 간 최소 간격 (ms)
  final int minIntervalMs;

  /// 풍선 간 최대 간격 (ms)
  final int maxIntervalMs;

  /// 풍선 표시 시간 (ms)
  final int balloonDurationMs;

  /// 파란 풍선 비율 (0.0 ~ 1.0)
  final double blueRatio;

  /// 풍선 생성 콜백
  final void Function(BalloonData balloon) onSpawn;

  /// 풍선 타임아웃 콜백
  final void Function(int balloonId, bool isBlue) onTimeout;

  final Random _random = Random();
  Timer? _spawnTimer;
  Timer? _balloonTimer;
  BalloonData? _currentBalloon;
  bool _isDisposed = false;

  /// 현재 표시 중인 풍선
  BalloonData? get currentBalloon => _currentBalloon;

  /// 다음 풍선 스케줄링
  void scheduleNext() {
    if (_isDisposed) return;

    // min == max인 경우 고정 간격, 아니면 랜덤 간격
    final delay = minIntervalMs == maxIntervalMs
        ? minIntervalMs
        : minIntervalMs + _random.nextInt(maxIntervalMs - minIntervalMs);

    _spawnTimer = Timer(Duration(milliseconds: delay), () {
      if (_isDisposed) return;
      _spawn();
    });
  }

  void _spawn() {
    if (_isDisposed) return;

    final isBlue = _random.nextDouble() < blueRatio;
    final x = _random.nextDouble() * 60 + 20;
    final y = _random.nextDouble() * 50 + 20;

    _currentBalloon = BalloonData(
      id: DateTime.now().millisecondsSinceEpoch,
      isBlue: isBlue,
      x: x,
      y: y,
      spawnTime: DateTime.now(),
    );

    onSpawn(_currentBalloon!);

    _balloonTimer = Timer(Duration(milliseconds: balloonDurationMs), () {
      if (_isDisposed) return;
      if (_currentBalloon != null) {
        onTimeout(_currentBalloon!.id, _currentBalloon!.isBlue);
      }
    });
  }

  /// 현재 풍선 클리어 (터치됨)
  void clearCurrentBalloon() {
    _balloonTimer?.cancel();
    _currentBalloon = null;
  }

  /// 풍선 스폰 취소
  void cancel() {
    _spawnTimer?.cancel();
    _spawnTimer = null;
    _balloonTimer?.cancel();
    _balloonTimer = null;
    _currentBalloon = null;
  }

  /// 리소스 정리
  void dispose() {
    _isDisposed = true;
    cancel();
  }
}

