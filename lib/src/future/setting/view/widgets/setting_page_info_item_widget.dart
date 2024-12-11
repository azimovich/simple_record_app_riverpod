import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/tools/assets_path.dart';

class SettingPageInfoItemWidget extends StatelessWidget {
  const SettingPageInfoItemWidget({super.key});

  final String userName = "t.me/shukhrat_azimovich";
  final String phone = "+998948632434";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 140.h,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Boglanish Uchun",
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ),
                8.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox.fromSize(
                      size: Size(24.w, 24.h),
                      child: SvgPicture.asset(
                        // fit: BoxFit.contain,
                        AssetsPath.telegramIconPath,
                        colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
                      ),
                    ),
                    8.horizontalSpace,
                    Text(
                      "@shukhrat_azimovich",
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.c424242),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 30.h,
                      width: 30.w,
                      child: IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: userName));
                          // context.pop();
                        },
                        padding: REdgeInsets.all(2),
                        icon: Icon(
                          Icons.copy_outlined,
                          size: 16.sp,
                        ),
                      ),
                    )
                  ],
                ),
                4.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox.fromSize(
                      size: Size(24.w, 24.h),
                      child: SvgPicture.asset(
                        // fit: BoxFit.cover,
                        AssetsPath.phoneIconPath,
                        colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
                      ),
                    ),
                    8.horizontalSpace,
                    Text(
                      "+99894-863-24-34",
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.c424242),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 30.h,
                      width: 30.w,
                      child: IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: phone));
                          // context.pop();
                        },
                        padding: REdgeInsets.all(2),
                        icon: Icon(
                          Icons.copy_outlined,
                          size: 16.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
