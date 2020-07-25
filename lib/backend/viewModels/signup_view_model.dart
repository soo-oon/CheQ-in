import 'package:checkin/constants/route_names.dart';
import 'package:checkin/locator.dart';
import 'package:checkin/services/authentication_service.dart';
import 'package:checkin/services/dialog_service.dart';
import 'package:checkin/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String _selectedRole = 'Select a User Role';
  String get selectedRole => _selectedRole;

  void setSelectedRole(dynamic role) {
    _selectedRole = role;
    notifyListeners();
  }

  Future signUp({
    @required String email,
    @required String password,
    @required String fullName,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
        email: email,
        password: password,
        fullName: fullName,
        role: _selectedRole);

    setBusy(false);

    if (result is bool) {
      if (result) {
        await login(email: email, password: password);

        if (_selectedRole == "User") {
          _navigationService.navigateTo(FrontEndHomeViewRoute);
        } else {
          _navigationService.navigateTo(BackEndHomeViewRoute);
        }
        
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result,
      );
    }
  }

  Future login({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        if (_authenticationService.currentUser.userRole == "Admin") {
          _navigationService.navigateTo(BackEndHomeViewRoute);
        } else {
          _navigationService.navigateTo(FrontEndHomeViewRoute);
        }
      } else {
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'General login failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
    }
  }

  navigateToLoginPage() {
    _navigationService.navigateTo(LoginViewRoute);
  }
}
