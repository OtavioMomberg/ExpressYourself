import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final buttonPlayer = AudioPlayer();
  final colorPlayer = AudioPlayer();

  final _buttonAudio = "audios/button_click.mp3";
  final _colorAudio = "audios/color_placement.mp3";

  new _();
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