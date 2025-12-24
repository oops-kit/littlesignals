// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'impulsivity_test_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$impulsivityTestControllerHash() =>
    r'8aad856f2abd313972eea1e6040f3f6065d85602';

/// 충동성 테스트 컨트롤러
///
/// 게임 흐름을 조율하고, 세부 로직은 전문 서비스에 위임합니다.
/// SRP: 게임 흐름 조율에만 집중
/// DIP: EventLogger, BalloonTapHandler는 인터페이스/서비스를 통해 사용
///
/// Copied from [ImpulsivityTestController].
@ProviderFor(ImpulsivityTestController)
final impulsivityTestControllerProvider =
    AutoDisposeNotifierProvider<
      ImpulsivityTestController,
      ImpulsivityTestState
    >.internal(
      ImpulsivityTestController.new,
      name: r'impulsivityTestControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$impulsivityTestControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ImpulsivityTestController = AutoDisposeNotifier<ImpulsivityTestState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
