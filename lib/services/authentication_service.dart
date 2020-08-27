import 'package:checkin/locator.dart';
import 'package:checkin/models/user.dart';
import 'package:checkin/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  User _currentUser;
  User get currentUser => _currentUser;

  // Future loginWithPhone({@required String phoneNumber}) async {
  //   try {
  //     var authResult = await _firebaseAuth.signin


  //   } catch(e) {
  //     return e.message;
  //   }
  // }

  Future verifyPhoneNumber(BuildContext context, TextEditingController codeController, {@required String phoneNumber}) async {
    try {
      _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+82" + phoneNumber, 
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();
        },
        verificationFailed: (AuthException exception){
          print(exception);
        }, 
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("코드를 입력해주세요"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: codeController,
                    )
                  ],
                ),
                actions: [
                  FlatButton(
                    child: Text('확인'),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: ()  {
                      final code = codeController.text.trim();
                      AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);
                      print(credential);
                    },
                  )
                ],
              );
            }
          );
        }, 
        codeAutoRetrievalTimeout: null
      );
    } catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _populateCurrentUser(authResult.user);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
    @required String address,
    @required String phoneNumber,
    @required String role,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // create a new user profile on firestore
      _currentUser = User(
          id: authResult.user.uid,
          email: email,
          fullName: fullName,
          userRole: role,
          address: address,
          phoneNumber: phoneNumber);
      await _firestoreService.createUser(_currentUser);

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    if (user != null) await _populateCurrentUser(user);

    return user != null;
  }

  Future changePassword(String password) async {
    try {
      var firebaseUser = await _firebaseAuth.currentUser();

      var result = firebaseUser.updatePassword(password);

      return result;
    } catch (e) {
      return e.message;
    }
  }

  Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }

  Future signOut() async {
    try {
      var result = await _firebaseAuth.signOut();

      return result;
    } catch (e) {
      return e.message;
    }
  }
}
