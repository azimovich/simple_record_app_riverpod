import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_colors.dart';
import '../../vm/home_vm.dart';
import 'home_page_bottom_sheet_button_widget.dart';

class HomePageDeleteCardWidget extends StatelessWidget {
  final File file;
  final HomeVm vm;
  const HomePageDeleteCardWidget({super.key, required this.file, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 170.h,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Audio Zapisni O'chirish",
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black, letterSpacing: 1),
                ),
                Text(
                  "Haqiqatdan ham \n${p.basename(file.path)} ni \n o'chirmoqchimisiz",
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.c424242),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomePageBottomSheetButtonWidget(
                        onPressed: () {
                          context.pop();
                        },
                        text: "Saqlash"),
                    HomePageBottomSheetButtonWidget(
                      onPressed: () {
                        vm.deleteAudioFunc(file.path);
                      },
                      text: "O'chirish",
                      isDelete: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
