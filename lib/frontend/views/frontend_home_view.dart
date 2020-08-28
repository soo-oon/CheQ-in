import 'package:checkin/frontend/viewModels/frontend_home_view_Model.dart';
import 'package:checkin/ui/widgets/exit_app_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:checkin/constants/route_names.dart';

class FrontEndHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<FrontEndHomeViewModel>.withConsumer(
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => FrontEndHomeViewModel(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () {
          return exitAppDialogue(context);
        },
        child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
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
                        color: model.screenCurrnetIndex == 0
                            ? Const.SELECTED_COLOR
                            : Const.UNSELECTED_COLOR,
                        onPressed: () => model.setIndex(0),
                      ),
                      IconButton(
                        icon: Icon(Icons.track_changes),
                        color: model.screenCurrnetIndex == 1
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
                        color: model.screenCurrnetIndex == 3
                            ? Const.SELECTED_COLOR
                            : Const.UNSELECTED_COLOR,
                        onPressed: () => model.setIndex(3),
                      ),
                      IconButton(
                        icon: Icon(Icons.info),
                        color: model.screenCurrnetIndex == 4
                            ? Const.SELECTED_COLOR
                            : Const.UNSELECTED_COLOR,
                        onPressed: () => model.setIndex(4),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}
