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
              child: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  CategoryList(),
                  model.busy
                      ? CircularProgressIndicator()
                      : SizedBox(
                          height: 400,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: model.buildings.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 200,
                                child: Card(
                                  color: Colors.white70,
                                  child: ListTile(
                                    title: Text(model.buildings[index].name),
                                    trailing: Text("no problem"),
                                  ),
                                ),
                              );
                              // if (model.buildings[index].status == 0)
                              //   return buildingCard(model, index, "is infected",
                              //       Colors.redAccent);
                              // else if (model.buildings[index].status == 1)
                              //   return buildingCard(model, index, "is cleaned",
                              //       Colors.yellowAccent);
                              // else
                              //   return buildingCard(
                              //       model, index, "is green", Colors.black12);
                            },
                          ),
                        )
                ],
              )),
            ));
  }
}

Widget buildingCard(
    BuildingViewModel model, int index, String comment, Color color) {
  return Container(
    child: Card(
      color: color,
      child: ListTile(
        title: Text(model.buildings[index].name),
        trailing: Text(comment),
      ),
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
