import 'package:checkin/constants/route_names.dart';
import 'package:checkin/locator.dart';
import 'package:checkin/services/authentication_service.dart';
import 'package:checkin/services/navigation_service.dart';
import 'package:checkin/backend/viewModels/base_model.dart';

class FrontEndHomeViewModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signOut() {
    _authenticationService.signOut();
    _navigationService.navigateTo(LoginViewRoute);
  }
}