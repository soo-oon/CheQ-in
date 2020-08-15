import 'package:checkin/frontend/viewModels/frontend_home_view_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:checkin/constants/route_names.dart';
//import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class FrontEndHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<FrontEndHomeViewModel>.withConsumer(
      onModelReady: (model) => model.init(),
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
            appBar: AppBar(
              title: Text(
                "KMU CI",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.camera,
                color: Const.SELECTED_COLOR,
                size: 45,
              ),
              onPressed: () => model.setIndex(2),
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
            body: model.pages[model.currentIndex],
            bottomNavigationBar: BottomAppBar(
                shape: CircularNotchedRectangle(),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.home),
                      color: model.currentIndex == 0
                          ? Const.SELECTED_COLOR
                          : Const.UNSELECTED_COLOR,
                      onPressed: () => model.setIndex(0),
                    ),
                    IconButton(
                      icon: Icon(Icons.track_changes),
                      color: model.currentIndex == 1
                          ? Const.SELECTED_COLOR
                          : Const.UNSELECTED_COLOR,
                      onPressed: () => model.setIndex(1),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                    ),
                    IconButton(
                      icon: Icon(Icons.comment),
                      color: model.currentIndex == 3
                          ? Const.SELECTED_COLOR
                          : Const.UNSELECTED_COLOR,
                      onPressed: () => model.setIndex(3),
                    ),
                    IconButton(
                      icon: Icon(Icons.info),
                      color: model.currentIndex == 4
                          ? Const.SELECTED_COLOR
                          : Const.UNSELECTED_COLOR,
                      onPressed: () => model.setIndex(4),
                    ),
                  ],
                ))),
      ),
    );
  }
}
