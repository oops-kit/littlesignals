import 'dart:async';

/// 힌트 타이머 관리 클래스
///
/// 일정 시간 동안 카드를 뒤집지 않으면 힌트를 표시합니다.
class HintTimerController {
  HintTimerController({
    required this.delaySeconds,
    required this.hintDurationSeconds,
    required this.onShowHint,
    required this.onHideHint,
  });

  /// 힌트 표시까지 대기 시간 (초)
  final int delaySeconds;

  /// 힌트 표시 지속 시간 (초)
  final int hintDurationSeconds;

  /// 힌트 표시 콜백
  final void Function() onShowHint;

  /// 힌트 숨김 콜백
  final void Function() onHideHint;

  Timer? _delayTimer;
  Timer? _hideTimer;
  bool _isDisposed = false;

  /// 힌트 타이머 시작
  void start() {
    if (_isDisposed) return;
    cancel();

    _delayTimer = Timer(Duration(seconds: delaySeconds), () {
      if (_isDisposed) return;
      onShowHint();

      _hideTimer = Timer(Duration(seconds: hintDurationSeconds), () {
        if (_isDisposed) return;
        onHideHint();
      });
    });
  }

  /// 힌트 타이머 취소
  void cancel() {
    _delayTimer?.cancel();
    _delayTimer = null;
    _hideTimer?.cancel();
    _hideTimer = null;
  }

  /// 리소스 정리
  void dispose() {
    _isDisposed = true;
    cancel();
  }
}

