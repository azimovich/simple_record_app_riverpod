import 'package:flutter/widgets.dart';

class MainVm extends ChangeNotifier {
  int currentIndex = 0;

  void changeIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }
}
