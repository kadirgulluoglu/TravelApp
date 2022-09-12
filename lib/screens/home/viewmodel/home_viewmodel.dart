import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  int _currentIndex = 0;

  HomeViewModel() {}
  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  void onTapBottomBar(int index) {
    currentIndex = index;
  }
}
