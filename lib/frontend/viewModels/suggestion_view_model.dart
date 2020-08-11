import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/locator.dart';
import 'package:checkin/models/building.dart';
import 'package:checkin/models/log.dart';
import 'package:checkin/services/firestore_service.dart';

import '../../models/suggestion.dart';

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
        //_logs.add(Log(userName: currentUser.fullName, buildingName: buildingName, time: DateTime.now().toString()));
        _firestoreService.updateLogs(Log(
            userName: currentUser.fullName,
            buildingName: buildingName,
            time: DateTime.now().toString()));
      }
    }
    setBusy(false);
  }
}
