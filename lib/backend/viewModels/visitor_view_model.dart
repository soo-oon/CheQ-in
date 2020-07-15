import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/locator.dart';
import 'package:checkin/models/building.dart';
import 'package:checkin/models/log.dart';
import 'dart:convert';

import 'package:checkin/services/firestore_service.dart';

class VisitorViewModel extends BaseModel {

  final FirestoreService _firestoreService = locator<FirestoreService>();

  List<Building> buildingList = new List<Building>();

  init() async {
    buildingList = await _firestoreService.getBuildings();

    var json = jsonEncode(buildingList[0].toJson());

    print(json);
    print(1);
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }

  
}
