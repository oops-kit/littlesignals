// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attention_test_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$attentionTestControllerHash() =>
    r'b76ac24bfa547adfcd915ace2e27c9b6c6caeccf';

/// 주의력 테스트 컨트롤러
///
/// 게임 흐름을 조율하고, 세부 로직은 전문 서비스에 위임합니다.
/// SRP: 게임 흐름 조율에만 집중
/// DIP: DeckGenerator, EventLogger, 각 서비스는 인터페이스를 통해 사용
///
/// Copied from [AttentionTestController].
@ProviderFor(AttentionTestController)
final attentionTestControllerProvider =
    AutoDisposeNotifierProvider<
      AttentionTestController,
      AttentionTestState
    >.internal(
      AttentionTestController.new,
      name: r'attentionTestControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$attentionTestControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AttentionTestController = AutoDisposeNotifier<AttentionTestState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
