import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../vm/home_vm.dart';
import '../../../../../app_vm.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/routes/router_config.dart';
import '../../../../core/routes/app_route_names.dart';
import '../widgets/home_page_delete_card_widget.dart';
import '../widgets/home_page_floact_action_button_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final HomeVm vm = ref.watch(homeVM);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text(
          "Ovoz Yozish",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        scrolledUnderElevation: 0,
      ),
      body: Builder(
        builder: (context) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (vm.recordsList.isEmpty) {
            return Center(
              child: Text(
                vm.errorText ?? "Ma'lumotlar topilmadi",
                style: TextStyle(
                  color: AppColors.c424242,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          } else {
            return ListView.separated(
              itemCount: vm.recordsList.length,
              controller: vm.scrollController,
              separatorBuilder: (_, i) => 14.verticalSpace,
              padding: REdgeInsets.symmetric(vertical: 16, horizontal: 20),
              itemBuilder: (_, i) {
                final file = vm.recordsList[i];
                return MaterialButton(
                  onPressed: () {
                    AppRouter.router.push("${AppRouteNames.home}${AppRouteNames.playerPage}", extra: file.path);
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.sp)),
                  minWidth: MediaQuery.of(context).size.width,
                  elevation: 0,
                  highlightElevation: 0,
                  padding: REdgeInsets.symmetric(vertical: 20, horizontal: 14),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox.fromSize(
                        size: Size(36.w, 36.h),
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: AppColors.bgColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: Text(
                          p.basename(file.path),
                          style: TextStyle(color: AppColors.c424242, fontSize: 16.sp),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 36.h,
                        width: 36.w,
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              useRootNavigator: true,
                              builder: (context) {
                                return HomePageDeleteCardWidget(file: file, vm: vm);
                              },
                            );
                          },
                          color: AppColors.mainColor,
                          padding: EdgeInsets.zero,
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.cFF292915,
                            iconSize: 20.h,
                          ),
                          icon: const Icon(CupertinoIcons.delete_solid),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: HomePageFloactActionButtonWidget(
        width: vm.showText ? 150.w : 56.w,
        onPressed: () async => await vm.onFloatingActionButtonTap(),
      ),
      backgroundColor: AppColors.bgColor,
    );
  }
}
