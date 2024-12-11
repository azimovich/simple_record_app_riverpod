import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class CustomScreenUtil extends StatelessWidget {
  final Widget child;
  final bool enabledPreview;

  const CustomScreenUtil({
    required this.child,
    required this.enabledPreview,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: child,
      );
}
