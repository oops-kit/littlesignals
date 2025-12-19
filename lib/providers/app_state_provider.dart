import 'dart:developer' as developer;
import 'package:littlesignals/models/app_state.dart';
import 'package:littlesignals/models/attention_result.dart';
import 'package:littlesignals/models/child_profile.dart';
import 'package:littlesignals/models/impulsivity_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AppStateNotifier extends _$AppStateNotifier {
  @override
  AppState build() {
    // #region agent log
    developer.log(
      '[DEBUG][HypH] AppStateNotifier.build() called - provider (re)initialized',
      name: 'AppState',
    );
    // #endregion
    return const AppState();
  }

  void setProfile(ChildProfile profile) {
    state = state.copyWith(profile: profile);
  }

  void setActiveTest(TestType testType) {
    // #region agent log
    developer.log(
      '[DEBUG][HypA] setActiveTest called: $testType, before state=$state',
      name: 'AppState',
    );
    // #endregion
    state = state.copyWith(activeTest: testType);
    // #region agent log
    developer.log(
      '[DEBUG][HypG] setActiveTest after: state.activeTest=${state.activeTest}',
      name: 'AppState',
    );
    // #endregion
  }

  void clearActiveTest() {
    state = state.copyWith(activeTest: null);
  }

  void setAttentionResult(AttentionResult result) {
    // #region agent log
    developer.log(
      '[DEBUG][HypC,E] setAttentionResult called: $result',
      name: 'AppState',
    );
    // #endregion
    state = state.copyWith(attentionResult: result);
  }

  void setImpulsivityResult(ImpulsivityResult result) {
    // #region agent log
    developer.log(
      '[DEBUG][HypC,E] setImpulsivityResult called: $result',
      name: 'AppState',
    );
    // #endregion
    state = state.copyWith(impulsivityResult: result);
  }

  void clearResults() {
    state = state.copyWith(attentionResult: null, impulsivityResult: null);
  }

  void reset() {
    state = const AppState();
  }
}
