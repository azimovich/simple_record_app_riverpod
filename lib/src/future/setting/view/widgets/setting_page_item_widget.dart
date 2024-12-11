import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/style/app_colors.dart';

class SettingPageItemWidget extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback onTap;
  const SettingPageItemWidget({super.key, required this.iconPath, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      height: 70.h,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      padding: REdgeInsets.symmetric(horizontal: 12),
      color: Colors.white,
      highlightElevation: 0,
      elevation: 0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconPath,
            colorFilter: const ColorFilter.mode(AppColors.c424242, BlendMode.srcIn),
            height: 24.h,
          ),
          10.horizontalSpace,
          Text(
            text,
            style: TextStyle(color: AppColors.c424242, fontWeight: FontWeight.w500, letterSpacing: 2, fontSize: 16.sp),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.c424242,
          ),
        ],
      ),
    );
  }
}
