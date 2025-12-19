// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_mode_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$debugModeHash() => r'71c7d175661fa55bf3e72037dcdfd8f9651e9427';

/// 디버그 모드 상태 관리
///
/// 디버그 모드가 활성화되면 테스트 중 발생하는 이벤트 로그를
/// 실시간으로 toast로 표시합니다.
///
/// Copied from [DebugMode].
@ProviderFor(DebugMode)
final debugModeProvider = NotifierProvider<DebugMode, bool>.internal(
  DebugMode.new,
  name: r'debugModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$debugModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DebugMode = Notifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
