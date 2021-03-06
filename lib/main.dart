import 'package:checkin/ui/startup_view.dart';
import 'package:flutter/material.dart';
import 'package:checkin/services/navigation_service.dart';
import 'package:checkin/services/dialog_service.dart';
import 'package:flutter/services.dart';
import 'managers/dialog_manager.dart';
import 'ui/router.dart';
import 'locator.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .then((_) => runApp(new MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(
                  child: child,
                )),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primaryColor: Color(0xff19c7c1),
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'NotoSans',
            ),
      ),
      home: StartUpView(),
      onGenerateRoute: generateRoute,
    );
  }
}
