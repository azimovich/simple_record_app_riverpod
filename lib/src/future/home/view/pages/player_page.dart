import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../vm/player_vm.dart';
import '../../../../../app_vm.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/style/app_colors.dart';
import '../widgets/player_page_top_widget.dart';

class PlayerPage extends ConsumerStatefulWidget {
  final String audioPath; // File yo'lini olish
  const PlayerPage({super.key, required this.audioPath});

  @override
  ConsumerState<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<PlayerPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.read(playerVM).initalization(widget.audioPath);
  }

  @override
  Widget build(BuildContext context) {
    PlayerVm vm = ref.watch(playerVM);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text(
          "Zapisni Eshitish",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                final xFile = XFile(widget.audioPath); // Path ni XFile obyektiga o'zgartirish
                await Share.shareXFiles(
                  [xFile],
                  // text: 'Mana, mening yozib olgan ovozim!',
                );
              } catch (e) {
                Utils.fireSnackBar("Ulashda xatolik: $e", AppColors.bgColor);
              }
            },
            icon: const Icon(Icons.ios_share_rounded, color: Colors.white),
            highlightColor: const Color.fromRGBO(255, 255, 255, 0.2),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            if (vm.audioPlayer.playing) {
              vm.audioPlayer.stop();
            }
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          highlightColor: const Color.fromRGBO(255, 255, 255, 0.2),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const PlayerPageTopWidget(),
              20.verticalSpace,
              Text(
                p.basename(widget.audioPath),
                style: TextStyle(fontSize: 18.sp, color: AppColors.c424242, fontWeight: FontWeight.w500),
              ),
              40.verticalSpace,

              // Slider for Seeking
              StreamBuilder<Duration?>(
                stream: vm.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final totalDuration = vm.audioPlayer.duration ?? Duration.zero;
                  return Column(
                    children: [
                      Slider(
                        value: position.inSeconds.toDouble(),
                        max: totalDuration.inSeconds.toDouble(),
                        onChanged: (value) {
                          vm.seekAudio(Duration(seconds: value.toInt()));
                        },
                        thumbColor: AppColors.mainColor,
                        activeColor: AppColors.mainColor,
                        inactiveColor: AppColors.c42424270,
                      ),
                      Text(
                        "${_formatDuration(position)} / ${_formatDuration(totalDuration)}",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  );
                },
              ),
              30.verticalSpace,

              // Play, Pause, Repeat Buttons
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Pause Button
                  IconButton(
                    onPressed: () async => vm.pauseAudio(),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.bgColor,
                      fixedSize: Size(60.w, 60.h),
                      iconSize: 30.h,
                    ),
                    color: Colors.grey.shade600,
                    icon: const Icon(CupertinoIcons.pause_fill),
                  ),

                  // Play Button
                  IconButton(
                    onPressed: () async => vm.playAudio(),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.cFF292915,
                      fixedSize: Size(60.w, 60.h),
                      iconSize: 30.h,
                    ),
                    color: AppColors.mainColor,
                    icon: const Icon(CupertinoIcons.play_fill),
                  ),

                  // Repeat Button
                  IconButton(
                    onPressed: () async {
                      vm.seekAudio(Duration.zero);
                      vm.playAudio();
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.bgColor,
                      fixedSize: Size(60.w, 60.h),
                      iconSize: 30.h,
                    ),
                    // color: Colors.blueAccent,
                    color: Colors.grey.shade600,

                    icon: const Icon(CupertinoIcons.repeat),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    return duration.toString().split('.').first.padLeft(8, "0");
  }
}
