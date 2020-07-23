import 'package:checkin/frontend/viewModels/building_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class InfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BuildingViewModel>.withConsumer(
      viewModelBuilder: () => BuildingViewModel(),
      builder: (context, model, child) => SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                ],
              ),
            ),
          )
    );
  }
}