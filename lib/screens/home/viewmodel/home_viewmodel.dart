import 'package:denemefirebaseauth/screens/favorite/view/favorite_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';
import '../../../product/enum/view_state.dart';
import '../../homepage/model/homepage_model.dart';
import '../../homepage/service/homepage_service.dart';
import '../../homepage/view/home_page_view.dart';

class HomeViewModel with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  HomeViewModel() {
    getPlaces();
  }

  final List<Widget> _pages = [
    HomePageView(),
    FavoriteView(),
    Center(child: Text("Keşfet")),
    Container(color: Colors.blueGrey),
  ];

  List<Widget> get pages => _pages;

  void onTapBottomBar(int index) {
    currentIndex = index;
  }

  final _service = locator<HomePageService>();
  bool _isFavoriteButton = false;
  bool get isFavoriteButton => _isFavoriteButton;
  ViewState _state = ViewState.busy;
  List<HomePageModel>? placeList;
  List<HomePageModel> favoriteList = [];

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  set isFavoriteButton(bool value) {
    _isFavoriteButton = value;
    notifyListeners();
  }

  int _selectedIndexPeople = 0;

  int get selectedIndexPeople => _selectedIndexPeople;

  set selectedIndexPeople(int value) {
    _selectedIndexPeople = value;
    notifyListeners();
  }

  void addFavorite(int index) {
    placeList![index].isFavorite = !placeList![index].isFavorite!;
    favoriteList.add(placeList![index]);
    notifyListeners();
  }

  void removeFavorite(int index) {
    placeList![index].isFavorite = !placeList![index].isFavorite!;
    favoriteList.removeAt(
        favoriteList.indexWhere((element) => element.placeId == (index + 1)));
    notifyListeners();
  }

  Future getPlaces() async {
    try {
      state = ViewState.busy;
      List response = await _service.getPlaces();
      placeList = response.map((e) => e as HomePageModel).toList();
      state = ViewState.idle;
    } catch (e) {
      state = ViewState.error;
    }
  }
}
