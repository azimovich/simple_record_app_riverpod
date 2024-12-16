import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/tools/assets_path.dart';

class PlayerPageTopWidget extends StatelessWidget {
  const PlayerPageTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(MediaQuery.of(context).size.width * 0.7, 260.h),
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r), boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            spreadRadius: 2,
            blurRadius: 10,
            blurStyle: BlurStyle.outer,
          )
        ]),
        child: Padding(
          padding: REdgeInsets.all(40),
          child: SvgPicture.asset(
            AssetsPath.record2IconPath,
            colorFilter: const ColorFilter.mode(AppColors.cFFD1D1D1, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
