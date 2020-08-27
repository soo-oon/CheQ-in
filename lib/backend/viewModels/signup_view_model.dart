import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/constants/route_names.dart';
import 'package:checkin/services/services.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_otp/flutter_otp.dart';


class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FlutterOtp _flutterOtp = FlutterOtp();

  String _selectedRole = 'User';
  //String get selectedRole => _selectedRole;

  Future updateUserdata(String password) async {
    await _firestoreService.createUser(currentUser);
    await _authenticationService.changePassword(password);
  }

  void setSelectedRole(dynamic role) {
    _selectedRole = role;
    notifyListeners();
  }

  Future signUp({
    @required String email,
    @required String password,
    @required String password2,
    @required String fullName,
    @required String address,
    @required String phoneNumber,
  }) async {
    if (password != password2) {
      await _dialogService.showDialog(
        title: '비밀번호 오류',
        description: '비밀번호가 일치하지 않습니다.',
      );
    } else {
      setBusy(true);

      var result = await _authenticationService.signUpWithEmail(
          email: email,
          password: password,
          fullName: fullName,
          address: address,
          phoneNumber: phoneNumber,
          role: _selectedRole); //Maybe _selectedRole in the future

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
  }

  navigateToLoginPage() {
    _navigationService.navigateTo(LoginViewRoute);
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

  void sendOTP({@required String phoneNumber}) {
    String messege = "계명대학교 QR체크인 인증번호는 ";
    String countryCode = '+82';
    _flutterOtp.sendOtp(phoneNumber, messege, 1000,9999, countryCode);
    print(phoneNumber);
  }

  Future verifyPhoneNumber(BuildContext context, TextEditingController codeController, String phoneNumber) async {
    setBusy(true);
    await _authenticationService.verifyPhoneNumber(context, codeController, phoneNumber: phoneNumber);
    setBusy(false);
  }


}
