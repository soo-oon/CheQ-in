import 'package:flutter/material.dart';
import '../viewModels/building_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import '../../ui/widgets/building_card.dart';

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
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "전체 건물 상태",
                        style: TextStyle(fontSize: 20),
                      )),
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
