import 'package:checkin/backend/viewModels/backend_home_viewModel.dart';
import 'package:checkin/backend/views/info_view.dart';
import 'package:checkin/backend/views/push_view.dart';
import 'package:checkin/backend/views/suggestion_view.dart';
import 'package:checkin/backend/views/visitor_view.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class BackEndHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BackEndHomeViewModel>.withConsumer(
      viewModelBuilder: () => BackEndHomeViewModel(),
      builder: (context, model, child) => DefaultTabController(
          length: 4,
            child: Scaffold(
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
                  ),
                  Tab(
                    text: "Info",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                VisitorView(),
                SuggestionView(),
                PushView(),
                InfoView()
              ],
            )),
      ),
    );
  }
}




