import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxBool isVolumeOn = true.obs; // Reactive variable for volume state

  final List<AudioPlayer> _audioPlayers = [];

  void addAudioPlayer(AudioPlayer player) {
    _audioPlayers.add(player);
  }

  void removeAudioPlayer(AudioPlayer player) {
    _audioPlayers.remove(player);
  }

  void toggleVolume() {
    isVolumeOn.value = !isVolumeOn.value;
    log('Volume is ${isVolumeOn.value ? 'On' : 'Off'}');

    double volume = isVolumeOn.value ? 1.0 : 0.0;
    if (isVolumeOn.value) {
      for (var player in _audioPlayers) {
        player.setVolume(volume);
      }
    } else {
      for (var player in _audioPlayers) {
        player.setVolume(volume);
        player.stop(); // Stop audio when volume is off
      }
    }
    log('AudioPlayers volume set to $volume');
  }
}
