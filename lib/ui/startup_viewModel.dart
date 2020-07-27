import 'package:checkin/constants/route_names.dart';
import 'package:checkin/locator.dart';
import 'package:checkin/services/authentication_service.dart';
import 'package:checkin/services/navigation_service.dart';
import 'package:checkin/services/pushnotification_service.dart';
import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();

  bool isRegistered;

  Future init() async {
    await _pushNotificationService.initialise();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isRegistered = prefs.getBool('isRegistered');

    if (isRegistered == null) {
      _navigationService.navigateTo(SignUpViewRoute);
      prefs.setBool('isRegistered', true);
    } else {
      var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

      if (hasLoggedInUser) {
        if (_authenticationService.currentUser.userRole == "Admin") {
          _navigationService.navigateTo(BackEndHomeViewRoute);
        } else {
          _navigationService.navigateTo(FrontEndHomeViewRoute);
        }
      } else {
        _navigationService.navigateTo(LoginViewRoute);
      }
    }
  }
}
