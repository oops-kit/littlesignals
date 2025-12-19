// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reportCalculatorHash() => r'3cf39c75dd5ca148223a001372dd960895e6b901';

/// 테스트 타입에 따른 ReportCalculator를 반환하는 Provider
///
/// Strategy 패턴을 적용하여 테스트 타입별로 적절한 계산기를 주입합니다.
///
/// Copied from [reportCalculator].
@ProviderFor(reportCalculator)
final reportCalculatorProvider = AutoDisposeProvider<ReportCalculator>.internal(
  reportCalculator,
  name: r'reportCalculatorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reportCalculatorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReportCalculatorRef = AutoDisposeProviderRef<ReportCalculator>;
String _$isAttentionTestHash() => r'1a5cf3525a79a18ca3b6f379d41619cc3371c920';

/// 현재 테스트 타입 Provider
///
/// Copied from [isAttentionTest].
@ProviderFor(isAttentionTest)
final isAttentionTestProvider = AutoDisposeProvider<bool>.internal(
  isAttentionTest,
  name: r'isAttentionTestProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAttentionTestHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAttentionTestRef = AutoDisposeProviderRef<bool>;
String _$hasTestResultHash() => r'da7208ec93f9e73264929aa3d6c223f5d53d10d4';

/// 현재 테스트 결과가 있는지 확인하는 Provider
///
/// Copied from [hasTestResult].
@ProviderFor(hasTestResult)
final hasTestResultProvider = AutoDisposeProvider<bool>.internal(
  hasTestResult,
  name: r'hasTestResultProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasTestResultHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasTestResultRef = AutoDisposeProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
