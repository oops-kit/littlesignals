import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:littlesignals/models/attention_result.dart';
import 'package:littlesignals/models/child_profile.dart';
import 'package:littlesignals/models/impulsivity_result.dart';

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
