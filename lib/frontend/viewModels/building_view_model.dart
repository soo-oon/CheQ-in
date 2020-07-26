import 'package:checkin/models/building.dart';
import 'package:checkin/models/log.dart';
import 'package:checkin/services/firestore_service.dart';

import 'package:checkin/locator.dart';
import 'package:checkin/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../backend/viewModels/base_model.dart';

class BuildingViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService navigationService = locator<NavigationService>();

  List<Building> _buildings;
  bool isAdmin = false;
  List<Building> get buildings => _buildings;
  init() {
    if (currentUser.userRole == "Admin") isAdmin = true;
    listenToPosts();
  }

  // void enterLog(String buildingName) {
  //   setBusy(true);
  //   for (var building in buildings) {
  //     if (building.name == buildingName) {
  //       if (building.logs == null) {
  //         building.logs = [];
  //       }
  //       var f = new DateFormat('yyyy-MM-dd hh:mm');

  //       building.logs.add(Log(userName: currentUser.fullName, time: f.format(DateTime.now())));
  //       _firestoreService.updateBuilding(building);
  //     }
  //   }
  //   setBusy(false);
  // }

  void listenToPosts() {
    setBusy(true);

    _firestoreService.listenToBuildingsRealTime().listen((postsData) {
      List<Building> updatedPosts = postsData;
      if (updatedPosts != null && updatedPosts.length > 0) {
        _buildings = updatedPosts;
        notifyListeners();
      }

      setBusy(false);
    });
  }

  void fetchBuildings() async {
    _buildings = await _firestoreService.getBuildings();
  }

  FirestoreService getFirestoreService() {
    return _firestoreService;
  }
}
