import 'package:checkin/frontend/viewModels/visited_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

import '../../ui/shared/app_colors.dart';

class VisitedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<VisitedViewModel>.withConsumer(
        viewModelBuilder: () => VisitedViewModel(),
        disposeViewModel: false,
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => model.busy
            ? CircularProgressIndicator()
            : SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "금일 방문한 곳",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: model.visitedBuildings.length,
                        itemBuilder: (context, index) => Container(
                              height: MediaQuery.of(context).size.height / 12,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.check_circle_outline,
                                    color: primaryColor,
                                  ),
                                  title: Text(model.visitedBuildings[index]),
                                  trailing: iconColor(index, model),
                                ),
                              ),
                            )),
                  ),
                ],
              ))));
  }
}

Widget iconColor(int index, VisitedViewModel model) {
  if (model.visitedBuildings[index] == model.lastStop)
    return Icon(
      Icons.my_location,
      color: Colors.redAccent,
    );
  else
    return Icon(
      Icons.my_location,
    );
}
