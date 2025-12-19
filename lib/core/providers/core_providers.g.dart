// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventLoggerHash() => r'164c047474282eb8967cb4c5d8f30348a4fa5a58';

/// EventLogger 의존성 주입 Provider
///
/// DIP를 위해 인터페이스를 통해 구체 구현체를 주입합니다.
/// 테스트 시 모킹이 용이합니다.
///
/// Copied from [eventLogger].
@ProviderFor(eventLogger)
final eventLoggerProvider = AutoDisposeProvider<EventLogger>.internal(
  eventLogger,
  name: r'eventLoggerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eventLoggerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EventLoggerRef = AutoDisposeProviderRef<EventLogger>;
String _$deckGeneratorHash() => r'd6600ff8bb44b93d8923821b4e8b5de98b8105f9';

/// DeckGenerator 의존성 주입 Provider
///
/// DIP를 위해 인터페이스를 통해 구체 구현체를 주입합니다.
/// 테스트 시 모킹이 용이합니다.
///
/// Copied from [deckGenerator].
@ProviderFor(deckGenerator)
final deckGeneratorProvider = AutoDisposeProvider<DeckGenerator>.internal(
  deckGenerator,
  name: r'deckGeneratorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deckGeneratorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeckGeneratorRef = AutoDisposeProviderRef<DeckGenerator>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
