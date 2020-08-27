import 'package:checkin/constants/route_names.dart';
import 'package:checkin/models/models.dart';
import 'package:checkin/services/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';

class QRScanViewModel extends BaseModel {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<Building> _buildings;
  List<Building> get buildings => _buildings;
  var _logs;
  var qrText = '';
  String _todayKey;
  QRViewController controller;

  void init() async {
    _buildings = await _firestoreService.getBuildings();
    _logs = await _firestoreService.getLogs();
  }

  void enterBuilding(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.isNotEmpty) {
        qrText = scanData;
        controller.pauseCamera();
        enterLog(qrText);
        setQrScanned(true);
        _navigationService.navigateTo(FrontEndHomeViewRoute);
      }
    });
  }

  void enterLog(String buildingName) {
    for (var building in buildings) {
      if (building.name == buildingName) {
        if (_logs == null) {
          _logs = [];
        }

        //key associated everyday a user enters a new building
        _todayKey = currentUser.phoneNumber + buildingName + DateTime.now().toString().substring(0,10);

        _firestoreService.visitedBuildings(buildingName);

        _firestoreService.updateLogs(Log(
            userName: currentUser.fullName,
            buildingName: buildingName,
            phoneNumber: currentUser.phoneNumber,
            time: DateTime.now().toString().substring(0,19),
            key: _todayKey));

      }
    }
  }


}