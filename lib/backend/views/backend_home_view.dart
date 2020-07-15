import 'package:checkin/backend/viewModels/backend_home_viewModel.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class BackEndHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BackEndHomeViewModel>.withConsumer(
      viewModelBuilder: () => BackEndHomeViewModel(),
      builder: (context, model, child) => Scaffold(
          bottomNavigationBar: ConvexAppBar(
            items: [
              TabItem(icon: Icons.ac_unit, title: 'Home'),
              TabItem(icon: Icons.access_time, title: 'info'),
              TabItem(icon: Icons.add_call, title: 'sugg'),
              TabItem(icon: Icons.dashboard, title: 'push')
            ],
            onTap: (index) => model.setIndex(index),
          ),
          body: model.pages[model.currentIndex]),
    );
  }
}
