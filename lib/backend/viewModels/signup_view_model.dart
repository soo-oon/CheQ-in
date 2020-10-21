import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/constants/route_names.dart';
import 'package:checkin/services/services.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter_otp/flutter_otp.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  //final FlutterOtp _flutterOtp = FlutterOtp();

  String _selectedRole = 'User';
  //bool isPhoneVarified = false;
  String formattedPhoneNumber;

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

  /*void sendOTP({@required String phoneNumber}) {
    _flutterOtp.sendOtp(phoneNumber, "otp is",1000,9999, "+82");
    print(phoneNumber);
  }*/

  Future verifyPhoneNumber(BuildContext context,
      TextEditingController codeController, String phoneNumber) async {
    setBusy(true);
    await _authenticationService.verifyPhoneNumber(context, codeController,
        phoneNumber: phoneNumber);
    setBusy(false);
  }

  bool checkPhoneNumber(String phoneNumber) {
    formattedPhoneNumber = phoneNumber;
    formattedPhoneNumber.replaceAll("_", "");

    if (formattedPhoneNumber.length < 11) {
      //showPhoneNumberLengthWrongDialog();
      return false;
    } else {
      formattedPhoneNumber =
          formattedPhoneNumber.substring(formattedPhoneNumber.length - 10);
      formattedPhoneNumber = "0" + formattedPhoneNumber;
      print(formattedPhoneNumber);

      if (formattedPhoneNumber.startsWith('010')) {
        return true;
      } else {
        //showPhoneNumberLengthWrongDialog();
        return false;
      }
    }
    /*else if (){

    }

    if () {
      if (formattedPhoneNumber.contains('-')) {
        formattedPhoneNumber.replaceAll('-', '');
      }
    } else {
      showPhoneNumberWrongDialog();
      return false;
    }*/
  }

  // void checkIfPhoneVarified(int otp) {
  //   if (_flutterOtp.resultChecker(otp)) {
  //     _dialogService.showDialog(
  //         title: "인증번호 확인.", description: "인증번호가 확인되었습니다.");
  //     isPhoneVarified = true;
  //   } else {
  //     _dialogService.showDialog(
  //       title: "인증번호 오류.",
  //       description: "인증번호를 다시 입력해주세요",
  //     );
  //     isPhoneVarified = false;
  //   }
  // }

  // void showPhoneVarifyDialog() {
  //   _dialogService.showDialog(title: "핸드폰 인증오류", description: "핸드폰 인증을 해주세요");
  // }

  void showPhoneNumberWrongDialog() {
    _dialogService.showDialog(
        title: "휴대폰번호 오류", description: "휴대폰 번호를 제대로 입력해주세요");
  }

  void showPhoneNumberLengthWrongDialog() {
    _dialogService.showDialog(
        title: "휴대폰번호 길이 오류", description: "휴대폰 번호 11자리 다 입력해주세요");
  }

  // void showOTPSentDialog() {
  //   _dialogService.showDialog(
  //       title: "인증번호 전송완료", description: "핸드폰 문자메시지를 확인해주세요.");
  // }
}
