import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/tools/assets_path.dart';

class HomePageFloactActionButtonWidget extends StatelessWidget {
  final double width;
  final VoidCallback onPressed;
  const HomePageFloactActionButtonWidget({super.key, required this.width, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 56.w,
      curve: Curves.easeInOut,
      width: width, // Kengayish va qisqarish
      duration: const Duration(milliseconds: 500),
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: AppColors.mainColor,
        heroTag: "homeHero",
        child: Row(
          mainAxisSize: MainAxisSize.min, // Row kengligini tabiiy o‘lchamga moslash
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // if (_showText) ...[
            //   const Text(
            //     'Qo‘shish',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 16,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            //   8.horizontalSpace,
            // ],
            SvgPicture.asset(
              AssetsPath.recordIconPath,
              height: 24.h,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}