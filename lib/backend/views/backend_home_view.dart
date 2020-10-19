import 'package:checkin/backend/viewModels/backend_home_viewModel.dart';
import 'package:checkin/backend/views/push_view.dart';
import 'package:checkin/backend/views/suggestion_view.dart';
import 'package:checkin/backend/views/visitor_view.dart';
import 'package:checkin/frontend/views/building_view.dart';
import 'package:checkin/ui/shared/app_colors.dart';
import 'package:checkin/ui/widgets/exit_app_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class BackEndHomeView extends StatefulWidget {
  @override
  _BackEndHomeViewState createState() => _BackEndHomeViewState();
}

class _BackEndHomeViewState extends State<BackEndHomeView> {
  String tabName = '';

  int number = 0;

  String tabNumber(int index) {
    String title;
    switch (index) {
      case 0:
        title = '차트 보기';
        break;
      case 1:
        title = '전체 건물 상태';
        break;
      case 2:
        title = '푸시 알림';
        break;
      case 3:
        title = '문의 보기';
        break;
      default:
    }
    return title;
  }

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
              title: Center(
                  child: Text(
                tabNumber(number),
                style: TextStyle(color: Colors.white, fontSize: 15),
              )),
              backgroundColor: mainColor,
              bottom: TabBar(
                onTap: (value) {
                  setState(() {
                    number = value;
                  });
                },
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 2.3,
                labelPadding: const EdgeInsets.only(top: 7),
                tabs: [
                  Tab(
                      icon: Icon(
                    Icons.table_chart,
                    color: Colors.white,
                  )),
                  Tab(icon: Icon(Icons.settings, color: Colors.white)),
                  Tab(
                      icon: Icon(Icons.notification_important,
                          color: Colors.white)),
                  Tab(icon: Icon(Icons.question_answer, color: Colors.white)),
                ],
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
