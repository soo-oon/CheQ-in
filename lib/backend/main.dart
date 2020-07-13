import 'package:checkin/locator.dart';
import 'package:checkin/managers/dialog_manager.dart';
import 'package:checkin/services/dialog_service.dart';
import 'package:checkin/services/navigation_service.dart';
import 'package:checkin/ui/view/push_view.dart';
import 'package:checkin/ui/view/suggestion_view.dart';
import 'package:checkin/ui/view/visitor_view.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(BackendApp());
}

class BackendApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backend App',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(child: child,)
        ),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue
      ),
      home: MainPage(),
      //onGenerateRoute: generateRoute,
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: new Scaffold(
          appBar: AppBar(
            title: Text("Back End Main Page"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: "Visitors",
                ),
                Tab(
                  text: "Suggestions ",
                ),
                Tab(
                  text: "Push",
                )
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              VisitorView(),
              SuggestionView(),
              PushView(),
            ],
          )),
    );
  }
}
