import 'package:checkin/frontend/viewModels/building_view_model.dart';
import 'package:flutter/material.dart';

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
