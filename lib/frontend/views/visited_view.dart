import 'package:checkin/frontend/viewModels/visited_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

import '../../ui/shared/app_colors.dart';

class VisitedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<VisitedViewModel>.withConsumer(
        viewModelBuilder: () => VisitedViewModel(),
        disposeViewModel: false,
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => model.busy
            ? Center(child:CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                children: <Widget>[
                  buildheader(model.currentUser.fullName, context),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: model.visitedBuildings.length,
                        itemBuilder: (context, index) => Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.97,
                              child: Card(
                                color: cardColor(index, model),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.check_circle_outline,
                                    color: primaryColor,
                                  ),
                                  title: Text(model.visitedBuildings[index]),
                                  subtitle: buildingsubtitle(index, model),
                                  trailing: iconColor(index, model),
                                ),
                              ),
                            )),
                  ),
                ],
              ))));
  }
}

Widget iconColor(int index, VisitedViewModel model) {
  if (model.visitedBuildings[index] == model.lastStop)
    return Icon(
      Icons.my_location,
      color: Colors.redAccent,
    );
  else
    return Icon(
      Icons.my_location,
    );
}

Color cardColor(int index, VisitedViewModel model) {
  String i = model.visitedBuildings[index];
  Color color;
  model.buildings.forEach((element) {
    if (i == element.name) {
      if (element.status == 0)
        color = Colors.redAccent.shade100;
      else if (element.status == 1)
        color = Colors.lightBlue.shade100;
      else
        color = Colors.white;
    }
  });
  return color;
}

Text buildingsubtitle(int index, VisitedViewModel model) {
  String i = model.visitedBuildings[index];
  String english_name;
  model.buildings.forEach((element) {
    if (i == element.name) {
      english_name = element.english_name;
    }
  });
  return Text(english_name);
}

Widget buildheader(String userName, BuildContext context) {
  return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              userName + " 님",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Text(
          "금일 방문한 곳",
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ]));
}
