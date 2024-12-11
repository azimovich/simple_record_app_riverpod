import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/tools/assets_path.dart';
import '../widgets/setting_page_info_item_widget.dart';
import '../widgets/setting_page_item_widget.dart';
import '../widgets/setting_page_tranlsate_item_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text(
          "Sozlamalar",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: REdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          children: [
            SettingPageItemWidget(
              iconPath: AssetsPath.translateIconPath,
              text: "Tilni O'zgartirish",
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  useRootNavigator: true,
                  builder: (context) {
                    return const SettingPageTranlsateItemWidget();
                  },
                );
              },
            ),
            10.verticalSpace,
            SettingPageItemWidget(iconPath: AssetsPath.securityIconPath, text: "Xavfsizlik", onTap: () {}),
            10.verticalSpace,
            SettingPageItemWidget(
              iconPath: AssetsPath.shareIconPath,
              text: "Ilovani Ulashish",
              onTap: () {
                Share.share(
                  "Bu mening ilovam! Yuklab olish uchun ushbu havoladan foydalaning: https://yourapp.com",
                  subject: "Ilovani ulashing",
                );
              },
            ),
            10.verticalSpace,
            SettingPageItemWidget(
              iconPath: AssetsPath.infoIconPath,
              text: "Ilova Yaratuvchisi",
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  useRootNavigator: true,
                  builder: (context) {
                    return const SettingPageInfoItemWidget();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
