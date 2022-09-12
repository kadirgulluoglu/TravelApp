import 'package:denemefirebaseauth/screens/homepage/model/homepage_model.dart';
import 'package:denemefirebaseauth/screens/homepage/service/homepage_service.dart';
import 'package:flutter/material.dart';

import '../../../locator.dart';
import '../../../product/enum/view_state.dart';

class HomePageViewModel with ChangeNotifier {
  HomePageViewModel() {
    getPlaces();
  }

  final _service = locator<HomePageService>();
  int _customStar = 3;
  bool _isFavoriteButton = false;
  bool get isFavoriteButton => _isFavoriteButton;
  ViewState _state = ViewState.busy;
  List<HomePageModel>? placeList;
  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  set isFavoriteButton(bool value) {
    _isFavoriteButton = value;
    notifyListeners();
  }

  int get customStar => _customStar;

  set customStar(int value) {
    _customStar = value;
    notifyListeners();
  }

  int _selectedIndexPeople = 0;

  int get selectedIndexPeople => _selectedIndexPeople;

  set selectedIndexPeople(int value) {
    _selectedIndexPeople = value;
    notifyListeners();
  }

  @override
  Future getPlaces() async {
    try {
      state = ViewState.busy;
      List response = await _service.getPlaces();
      placeList = response.map((e) => e as HomePageModel).toList();
      print(placeList?[0].name ?? "Null");
      state = ViewState.idle;
    } catch (e) {
      print(e);
      state = ViewState.error;
    }
  }
}
