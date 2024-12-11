// import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';

// // import '../../vm/home_vm.dart';

// class RecorderPage extends StatefulWidget {
//   const RecorderPage({super.key});

//   @override
//   State<RecorderPage> createState() => _RecorderPageState();
// }

// class _RecorderPageState extends State<RecorderPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Yozish sahifasi'),
//         automaticallyImplyLeading: false,
//       ),
//       body: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Ovoz yozilmoqda...',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app_vm.dart';
import '../../../../core/routes/router_config.dart';
import '../../vm/record_vm.dart';
import '../../../../core/style/app_colors.dart';

class RecordPage extends ConsumerStatefulWidget {
  const RecordPage({super.key});

  @override
  ConsumerState<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends ConsumerState<RecordPage> {
  @override
  void initState() {
    super.initState();
    ref.read(recordVM).startRecording().then((e) {
      ref.read(recordVM).startOrResumeTimer();
    });
  }
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   ref.read(recordVM).startRecording().then((e) {
  //     ref.read(recordVM).startOrResumeTimer();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    RecordVm vm = ref.watch(recordVM);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text(
          "Ovoz Yozish Boshlandi",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                vm.formatTime(vm.milliseconds),
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              40.verticalSpace,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () async => await vm.stopOrResumeFunc(),
                    style: IconButton.styleFrom(
                      backgroundColor: vm.isRunning ? AppColors.bgColor : AppColors.cFF292915,
                      fixedSize: Size(60.w, 60.h),
                      iconSize: 30.h,
                    ),
                    color: vm.isRunning ? Colors.grey.shade600 : AppColors.mainColor,
                    icon: Icon(vm.isRunning ? CupertinoIcons.pause_fill : CupertinoIcons.play_fill),
                  ),
                  IconButton(
                    onPressed: () async {
                      bool result = await vm.saveRecord();
                      if (result) {
                        AppRouter.router.pop(true);
                      } else {}
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      fixedSize: Size(60.w, 60.h),
                      iconSize: 30.h,
                    ),
                    color: Colors.white,
                    icon: const Icon(Icons.done_outlined),
                  ),
                  SizedBox.fromSize(
                    size: Size(60.w, 60.h),
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
