import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/constants/route_names.dart';
import 'package:checkin/locator.dart';
import 'package:checkin/models/user.dart';
import 'package:checkin/services/authentication_service.dart';
import 'package:checkin/services/firestore_service.dart';
import 'package:checkin/services/navigation_service.dart';
import 'package:checkin/services/pushnotification_service.dart';

class InfoViewModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final PushNotificationService _pushNotificationService = locator<PushNotificationService>();

  User user;

  init() async{
    setBusy(true);
    user = await _firestoreService.getUser(
    currentUser.id);
    setBusy(false);
  }

  void signOut() {
    setBusy(true);
    _authenticationService.signOut();
    _navigationService.navigateTo(LoginViewRoute);
    setBusy(false);
  }

  Future sendPush() async {
    setBusy(true);
    await _pushNotificationService.sendNotificationMessage();
    setBusy(false);
  }
}