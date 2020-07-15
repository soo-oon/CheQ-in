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
                SizedBox(
                  height: 15,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.buildings.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.redAccent,
                      child: Center(child: Text('Entry ${index}')),
                    );
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
