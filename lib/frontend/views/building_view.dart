import 'package:checkin/models/building.dart';
import 'package:checkin/ui/widgets/catagories.dart';
import 'package:flutter/material.dart';

import '../viewModels/building_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

int selectedIndex = 0;
List catagories = ['All', 'Engineering', 'Medical', 'Center', 'Sport'];
Color tabColor;

List selectedIndexs = [true, false, false, false, false];

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CategoryList(),
                    model.busy
                        ? CircularProgressIndicator()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.buildings.length,
                            itemBuilder: (context, index) {
                              if (model.buildings[index].status == 0)
                                return BuildingCard(model, index, "is infected",
                                    Colors.redAccent);
                              else if (model.buildings[index].status == 1)
                                return BuildingCard(model, index, "is cleaned",
                                    Colors.yellowAccent);
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

Widget Catagories() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20),
    height: 30,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: catagories.length,
        itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                // setState(() {
                //   selectedIndex = index;
                //   selectedIndexs[index] = !selectedIndexs[index];
                //   if (selectedIndexs[index])
                //     tabColor = Colors.blueAccent.withOpacity(0.4);
                //   else {
                //     tabColor = Colors.transparent;
                //   }
                // });
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    left: 15, right: index == catagories.length - 1 ? 15 : 0),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(color: tabColor),
                child: Text(catagories[index]),
              ),
            )),
  );
}
