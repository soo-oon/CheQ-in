import 'package:checkin/locator.dart';
import 'package:checkin/models/user.dart';
import 'package:checkin/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  User get currentUser => _authenticationService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
