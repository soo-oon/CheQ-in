import 'package:checkin/models/building.dart';
import 'package:checkin/ui/widgets/catagories.dart';
import 'package:flutter/material.dart';

import '../viewModels/building_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

class BuildingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BuildingViewModel>.withConsumer(
        viewModelBuilder: () => BuildingViewModel(),
        disposeViewModel: false,
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => SafeArea(
              child: DefaultTabController(
                length: 3,
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    TabBar(
                      tabs: <Widget>[
                        Tab(
                          text: "All",
                        ),
                        Tab(
                          text: "All",
                        ),
                        Tab(
                          text: "All",
                        ),
                      ],
                    ),
                    //CategoryList(),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.buildings.length,
                      itemBuilder: (context, index) {
                        if (model.buildings[index].status == 0)
                          return BuildingCard(
                              model, index, "is infected", Colors.redAccent);
                        else if (model.buildings[index].status == 1)
                          return BuildingCard(
                              model, index, "is cleaned", Colors.yellowAccent);
                        else
                          return BuildingCard(
                              model, index, "is green", Colors.black12);
                      },
                    )
                  ],
                )),
              ),
            ));
  }
}

Widget BuildingCard(
    BuildingViewModel model, int index, String comment, Color color) {
  return Card(
    color: color,
    child: ListTile(
      title: Text(model.buildings[index].name),
      trailing: Text(comment),
    ),
  );
}
