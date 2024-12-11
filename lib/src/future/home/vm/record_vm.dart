import 'dart:async';
import 'dart:developer';

import 'package:record/record.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/server/record_server.dart';

class RecordVm extends ChangeNotifier {
  Timer? _timer;
  String? errorText;
  int milliseconds = 0;
  String? _cacheFilePath;
  bool isRunning = false;
  final AudioRecorder _record = AudioRecorder();

  void startOrResumeTimer() {
    if (!isRunning) {
      isRunning = true;
      _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        milliseconds += 10;
        notifyListeners();
      });
    }
  }

  void pauseTimer() {
    if (isRunning) {
      isRunning = false;
      _timer?.cancel();
      notifyListeners();
    }
  }

  void resetTimer() {
    isRunning = false;
    _timer?.cancel();
    milliseconds = 0;
    notifyListeners();
  }

  String formatTime(int milliseconds) {
    final int minutes = (milliseconds ~/ 60000);
    final int seconds = (milliseconds ~/ 1000) % 60;
    final int centiseconds = (milliseconds ~/ 10) % 100;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}.'
        '${centiseconds.toString().padLeft(2, '0')}';
  }

  /// Audio yozishni boshlash
  Future<void> startRecording() async {
    if (await _record.hasPermission()) {
      final tempFilePath = p.join(
        (await getTemporaryDirectory()).path,
        'temp_record.m4a',
      );
      await _record.start(const RecordConfig(), path: tempFilePath);
      log('Yozish boshlandi: $tempFilePath');
    }
    // notifyListeners();
  }

  /// Stop record
  Future<void> _stopRecording() async {
    _cacheFilePath = await _record.stop();
    if (_cacheFilePath != null) {
      log("Record path at cache: $_cacheFilePath");
    }
  }

  /// Pause record
  Future<void> _pauseRecording() async {
    await _record.pause();
  }

  /// Resume record
  Future<void> _resumeRecording() async {
    await _record.resume();
  }

  Future<void> stopOrResumeFunc() async {
    if (isRunning) {
      await _pauseRecording().then((v) {
        pauseTimer();
      });
    } else {
      await _resumeRecording().then((v) {
        startOrResumeTimer();
      });
    }
  }

  Future<bool> saveRecord() async {
    try {
      if (_cacheFilePath == null) {
        await _stopRecording();
      }

      String? result = await RecordServer.createAudioFile(_cacheFilePath);

      if (result != null) {
        _cacheFilePath = null;
        errorText = "Ovoz muvaffaqiyatli saqlab olindi";
        notifyListeners();
        return true;
      } else {
        errorText = "Ovoz saqlashda muammo yuzaga keldi. Qayta urunib ko'ring";
        notifyListeners();
        return false;
      }
    } catch (e, stackTrace) {
      errorText = "Kutilmagan xatolik yuz berdi: $e";
      log('Error in saveRecord: $e', stackTrace: stackTrace);
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
