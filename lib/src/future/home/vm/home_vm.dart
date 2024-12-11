import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:record/record.dart';

import '../../../core/routes/app_route_names.dart';
import '../../../core/routes/router_config.dart';
import '../../../core/server/record_server.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/utils/utils.dart';

class HomeVm extends ChangeNotifier {
  bool showText = false;
  bool isLoading = true;
  String? errorText;
  List<File> recordsList = [];

  final ScrollController scrollController = ScrollController();

  HomeVm() {
    getAudioFiles();
    initialScrollController();
  }

  void initialScrollController() {
    scrollController.addListener(() {
      final scrollPosition = scrollController.position.pixels;

      if (scrollPosition > 200.h && !showText) {
        showText = true;
        notifyListeners();
      } else if (scrollPosition <= 200.h && showText) {
        showText = false;
        notifyListeners();
      }
    });
  }

  Future<void> getAudioFiles() async {
    isLoading = true;
    notifyListeners();

    try {
      recordsList = await RecordServer.getRecordFiles();
      if (recordsList.isNotEmpty) {
        errorText = "Recordlar topildi";
      } else {
        errorText = "Hozircha ovoz zapis qilmagansiz";
      }
    } catch (e) {
      recordsList = []; // Xatolik yuz bersa, ro'yxatni tozalash
      errorText = "Xatolik: ${e.toString()}";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> onFloatingActionButtonTap() async {
    if (await AudioRecorder().hasPermission()) {
      bool? isCreated = await AppRouter.router.push("${AppRouteNames.home}${AppRouteNames.recordPage}");
      if (isCreated != null && isCreated) {
        getAudioFiles();
        Utils.fireSnackBar("Audio muvaffaqiyatli saqlandi", AppColors.bgColor);
      } else {
        log("record not saved");
      }
    } else {
      Utils.fireSnackBar("Audio yozish uchun ruhsat berish shart", AppColors.bgColor);
    }
  }

  Future<void> deleteAudioFunc(String path) async {
    bool result = await RecordServer.deleteAudioFile(path);
    if (result) {
      getAudioFiles();
      AppRouter.router.pop();
      Utils.fireSnackBar("Audio o'chirildi", AppColors.bgColor);
    } else {
      AppRouter.router.pop();
      Utils.fireSnackBar("Audio o'chirishda hatolik yuz berdi", AppColors.bgColor);
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}
