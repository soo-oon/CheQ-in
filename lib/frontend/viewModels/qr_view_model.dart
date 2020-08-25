import 'package:checkin/models/models.dart';
import 'package:checkin/services/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewModel extends BaseModel {
  final NavigationService navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  QRViewController controller;
  String qrText = '';

  List<Building> _buildings;
  List<Building> get buildings => _buildings;
  var _logs;

  init() async {}

  void enterBuilding(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData, {enterlog()}) {
      if (scanData.isNotEmpty) {
        controller.pauseCamera();
        print("scanned");
      }
      qrText = scanData;
    });
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
            time: DateTime.now().toString()));
      }
    }
    setBusy(false);
  }
}
