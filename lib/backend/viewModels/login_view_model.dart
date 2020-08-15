import 'package:checkin/constants/route_names.dart';
import 'package:checkin/locator.dart';
import 'package:checkin/services/authentication_service.dart';
import 'package:checkin/services/dialog_service.dart';
import 'package:checkin/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future login({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    if(email.endsWith(" ")){
      email = email.substring(0, email.length-1);
    }
  
    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        if(_authenticationService.currentUser.userRole == "Admin") {
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

  void navigateToSignUp() {
    _navigationService.navigateTo(SignUpViewRoute);
  }
}