import 'dart:io';

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
                  Text("전체 건물 상태"),
                  //CategoryList(),
                  model.busy
                      ? CircularProgressIndicator()
                      : SizedBox(
                          height: MediaQuery.of(context).size.height / 1.3,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: model.buildings.length,
                            itemBuilder: (context, index) {
                              if (model.buildings[index].status == 0)
                                return buildingCard(model, index,
                                    Colors.redAccent.shade100, context);
                              else if (model.buildings[index].status == 1)
                                return buildingCard(model, index,
                                    Colors.lightBlue.shade100, context);
                              else
                                return buildingCard(
                                    model, index, Colors.white, context);
                            },
                          ),
                        )
                ],
              )),
            ));
  }
}

Widget buildingCard(
    BuildingViewModel model, int index, Color color, BuildContext context) {
  return Container(
    width: 200,
    child: GestureDetector(
      onTap: () {
        if (model.isAdmin)
          showDialog(
            context: context,
            child: AlertDialog(
              title: Text("건물 상태변경"),
              actions: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            model.buildings[index].status = 0;
                            model.sendPush("경고",
                                model.buildings[index].name + "은 현재 감염되었습니다.");
                            model
                                .getFirestoreService()
                                .updateBuilding(model.buildings[index]);
                          },
                          child: Text("감염"),
                        ),
                        RaisedButton(
                          onPressed: () {
                            model.buildings[index].status = 1;
                            model.sendPush("알림",
                                model.buildings[index].name + "은 현재 방역중입니다.");
                            model
                                .getFirestoreService()
                                .updateBuilding(model.buildings[index]);
                          },
                          child: Text("안전"),
                        ),
                        RaisedButton(
                          onPressed: () {
                            model.buildings[index].status = 2;
                            model.sendPush("알림",
                                model.buildings[index].name + "은 현재 안전합니다.");
                            model
                                .getFirestoreService()
                                .updateBuilding(model.buildings[index]);
                          },
                          child: Text("방역 중"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
      },
      child: Card(
        color: color,
        child: ListTile(
          title: Text(model.buildings[index].name),
          subtitle: Text(model.buildings[index].english_name),
          trailing: Icon(Icons.location_on),
        ),
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
