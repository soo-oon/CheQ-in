import 'package:checkin/backend/viewModels/backend_home_viewModel.dart';
import 'package:checkin/backend/views/info_view.dart';
import 'package:checkin/backend/views/suggestion_view.dart';
import 'package:checkin/backend/views/visitor_view.dart';
import 'package:checkin/frontend/views/building_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider_architecture/provider_architecture.dart';

class BackEndHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BackEndHomeViewModel>.withConsumer(
      viewModelBuilder: () => BackEndHomeViewModel(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () {
          showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('종료'),
              content: new Text('앱을 그만두시겠습니까?'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('아니요'),
                ),
                new FlatButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: new Text('네'),
                ),
              ],
            ),
          );
        },
        child: SafeArea(
            child: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              leading: SizedBox(),
              flexibleSpace: SafeArea(
                child: TabBar(
                  //indicatorColor: Colors.transparent,
                  tabs: [
                    Tab(
                        text: "Table",
                        icon: Icon(
                          Icons.table_chart,
                          color: Colors.white,
                        )),
                    Tab(
                        text: "Sugg",
                        icon: Icon(Icons.notification_important,
                            color: Colors.white)),
                    Tab(
                        text: "Building",
                        icon: Icon(Icons.build, color: Colors.white)),
                    Tab(
                        text: "Info",
                        icon: Icon(Icons.person, color: Colors.white))
                  ],
                ),
              ),
            ),
            body: TabBarView(
              children: [
                VisitorView(),
                SuggestionView(),
                BuildingView(),
                InfoView(),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
