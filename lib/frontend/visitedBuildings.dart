import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/const.dart';
import 'package:qrscan/qrscan.dart'as scanner;

class VisitedBuildingPage extends StatefulWidget{
  @override
  _VisitedBuildingPageState createState() => _VisitedBuildingPageState();
}

class _VisitedBuildingPageState extends State<VisitedBuildingPage>{

  Buildings _buildings = Buildings();

  @override
  Widget build(BuildContext context) {
   //Buildings.setBuildingStatus(_buildings.buildingNames[1], 0);
    return ListView.builder(
        itemCount: _buildings.buildingNames.length,
        itemBuilder: (BuildContext context, int index){
            return FutureBuilder<int>(
                future: _buildings.getFromSharedPref(_buildings.buildingNames[index]),
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator();
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return BuildingItemPage(
                          bldgStatus: snapshot.data,
                          buildingName: _buildings.buildingNames[index],
                        );
                      }
                  }
                }
              );
        }
    );
  }


}

class Buildings{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<String> buildingNames = [];

  Buildings(){
    buildingNames
      ..add("Buidling1")
      ..add("Buidling2")
      ..add("Buidling3")
      ..add("Buidling4")
    ;
  }

  // set the building status in SP to
  //    one => visited two => visited and infected
  static setBuildingStatus(String buildingName, var status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    status is String
        ?prefs.setString(buildingName, status)
        :prefs.setInt(buildingName, status);
  }

  Future<int> getFromSharedPref(String key){
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getInt(key) == null ? 0 : prefs.getInt(key);
    });
  }

}

class BuildingItemPage extends StatefulWidget{

  const BuildingItemPage({
    Key key,
    @required this.bldgStatus,
    @required this.buildingName
  }) : super(key: key);

  final int bldgStatus;
  final String buildingName;

  @override
  _BuildingItemPageState createState() => _BuildingItemPageState();

}

class _BuildingItemPageState extends State<BuildingItemPage> {

  bool _isInsideThisBldg ;//= false;

  @override
  initState(){
    super.initState();
    setState(() {
      checkCurrentBuilding();
    });
  }
  /// sets the _isInsideThisBldg to true if
  /// the widget being built is the current building
  checkCurrentBuilding()async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.getString("InsideBldg") == widget.buildingName
          ? _isInsideThisBldg = true : _isInsideThisBldg = false ;
    });


  }

  Future _exitBuilding() async {
    String scannedBuilding = await scanner.scan();
  }

  Widget build(BuildContext context) {
    print("started building${widget.buildingName}");
    return widget.bldgStatus == Const.IS_VISITED ?
    Card(
      child: ListTile(
        leading: Icon(
          widget.bldgStatus == Const.IS_INFECTED
              ? Icons.check_circle
              : Icons.check_circle_outline,
          size: 35.0,
          color: Colors.blue,
        ),
        title: Text('${widget.buildingName}'),
        subtitle: Text('Very Cool'),
        trailing: Icon(
            Icons.my_location,
            color: _isInsideThisBldg == true
                ? Colors.red
                : Colors.lightBlue,
          size: 35.0,
        ),
        onTap: _isInsideThisBldg == true
            ? _exitBuilding
            : () => print("Is Not Inside"),
      ),
    ) : Container();
  }
}