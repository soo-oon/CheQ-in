import 'package:checkin/models/building.dart';
import 'package:checkin/models/log.dart';
import 'package:checkin/services/authentication_service.dart';
import 'package:checkin/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../locator.dart';

class QRScanView extends StatefulWidget {
  const QRScanView({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScanViewState();
}

class _QRScanViewState extends State<QRScanView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  List<Building> _buildings;
  List<Building> get buildings => _buildings;
  var _logs;
  var qrText = '';
  QRViewController controller;

  @override
  void initState() async {
    super.initState();
    _buildings = await _firestoreService.getBuildings();
    _logs = await _firestoreService.getLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: QRView(
            key: qrKey,
            onQRViewCreated: enterBuilding,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.lightBlueAccent,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 200,
            ),
          ),
        ),
      ],
    );
  }

  void enterBuilding(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData, {enterlog()}) {
      if (scanData.isNotEmpty) {
        qrText = scanData;
        controller.pauseCamera();

        print("scanned");
      }
    });
  }

  void enterLog(String buildingName) {
    for (var building in buildings) {
      if (building.name == buildingName) {
        if (_logs == null) {
          _logs = [];
        }
        _firestoreService.visitedBuildings(buildingName);
        _firestoreService.updateLogs(Log(
            userName: _authenticationService.currentUser.fullName,
            buildingName: buildingName,
            time: DateTime.now().toString()));
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
