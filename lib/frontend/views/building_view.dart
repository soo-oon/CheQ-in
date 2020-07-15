import 'package:checkin/locator.dart';
import 'package:checkin/widget/buildingviewWidget.dart';
import 'package:flutter/material.dart';

import '../viewModels/building_viewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

import '../../models/building.dart';

class BuildingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BuildingViewModel>.withConsumer(
      disposeViewModel: false,
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Center(
          child: SingleChildScrollView(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text("check it"),
            onPressed: () {
              model.enterLog("봉경관");
            },
          ),
          Text(model.buildings[0].name),
          BuildingViewWidget(),
        ],
      ))),
      viewModelBuilder: () => BuildingViewModel(),
    );
  }
}
