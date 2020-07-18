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
        builder: (context, model, child) => SafeArea(
            child: SingleChildScrollView(
                child: model.busy
                    ? CircularProgressIndicator()
                    : Column(
                        children: <Widget>[
                          Container(
                            child: Text("금일 방문한 곳"),
                          ),
                          SizedBox(
                            height: 400,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: model.visitedBuildings.length,
                                itemBuilder: (context, index) => Container(
                                      height: 50,
                                      width: 200,
                                      child: Card(
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Icon(
                                              Icons.check_circle_outline,
                                              color: primaryColor,
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Text(model.visitedBuildings[index]),
                                            SizedBox(
                                              width: 240,
                                            ),
                                            Icon(Icons.my_location),
                                          ],
                                        ),
                                      ),
                                    )),
                          ),
                        ],
                      ))));
  }
}
