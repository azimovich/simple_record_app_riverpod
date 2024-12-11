import 'dart:io';
import 'dart:developer';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class RecordServer {
  static Directory? audioDirectory;

  /// Initializes the audio directory.
  /// If the directory does not exist, it creates it.
  static Future<Directory> initializeDirectory() async {
    log("------------ Initialize Directory ------------");
    final appDocDir = await getApplicationDocumentsDirectory();
    audioDirectory = Directory(p.join(appDocDir.path, 'AudioFiles'));
    log("Checking directory: ${audioDirectory.toString()}");

    if (!await audioDirectory!.exists()) {
      await audioDirectory!.create(recursive: true);
      log("Directory created at: ${audioDirectory!.path}");
    } else {
      log("Directory already exists at: ${audioDirectory!.path}");
    }
    log("------------ Initialize Directory ------------");
    return audioDirectory!;
  }

  /// Creates a new audio file in the directory.
  static Future<String?> createAudioFile(String? newRecordPath) async {
    try {
      if (newRecordPath != null && audioDirectory != null) {
        final newFilePath = p.join(
          audioDirectory!.path,
          'audio_${DateTime.now().millisecondsSinceEpoch}.m4a',
        );

        final tempFile = File(newRecordPath);
        await tempFile.copy(newFilePath);
        log('Audio saved at new file path: $newFilePath');
        return newFilePath;
      } else {
        log('Error: newRecordPath is null or audioDirectory is not initialized.');
      }
    } catch (e, stackTrace) {
      log('Failed to create audio file: $e', stackTrace: stackTrace);
    }
    return null;
  }

  /// Deletes a file by its path in the directory.
  static Future<bool> deleteAudioFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        log('File deleted: $filePath');
        return true;
      } else {
        log('File not found: $filePath');
      }
    } catch (e) {
      log('Error deleting file: $e');
    }
    return false;
  }

  /// Saqlangan audio fayllarni olish
  static Future<List<File>> getRecordFiles() async {
    if (audioDirectory != null) {
      final files = audioDirectory!.listSync();
      // log(files.whereType<File>().toList().toString());
      return files.whereType<File>().toList();
    }
    return [];
  }
}
