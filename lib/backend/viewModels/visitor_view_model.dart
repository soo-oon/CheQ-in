import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/locator.dart';
import 'package:checkin/models/building.dart';
import 'package:checkin/models/log.dart';
import 'dart:convert';

import 'package:checkin/services/firestore_service.dart';

class VisitorViewModel extends BaseModel {

  final FirestoreService _firestoreService = locator<FirestoreService>();
  List<Building> buildingList = new List<Building>();
  List<Log> logList = new List<Log>();
  var buildingEncodedJsonData;
  var buildingDecodedJsonData;
  var logEncodedJsonData;
  var logDecodedJsonData;

  init() async {
    setBusy(true);
    buildingList = await _firestoreService.getBuildings();
    logList = await _firestoreService.getLogs();

    buildingEncodedJsonData = jsonEncode(buildingList);
    buildingDecodedJsonData = jsonDecode(buildingEncodedJsonData) as List;

    logEncodedJsonData = jsonEncode(logList);
    logDecodedJsonData = jsonDecode(logEncodedJsonData) as List;

    setBusy(false);
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }

  getBuildingLogList(jsonObject) {

  }
}
