import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/tools/assets_path.dart';

class SettingPageTranlsateItemWidget extends StatelessWidget {
  const SettingPageTranlsateItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100.h,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsPath.infoIconPath,
                colorFilter: ColorFilter.mode(Colors.grey.shade300, BlendMode.srcIn),
                height: 30.h,
              ),
              10.verticalSpace,
              Text(
                "Keyingi Versiyalarda",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: AppColors.c424242),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
