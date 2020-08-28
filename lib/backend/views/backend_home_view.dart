import 'package:checkin/backend/viewModels/backend_home_viewModel.dart';
import 'package:checkin/backend/views/push_view.dart';
import 'package:checkin/backend/views/suggestion_view.dart';
import 'package:checkin/backend/views/visitor_view.dart';
import 'package:checkin/frontend/views/building_view.dart';
import 'package:checkin/ui/widgets/exit_app_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class BackEndHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BackEndHomeViewModel>.withConsumer(
      viewModelBuilder: () => BackEndHomeViewModel(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () {
          return exitAppDialogue(context);
        },
        child: SafeArea(
            child: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              flexibleSpace: SafeArea(
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 2.3,
                  labelPadding: const EdgeInsets.only(top: 7),
                  tabs: [
                    Tab(
                        icon: Icon(
                      Icons.table_chart,
                      color: Colors.white,
                    )),
                    Tab(icon: Icon(Icons.build, color: Colors.white)),
                    Tab(
                        icon: Icon(Icons.notification_important,
                            color: Colors.white)),
                    Tab(icon: Icon(Icons.question_answer, color: Colors.white)),
                  ],
                ),
              ),
            ),
            body: TabBarView(
              children: [
                VisitorView(),
                BuildingView(),
                PushView(),
                SuggestionView(),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
