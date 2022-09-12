import 'package:flutter/material.dart';

class AuthViewModel with ChangeNotifier {
  bool _rememberMe = false;
  bool _isObscure = true;
  bool _isLoading = false;

  bool get rememberMe => _rememberMe;

  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  bool get isObscure => _isObscure;

  set isObscure(bool value) {
    _isObscure = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void changeObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
