import 'package:checkin/models/models.dart';
import 'package:checkin/services/services.dart';

class SuggestionViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  List<Building> _buildings;
  List<Log> _logs;

  init() async {
    _buildings = await _firestoreService.getBuildings();
    _logs = await _firestoreService.getLogs();
  }

  void addSuggestion(Suggestion suggestion) {
    _firestoreService.addSuggestion(suggestion);
  }

  void enterLog(String buildingName) {
    setBusy(true);
    for (var building in _buildings) {
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
