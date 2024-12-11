import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routes/router_config.dart';
import '../style/app_colors.dart';

sealed class Utils {
  // static final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  // FireSnackBar
  static void fireSnackBar(String msg, Color bgColor) {
    BuildContext context = parentNavigatorKey.currentState!.context;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        backgroundColor: bgColor,
        content: Text(
          msg,
          style: TextStyle(color: AppColors.c424242, fontSize: 16.sp, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        duration: const Duration(milliseconds: 2500),
        padding: REdgeInsets.symmetric(vertical: 20),
        margin: REdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).size.height * 0.8,
          top: 0,
          // bottom: 0,
        ),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        shape: const StadiumBorder(),
      ),
    );
  }

  // static void fireSnackBar2(String msg, Color bgColor) {
  //   final scaffoldMessenger = messengerKey.currentState;
  //   if (scaffoldMessenger != null) {
  //     scaffoldMessenger.showSnackBar(
  //       SnackBar(
  //         backgroundColor: bgColor,
  //         content: Text(
  //           msg,
  //           style: TextStyle(color: AppColors.c424242, fontSize: 16.sp),
  //           textAlign: TextAlign.center,
  //         ),
  //         duration: const Duration(milliseconds: 2500),
  //         padding: REdgeInsets.symmetric(vertical: 20),
  //         margin: REdgeInsets.only(left: 16, right: 16, top: 40),
  //         elevation: 0,
  //         behavior: SnackBarBehavior.floating,
  //         shape: const StadiumBorder(),
  //       ),
  //     );
  //   }
  // }

  static void fireTopSnackBar(String msg, Color bgColor, BuildContext context) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: MediaQuery.of(context).padding.top + 16, // Status bar ostidan joylashadi
          left: 16,
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                msg,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry);

    // Xabarni avtomatik olib tashlash
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
