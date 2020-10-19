import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/ui/widgets/building_tile.dart';
import 'package:flutter/material.dart';
import '../viewModels/building_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import '../../ui/widgets/building_card.dart';

int selectedIndex = 0;
Color tabColor;

List<BoxShadow> shadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.15),
    spreadRadius: 5,
    blurRadius: 5,
    offset: Offset(0, 3),
  )
];
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
                  Container(
                    padding: EdgeInsets.all(10),
                  ),
                  model.busy
                      ? CircularProgressIndicator()
                      : SizedBox(
                          height: MediaQuery.of(context).size.height / 1.3,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: model.buildings.length,
                            itemBuilder: (context, index) {
                              if (model.buildings[index].status == 0)
                                return BuildingTile(
                                  buildingName: model.buildings[index].name,
                                  englishName:
                                      model.buildings[index].english_name,
                                  date: model.date,
                                  onTap: () {
                                    dialog(model, context, index);
                                  },
                                  color: Colors.redAccent.shade100,
                                );
                              else if (model.buildings[index].status == 1)
                                return BuildingTile(
                                  buildingName: model.buildings[index].name,
                                  englishName:
                                      model.buildings[index].english_name,
                                  date: model.date,
                                  onTap: () {
                                    dialog(model, context, index);
                                  },
                                  color: Colors.blueAccent.shade100,
                                );
                              else
                                return BuildingTile(
                                  buildingName: model.buildings[index].name,
                                  englishName:
                                      model.buildings[index].english_name,
                                  date: model.date,
                                  onTap: () {
                                    dialog(model, context, index);
                                  },
                                  color: Colors.white,
                                );
                            },
                          ),
                        )
                ],
              )),
            ));
  }
}

Future dialog(BuildingViewModel model, BuildContext context, int index) {
  return showDialog(
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
                    model.sendPush(
                        "경고", model.buildings[index].name + "은 현재 감염되었습니다.");
                    model
                        .getFirestoreService()
                        .updateBuilding(model.buildings[index]);
                  },
                  child: Text("감염"),
                ),
                RaisedButton(
                  onPressed: () {
                    model.buildings[index].status = 1;
                    model.sendPush(
                        "알림", model.buildings[index].name + "은 현재 방역중입니다.");
                    model
                        .getFirestoreService()
                        .updateBuilding(model.buildings[index]);
                  },
                  child: Text("안전"),
                ),
                RaisedButton(
                  onPressed: () {
                    model.buildings[index].status = 2;
                    model.sendPush(
                        "알림", model.buildings[index].name + "은 현재 안전합니다.");
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
}
