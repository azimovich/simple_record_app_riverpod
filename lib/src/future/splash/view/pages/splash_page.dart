// import 'dart:async';

// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:audio_record_app_riverpod/src/core/style/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../../core/tools/assets_path.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
//   late AnimationController _svgController;
//   late Animation<double> _svgAnimation;

//   late double screenHeight;
//   late double screenWidth;

//   bool _showTextAnimation = false; // Text animatsiyasini boshqarish uchun flag

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     // Ekran o'lchamlari MediaQuery orqali
//     screenHeight = MediaQuery.of(context).size.height;
//     screenWidth = MediaQuery.of(context).size.width;

//     // SVG uchun animatsiya
//     _svgController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );

//     _svgAnimation = Tween<double>(
//       begin: -200, // Boshlang'ich holat
//       end: screenHeight / 2 - 40, // Ekran o'rtasiga yaqinlashish
//     ).animate(CurvedAnimation(parent: _svgController, curve: Curves.bounceInOut));

//     // Animatsiyani avtomatik boshlash
//     _svgController.forward();

//     // SVG animatsiyasi tugagandan keyin text animatsiyasini ko'rsatish
//     _svgController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         setState(() {
//           _showTextAnimation = true;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _svgController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: AppColors.mainColor,
//       body: Stack(
//         children: [
//           Center(child: CustomRecordingWaveWidget())
//           // SVG animatsiyasi
//           // AnimatedBuilder(
//           //   animation: _svgAnimation,
//           //   builder: (context, child) {
//           //     return Positioned(
//           //       top: _svgAnimation.value,
//           //       left: 0,
//           //       right: 0,
//           //       child: SvgPicture.asset(
//           //         AssetsPath.recordIconPath,
//           //         width: 80,
//           //         height: 80,
//           //         colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
//           //       ),
//           //     );
//           //   },
//           // ),
//           // Text animatsiyasi, faqat _showTextAnimation true bo'lsa ko'rsatiladi
//           // if (_showTextAnimation)
//           // Positioned(
//           //   top: screenHeight / 2,
//           //   left: 0, // Markazlash uchun
//           //   right: 0, // Ekran bo'ylab joylashuvi
//           //   child: Center(
//           //     child: AnimatedTextKit(
//           //       totalRepeatCount: 10, // Faqat bir marta takrorlanadi
//           //       animatedTexts: [

//           //         TyperAnimatedText(
//           //           "AUDIO",
//           //           textStyle: TextStyle(color: Colors.white, fontSize: 30.sp, letterSpacing: 10),
//           //         ),
//           //         TyperAnimatedText(
//           //           "RECORDER",
//           //           textStyle: TextStyle(color: Colors.white, fontSize: 30.sp),
//           //         ),
//           //         TyperAnimatedText(
//           //           "APP",
//           //           textStyle: TextStyle(color: Colors.white, fontSize: 30.sp),
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../core/routes/app_route_names.dart';
import '../../../../core/routes/router_config.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // 3 soniyadan keyin Home Page'ga o'tish
    Future.delayed(const Duration(seconds: 3), () {
      AppRouter.router.go(AppRouteNames.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Center(child: CustomRecordingWaveWidget()),
    );
  }
}

class CustomRecordingWaveWidget extends StatefulWidget {
  const CustomRecordingWaveWidget({super.key});

  @override
  State<CustomRecordingWaveWidget> createState() => _CustomRecordingWaveWidgetState();
}

class _CustomRecordingWaveWidgetState extends State<CustomRecordingWaveWidget> {
  final List<double> _heights = [0.05, 0.07, 0.1, 0.15, 0.1, 0.07, 0.05];
  Timer? _timer;

  @override
  void initState() {
    _startAnimating();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAnimating() {
    _timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        // This is a simple way to rotate the list, creating a wave effect.
        _heights.add(_heights.removeAt(0));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _heights.map((height) {
          return AnimatedContainer(
            width: 20,
            duration: const Duration(milliseconds: 300),
            height: MediaQuery.of(context).size.height * height,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
          );
        }).toList(),
      ),
    );
  }
}
