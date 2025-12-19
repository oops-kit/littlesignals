import 'package:freezed_annotation/freezed_annotation.dart';

import 'attention_result.dart';
import 'child_profile.dart';
import 'impulsivity_result.dart';

part 'app_state.freezed.dart';

enum TestType { attention, impulsivity }

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    ChildProfile? profile,
    TestType? activeTest,
    AttentionResult? attentionResult,
    ImpulsivityResult? impulsivityResult,
  }) = _AppState;
}
