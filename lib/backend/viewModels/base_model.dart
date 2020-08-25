import 'package:checkin/constants/route_names.dart';
import 'package:checkin/locator.dart';
import 'package:checkin/models/user.dart';
import 'package:checkin/services/authentication_service.dart';
import 'package:checkin/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool qrScanned = false;
  bool get isQRScanned => qrScanned;
  void setQrScanned(bool val) {
    qrScanned = val;
  }

  int screenCurrnetIndex = 0;
  int get currentIndex => screenCurrnetIndex;

  void setIndex(int index) {
    setBusy(true);
    screenCurrnetIndex = index;
    setBusy(false);
  }

  User get currentUser => _authenticationService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  void navigateToLogin() async {
    _navigationService.navigateTo(LoginViewRoute);
  }
}
