import 'package:checkin/backend/views/backend_home_view.dart';
import 'package:checkin/frontend/views/front_views.dart';
import 'package:checkin/frontend/views/frontend_home_view.dart';
import 'package:checkin/frontend/views/visited_building.dart';
import 'package:flutter/material.dart';
import 'package:checkin/constants/route_names.dart';
import 'package:checkin/backend/views/login_view.dart';
import 'package:checkin/backend/views/signup_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginScreen(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: EnterPageScreen(),
      );
    case BackEndHomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: BackEndHomeView(),
      );
    case FrontEndHomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: FrontEndHomeView(),
      );
    case VisitedViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: VisitBuildingView(),
      );
    case QRScanViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: QRScanView(),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
