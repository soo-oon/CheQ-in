import 'package:checkin/ui/view/building_view.dart';
import 'package:checkin/widget/buildingviewWidget.dart';
import 'package:checkin/widget/cardstyle.dart';
import 'package:checkin/widget/notificationlist.dart';
import 'package:checkin/widget/suggestion.dart';
import '../models/notification.dart';
import 'package:provider/provider.dart';

import 'personalData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';
import '../util/const.dart';
import '../util/fireBaseHelper.dart';
import 'registration.dart';
import 'visitedBuildings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isRegistered = prefs.getString('isRegistered');

  print(isRegistered);

  runApp(
      MaterialApp(home: isRegistered == null ? RegisterForm() : CheckInHome()));
}

class CheckInHome extends StatefulWidget {
  CheckInHome({Key key}) : super(key: key);
  @override
  _CheckInState createState() => _CheckInState();
}

class _CheckInState extends State<CheckInHome> {
  PageController _checkInPages = PageController(initialPage: 0);
  PersonalData _pData = PersonalData();
  FireBaseHelper _fbHelper = new FireBaseHelper();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  void _changePage(int index) {
    setState(() {
      _checkInPages.jumpToPage(index);
    });
  }

  Future _enterBuilding() async {
    // scan the QR of building
    String scannedBuilding = await scanner.scan();

    // to update the list view in the visited buildings
    Buildings.setBuildingStatus(scannedBuilding, Const.IS_VISITED);
    // to know which building is the user is in currently
    Buildings.setBuildingStatus("InsideBldg", scannedBuilding);

    // Combine the scanned QR with personal data and add to DB
    _pData.getPersonalData();
    Map map = await _pData.toMap();
    _fbHelper.addToFDB(map, "visitors");

    // After completing scan get back to the first page
    _changePage(0);
  }

  List<NotificationRisk> list = [];
  NotificationRisk noto = NotificationRisk(true, "Building1 is infected");
  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      list.add(noto);
      list.add(noto);
    }
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NotificationList(list)),
        ],
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => RegisterForm()));
                },
              )
            ],
            title: Text("KMU Check In"),
          ),
          body: PageView(
            controller: _checkInPages,
            //physics: new NeverScrollableScrollPhysics(),
            children: <Widget>[
              Center(
                child: Container(
                  child: VisitedBuildingPage(),
                ),
              ),
              Center(
                child: Container(
                  child: DisplayInformationPage(), //Text('Empty Body 1'),
                ),
              ),
              Center(
                child: Container(
                  child: BuildingViewWidget(),
                ),
              ),
              Center(
                child: Container(
                  child: Suggestion(),
                ),
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.settings_overscan),
            onPressed: _enterBuilding,
            backgroundColor: Colors.lightBlue,
          ),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: Colors.lightBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.track_changes),
                  onPressed: () {
                    _changePage(0);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    _changePage(1);
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                ),
                IconButton(
                  icon: Icon(Icons.notification_important),
                  onPressed: () {
                    _changePage(2);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    _changePage(3);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
