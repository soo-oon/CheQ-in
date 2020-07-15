import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/backend/views/info_view.dart';
import 'package:checkin/frontend/views/building_view.dart';
import 'package:checkin/frontend/views/suggestion_view.dart';
import 'package:checkin/models/building.dart';
import 'package:checkin/models/log.dart';
import 'package:checkin/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../../locator.dart';

class FrontEndHomeViewModel extends BaseModel {
  List<Widget> pages = [BuildingView(), SizedBox(), SuggestionView(), InfoView()];
  int currentIndex = 0;

  final FirestoreService _firestoreService = locator<FirestoreService>();
  List<Building> _buildings;
  List<Building> get buildings => _buildings;
  init() {
    listenToPosts();
  }

  void setIndex(int index) {
    setBusy(true);

    if (index == 1) {
      _enterBuilding();
    } else {
      currentIndex = index;
    }
    setBusy(false);
  }

  void _enterBuilding() async {
    // scan the QR of building
    String scannedBuilding = await scanner.scan();

    enterLog(scannedBuilding);
  }

  void enterLog(String buildingName) {
    setBusy(true);
    for (var building in buildings) {
      if (building.name == buildingName) {
        if (building.logs == null) {
          building.logs = [];
        }
        building.logs.add(Log(currentUser, DateTime.now()));
        _firestoreService.updateBuilding(building);
      }
    }
    setBusy(false);
  }

  void listenToPosts() {
    setBusy(true);

    _firestoreService.listenToPostsRealTime().listen((postsData) {
      List<Building> updatedPosts = postsData;
      if (updatedPosts != null && updatedPosts.length > 0) {
        _buildings = updatedPosts;
        notifyListeners();
      }

      setBusy(false);
    });
  }
}
