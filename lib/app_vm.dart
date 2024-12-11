import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/future/home/vm/home_vm.dart';
import 'src/future/home/vm/player_vm.dart';
import 'src/future/home/vm/record_vm.dart';
import 'src/future/main/vm/main_vm.dart';

final mainVM = ChangeNotifierProvider.autoDispose<MainVm>((ref) {
  return MainVm();
});

final homeVM = ChangeNotifierProvider.autoDispose<HomeVm>((ref) {
  return HomeVm();
});

final recordVM = ChangeNotifierProvider.autoDispose<RecordVm>((ref) {
  return RecordVm();
});

final playerVM = ChangeNotifierProvider.autoDispose<PlayerVm>((ref) {
  return PlayerVm();
});
