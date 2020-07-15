import 'package:checkin/models/building.dart';
import 'package:checkin/ui/shared/shared_styles.dart';
import 'package:checkin/ui/widgets/catagories.dart';
import 'package:flutter/material.dart';

import '../viewModels/building_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

class BuildingView extends StatelessWidget {
  String building = "Engineering";
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BuildingViewModel>.withConsumer(
        viewModelBuilder: () => BuildingViewModel(),
        disposeViewModel: false,
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => SingleChildScrollView(
                child: Column(
              children: <Widget>[
                CategoryList(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.buildings.length,
                  itemBuilder: (context, index) {
                    return NoticeSampleWidget(
                        context,
                        model.buildings[index].name,
                        "is infected",
                        Colors.redAccent,
                        index);
                  },
                )
              ],
            )));
  }
}

// Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   "Test Buildings",
//                   style: TextStyle(fontSize: 30),
//                 ),
//                 Container(
//                   alignment: Alignment.centerRight,
//                   child: DropdownButton<String>(
//                     value: building,
//                     onChanged: (String newValue) {
//                       building = newValue;
//                       model.notifyListeners();
//                     },
//                     items: <String>["Engineering", "Sport", "Medical", "Center"]
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 // ListView.builder(
//                 //   scrollDirection: Axis.vertical,
//                 //   itemCount: model.buildings.length,
//                 //   itemBuilder: (context, index) {
//                 //     if (model.buildings[index].status == Status.cleaned)
//                 //       return Card(
//                 //         color: Colors.lightGreenAccent,
//                 //         child: Text(model.buildings[index].name + "is cleaned"),
//                 //       );
//                 //     if (model.buildings[index].status == Status.infected)
//                 //       return Card(
//                 //         color: Colors.redAccent,
//                 //         child: Text(model.buildings[index].name + "is cleaned"),
//                 //       );
//                 //   },
//                 // )
//               ],
//             )

// ignore: non_constant_identifier_names
Widget NoticeSampleWidget(BuildContext context, String stateOfRisk,
    String comment, Color color, int index) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 20.0,
    ),
    //color: Colors.blueAccent,
    height: MediaQuery.of(context).size.height / 7,
    //width: MediaQuery.of(context).size.width,
    child: GestureDetector(
      child: InkWell(
        onTap: () {},
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 7,
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: color,
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 5,
              child: SizedBox(
                height: 90,
                width: MediaQuery.of(context).size.width - 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(stateOfRisk),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(22),
                              bottomRight: Radius.circular(22))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        comment,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
