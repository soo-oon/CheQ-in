import 'package:checkin/frontend/viewModels/frontend_home_view_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class FrontEndHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<FrontEndHomeViewModel>.withConsumer(
      viewModelBuilder: () => FrontEndHomeViewModel(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () {
          showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('종료'),
              content: new Text('앱을 나가실 껀가요?'),
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
        child: Scaffold(
          backgroundColor: Colors.white,
          body: model.pages[model.currentIndex],
          bottomNavigationBar: ConvexAppBar(
            style: TabStyle.react,
            items: [
              TabItem(icon: Icons.home, title: '빌딩 상태'),
              TabItem(icon: Icons.location_searching, title: '방문한 곳'),
              TabItem(icon: Icons.track_changes, title: 'QrReader'),
              TabItem(icon: Icons.message, title: '제안'),
              TabItem(icon: Icons.info, title: '계정'),
            ],
            initialActiveIndex: 0, //optional, default as 0
            onTap: (index) => model.setIndex(index),
          ),
        ),
      ),
    );
  }
}
