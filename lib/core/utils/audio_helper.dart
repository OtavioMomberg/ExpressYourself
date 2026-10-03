import 'package:audioplayers/audioplayers.dart';

final class AudioService._() {
  final buttonPlayer = AudioPlayer();
  final colorPlayer = AudioPlayer();

  static const _buttonAudio = "audios/button_click.mp3";
  static const _colorAudio = "audios/color_placement.mp3";

  static final _instance = AudioService._();
  factory instance() => _instance;

  Future<void> init() async {
    await buttonPlayer.setReleaseMode(.stop);
    await colorPlayer.setReleaseMode(.stop);

    await buttonPlayer.setPlayerMode(.lowLatency);
    await colorPlayer.setPlayerMode(.lowLatency);

    await buttonPlayer.setSource(AssetSource(_buttonAudio));
    await colorPlayer.setSource(AssetSource(_colorAudio));
  }

  void playButtonAudio() async {
    await buttonPlayer.stop();
    await buttonPlayer.resume();
  }
  
  void playColorAudio() async {
    await colorPlayer.stop();
    await colorPlayer.resume();
  }
}