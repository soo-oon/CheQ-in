import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/locator.dart';
import 'package:checkin/models/building.dart';
import 'dart:convert';

import 'package:checkin/services/firestore_service.dart';

class VisitorViewModel extends BaseModel {

  final FirestoreService _firestoreService = locator<FirestoreService>();
  List<Building> buildingList = new List<Building>();
  var encodedJsonData;
  var decodedJsonData;

  init() async {
    setBusy(true);
    buildingList = await _firestoreService.getBuildings();

    encodedJsonData = jsonEncode(buildingList);
    decodedJsonData = jsonDecode(encodedJsonData);
    setBusy(false);
    // print(json);
    // print(1);
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }

  
}
