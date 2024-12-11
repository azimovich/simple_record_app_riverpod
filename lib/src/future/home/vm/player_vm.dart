// ignore_for_file: body_might_complete_normally_catch_error

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/style/app_colors.dart';
import '../../../core/utils/utils.dart';

class PlayerVm extends ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  late Stream<Duration?> positionStream;

  bool playerIsActive = false;

  void initalization(String audioPath) {
    positionStream = audioPlayer.positionStream;

    // Ovoz trekini yuklash
    audioPlayer.setFilePath(audioPath).catchError((e) {
      Utils.fireSnackBar("Audio yuklashda xatolik: $e", AppColors.bgColor);
    });
  }

  void playAudio() async {
    await audioPlayer.play();
    playerIsActive = true;
    notifyListeners();
  }

  void pauseAudio() async {
    await audioPlayer.pause();
    playerIsActive = false;
    notifyListeners();
  }

  void seekAudio(Duration position) async {
    await audioPlayer.seek(position);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }
}
