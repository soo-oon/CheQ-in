import 'package:checkin/frontend/viewModels/frontend_home_view_Model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class FrontEndHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<FrontEndHomeViewModel>.withConsumer(
      viewModelBuilder: () => FrontEndHomeViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: model.pages[model.currentIndex],
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.react,
          items: [
            TabItem(icon: Icons.location_searching, title: 'Visited'),
            TabItem(icon: Icons.home, title: 'Buildings'),
            TabItem(icon: Icons.track_changes, title: 'QrReader'),
            TabItem(icon: Icons.message, title: 'Suggestion'),
            TabItem(icon: Icons.info, title: 'info'),
          ],
          initialActiveIndex: 0, //optional, default as 0
          onTap: (index) => model.setIndex(index),
        ),
      ),
    );
  }
}
