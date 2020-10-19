import 'package:checkin/frontend/viewModels/visited_view_model.dart';
import 'package:checkin/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class VisitBuildingView extends StatefulWidget {
  @override
  _VisitBuildingViewState createState() => _VisitBuildingViewState();
}

class _VisitBuildingViewState extends State<VisitBuildingView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ViewModelProvider<VisitedViewModel>.withConsumer(
        viewModelBuilder: () => VisitedViewModel(),
        disposeViewModel: false,
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => model.busy
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
                body: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _visitbuildHeader("Soon", size, model.now.year,
                          model.formatted.substring(0, 3), model.now.day),
                      verticalSpaceTiny,
                      Flexible(
                        child: ListView.builder(
                            itemCount: model.visitedBuildings.length,
                            itemBuilder: (BuildContext context, index) {
                              return _listTile(
                                  false,
                                  model.visitedBuildings[index],
                                  buildingsubtitle(index, model),
                                  '2020',
                                  _tileColor(index, model));
                            }),
                      )
                    ],
                  ),
                ),
              ));
  }
}

Color _tileColor(int index, VisitedViewModel model) {
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

String buildingsubtitle(int index, VisitedViewModel model) {
  String i = model.visitedBuildings[index];
  String englishName;
  model.buildings.forEach((element) {
    if (i == element.name) {
      englishName = element.english_name;
    }
  });
  return englishName;
}

List<BoxShadow> shadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.15),
    spreadRadius: 5,
    blurRadius: 5,
    offset: Offset(0, 3),
  )
];

Widget _listTile(bool isSelected, String buildingName, String englishName,
    String date, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15.0),
    height: 80,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: color,
        boxShadow: isSelected ? shadow : null),
    child: Center(
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.ac_unit),
                  horizontalSpaceSmall,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        buildingName,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        englishName,
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    englishName,
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _visitbuildHeader(
    String userName, Size size, int year, String month, int day) {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
        color: Color(0xff3d6bfc),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ]),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/images/CheQ.png"),
                ),
              ),
            ),
            horizontalSpaceSmall,
            Padding(
              padding: EdgeInsets.only(bottom: 3.0),
              child: Text(
                "CHEQ-IN",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_circle,
                    color: Color.fromRGBO(224, 228, 240, 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    userName + " 님이 최근 방문한 강의실",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "DATE :",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        day.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Container(
                        height: 2.0,
                        width: 30,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      children: [
                        Text(
                          month,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Container(
                          height: 2.0,
                          width: 40,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      children: [
                        Text(
                          year.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Container(
                          height: 2.0,
                          width: 50,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildButtons(IconData iconData, String text) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 50,
            color: Colors.blue,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}
