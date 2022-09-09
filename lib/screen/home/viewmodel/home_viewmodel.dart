import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  int _currentIndex = 0;
  late List _pages;

  List get pages => _pages;

  HomeViewModel() {
    _pages = [
      Center(
          child: Text(
        "Ana Sayfa",
        style: TextStyle(fontSize: 45),
      )),
      Center(
          child: Text(
        "Keşfet",
        style: TextStyle(fontSize: 45),
      )),
      Container(color: Colors.redAccent),
      Container(color: Colors.blueGrey),
    ];
  }
  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  void onTapBottomBar(int index) {
    currentIndex = index;
  }
}
