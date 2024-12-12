import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_colors.dart';

class HomePageBottomSheetButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isDelete;
  const HomePageBottomSheetButtonWidget({super.key, required this.onPressed, required this.text, this.isDelete = false});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: AppColors.bgColor,
      height : 40.h,
      padding: REdgeInsets.symmetric(vertical: 10),
      minWidth: MediaQuery.of(context).size.width * 0.425,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      highlightElevation: 0,
      elevation: 0,
      child: Text(
        text,
        style: TextStyle(color: isDelete ? AppColors.mainColor : AppColors.c424242),
      ),
    );
  }
}