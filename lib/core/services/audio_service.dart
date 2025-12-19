import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'audio_service.g.dart';

/// Audio service for playing sound effects
class AudioService {
  AudioService() : _player = AudioPlayer();

  final AudioPlayer _player;

  /// Play a success sound (match found, correct tap)
  Future<void> playSuccess() async {
    // In production, you would use:
    // await _player.play(AssetSource('audio/success.mp3'));
    // For now, we'll use system sounds or skip
  }

  /// Play an error sound (wrong tap)
  Future<void> playError() async {
    // In production, you would use:
    // await _player.play(AssetSource('audio/error.mp3'));
  }

  /// Play a pop sound (bubble/balloon pop)
  Future<void> playPop() async {
    // In production, you would use:
    // await _player.play(AssetSource('audio/pop.mp3'));
  }

  /// Play a card flip sound
  Future<void> playFlip() async {
    // In production, you would use:
    // await _player.play(AssetSource('audio/flip.mp3'));
  }

  /// Play level complete sound
  Future<void> playLevelComplete() async {
    // In production, you would use:
    // await _player.play(AssetSource('audio/level_complete.mp3'));
  }

  void dispose() {
    _player.dispose();
  }
}

@riverpod
AudioService audioService(Ref ref) {
  final service = AudioService();
  ref.onDispose(() => service.dispose());
  return service;
}
