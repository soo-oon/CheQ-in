import 'package:checkin/backend/viewModels/backend_home_viewModel.dart';
import 'package:checkin/backend/views/info_view.dart';
import 'package:checkin/backend/views/visitor_view.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class BackEndHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BackEndHomeViewModel>.withConsumer(
      viewModelBuilder: () => BackEndHomeViewModel(),
      builder: (context, model, child) => SafeArea(
          child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: SizedBox(),
            flexibleSpace: SafeArea(
              child: TabBar(
                //indicatorColor: Colors.transparent,
                tabs: [
                  Tab(text: "Table", icon: Icon(Icons.table_chart)),
                  Tab(text: "Info", icon:Icon(Icons.person))
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              VisitorView(),
              InfoView(),
            ],
          ),
        ),
      )),
    );
  }
}
