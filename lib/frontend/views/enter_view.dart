import 'package:checkin/constants/route_names.dart';
import 'package:checkin/frontend/viewModels/enter_building_view_model.dart';
import 'package:checkin/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider_architecture/provider_architecture.dart';

import '../../locator.dart';

// // ignore: must_be_immutable
// class EnterView extends StatefulWidget {
//   final NavigationService navigationService = locator<NavigationService>();
//   void initState() {
//     navigationService.navigateTo(VisitedViewRoute);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelProvider<EnterBuildingViewModel>.withConsumer(
//       viewModelBuilder: () => EnterBuildingViewModel(),
//       disposeViewModel: false,
//       onModelReady: (model) => model.init(),
//       builder: (context, model, child) => Center(),
//     );
//   }
// }

class EnterView extends StatefulWidget {
  State<StatefulWidget> createState() => EnterViewWidget();
}

class EnterViewWidget extends State<EnterView> {
  final NavigationService navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) => SafeArea(
        child: Center(
          child: SizedBox(),
        ),
      );

  @override
  initState() {
    navigationService.navigateTo(VisitedViewRoute);
  }
}
