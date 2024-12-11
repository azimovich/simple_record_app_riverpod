import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../vm/main_vm.dart';
import '../../../../../app_vm.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/tools/assets_path.dart';

class MainPage extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const MainPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MainVm vm = ref.watch(mainVM);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        currentIndex: vm.currentIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          navigationShell.goBranch(value);
          vm.changeIndex(value);
        },
        items: [
          BottomNavigationBarItem(
            label: "Asosiy",
            icon: SvgPicture.asset(
              AssetsPath.homeIconPath,
              height: 24.h,
              colorFilter: const ColorFilter.mode(
                AppColors.c424242,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AssetsPath.homeIconPath,
              height: 24.h,
              colorFilter: const ColorFilter.mode(
                AppColors.mainColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "Sozlamalar",
            icon: SvgPicture.asset(
              AssetsPath.settingIconPath,
              height: 24.h,
              colorFilter: const ColorFilter.mode(
                AppColors.c424242,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AssetsPath.settingIconPath,
              height: 24.h,
              colorFilter: const ColorFilter.mode(
                AppColors.mainColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
