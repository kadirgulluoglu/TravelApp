import 'package:flutter/material.dart';

class HomePageViewModel with ChangeNotifier {
  int _customStar = 3;
  bool _isFavoriteButton = false;
  ViewState _state = ViewState.busy;
  bool get isFavoriteButton => _isFavoriteButton;

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
  Future getPlaces({required String userToken}) async {
    try {
      state = ViewState.busy;
      List response = await _service.getPlaces(userToken: userToken);
      appointmentList = response.map((e) => e as AppointmentModel).toList();
      state = ViewState.idle;
    } catch (e) {
      state = ViewState.error;
    }
  }
}
