import 'dart:async';

/// 카운트다운 타이머 관리 클래스
///
/// 게임 시작 전 3, 2, 1 카운트다운을 관리합니다.
/// 여러 테스트 컨트롤러에서 재사용할 수 있습니다.
class CountdownController {
  CountdownController({
    this.startValue = 3,
    required this.onTick,
    required this.onComplete,
  });

  /// 카운트다운 시작 값 (기본값: 3)
  final int startValue;

  /// 매 초마다 호출되는 콜백 (현재 값 전달)
  final void Function(int value) onTick;

  /// 카운트다운 완료 시 호출되는 콜백
  final VoidCallback onComplete;

  Timer? _timer;
  int _currentValue = 0;
  bool _isDisposed = false;

  /// 현재 카운트다운 값
  int get currentValue => _currentValue;

  /// 카운트다운이 실행 중인지 여부
  bool get isRunning => _timer?.isActive ?? false;

  /// 카운트다운 시작
  void start() {
    if (_isDisposed) return;

    _currentValue = startValue;
    onTick(_currentValue);

    _timer = Timer.periodic(const Duration(seconds: 1), _handleTick);
  }

  void _handleTick(Timer timer) {
    if (_isDisposed) {
      timer.cancel();
      return;
    }

    _currentValue--;

    if (_currentValue <= 0) {
      timer.cancel();
      onComplete();
    } else {
      onTick(_currentValue);
    }
  }

  /// 카운트다운 취소
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// 리소스 정리
  void dispose() {
    _isDisposed = true;
    cancel();
  }
}

/// VoidCallback typedef (dart:ui 없이 사용)
typedef VoidCallback = void Function();
