import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_mode_provider.g.dart';

/// 디버그 모드 상태 관리
///
/// 디버그 모드가 활성화되면 테스트 중 발생하는 이벤트 로그를
/// 실시간으로 toast로 표시합니다.
@Riverpod(keepAlive: true)
class DebugMode extends _$DebugMode {
  @override
  bool build() => false;

  void toggle() => state = !state;

  void setEnabled(bool enabled) => state = enabled;
}
