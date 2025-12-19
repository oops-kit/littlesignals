import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlesignals/core/domain/deck_generator.dart';
import 'package:littlesignals/core/domain/event_logger.dart';
import 'package:littlesignals/core/utils/card_deck_generator.dart';
import 'package:littlesignals/core/utils/event_log_recorder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'core_providers.g.dart';

/// EventLogger 의존성 주입 Provider
///
/// DIP를 위해 인터페이스를 통해 구체 구현체를 주입합니다.
/// 테스트 시 모킹이 용이합니다.
@riverpod
EventLogger eventLogger(Ref ref) {
  return EventLogRecorder();
}

/// DeckGenerator 의존성 주입 Provider
///
/// DIP를 위해 인터페이스를 통해 구체 구현체를 주입합니다.
/// 테스트 시 모킹이 용이합니다.
@riverpod
DeckGenerator deckGenerator(Ref ref) {
  return CardDeckGenerator();
}
