import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/frontend/views/covid_view.dart';
import 'package:checkin/frontend/views/front_info_view.dart';
import 'package:checkin/frontend/views/qr_view.dart';
import 'package:checkin/frontend/views/suggestion_view.dart';
import 'package:checkin/frontend/views/visited_view.dart';
import 'package:checkin/models/building.dart';
import 'package:checkin/models/log.dart';
import 'package:checkin/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../../locator.dart';

class FrontEndHomeViewModel extends BaseModel {
  List<Widget> pages = [
    CovidView(),
    //BuildingView(),
    VisitedView(),
    QRViewExample(),
    //EnterView(),
    SuggestionView(),
    FrontInfoView(),
  ];
  int currentIndex = 0;

  bool isVisited = false;
  final FirestoreService _firestoreService = locator<FirestoreService>();
  List<Building> _buildings;
  List<Building> get buildings => _buildings;
  var _logs;

  init() async {
    setBusy(true);
    _buildings = await _firestoreService.getBuildings();
    _logs = _firestoreService.getLogs();
    setBusy(false);
  }

  void setIndex(int index) {
    setBusy(true);

    /*if (index == 2) {
      print("was here");
      _enterBuilding();
      //currentIndex = index;
      currentIndex = 2;
    } else {*/
      currentIndex = index;
    //}
    setBusy(false);
  }

  void _enterBuilding() async {
    // scan the QR of building
    String scannedBuilding = await scanner.scan();

    enterLog(scannedBuilding);

    setIndex(1);
  }

  void enterLog(String buildingName) {
    setBusy(true);
    for (var building in buildings) {
      if (building.name == buildingName) {
        if (_logs == null) {
          _logs = [];
        }
        _firestoreService.visitedBuildings(buildingName);
        _firestoreService.updateLogs(Log(
            userName: currentUser.fullName,
            buildingName: buildingName,
            phoneNumber: currentUser.phoneNumber,
            time: DateTime.now().toString().substring(0, 19)));
      }
    }
    setBusy(false);
  }

  void listenToPosts() {
    setBusy(true);

    _firestoreService.listenToBuildingsRealTime().listen((postsData) {
      List<Building> updatedPosts = postsData;
      if (updatedPosts != null && updatedPosts.length > 0) {
        _buildings = updatedPosts;
      }

      setBusy(false);
    });
  }
}
