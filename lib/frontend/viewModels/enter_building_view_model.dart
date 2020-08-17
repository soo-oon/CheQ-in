import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/constants/route_names.dart';
import 'package:checkin/locator.dart';
import 'package:checkin/models/building.dart';
import 'package:checkin/models/log.dart';
import 'package:checkin/services/firestore_service.dart';
import 'package:checkin/services/navigation_service.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class EnterBuildingViewModel extends BaseModel {
  final NavigationService navigationService = locator<NavigationService>();

  final FirestoreService _firestoreService = locator<FirestoreService>();
  List<Building> _buildings;
  List<Building> get buildings => _buildings;
  var _logs;
  init() async {
    _enterBuilding();
    navigationService.navigateTo(VisitedViewRoute);
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
