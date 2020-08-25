import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  pop() {
    return _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState.pushReplacementNamed(routeName);
        //.pushNamed(routeName, arguments: arguments);
  }
  Future<dynamic> navigateToNotReplaced(BuildContext context, String routeName, {dynamic arguments}) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }
}
