import 'package:checkin/frontend/viewModels/frontend_home_view_model.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class FrontEndHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<FrontEndHomeViewModel>.withConsumer(
      viewModelBuilder: () => FrontEndHomeViewModel(),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: ConvexAppBar(
            style: TabStyle.fixedCircle,
            items: [
              TabItem(icon: Icons.home, title: 'Buildings'),
              TabItem(icon: Icons.camera, title: 'QR스캔'),
              TabItem(icon: Icons.people, title: 'Suggestions'),
            ],
            onTap: (index) => model.setIndex(index),
          ),
          body: model.pages[model.currentIndex],
     ),
    );
  }
}