import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/locator.dart';
import 'package:checkin/models/building.dart';
import 'package:checkin/models/log.dart';
import 'dart:convert';

import 'package:checkin/services/firestore_service.dart';
import 'package:flutter/material.dart';

class VisitorViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List<Building> buildingList = new List<Building>();
  List<Log> logList = new List<Log>();
  var buildingEncodedJsonData;
  var buildingDecodedJsonData;
  var logEncodedJsonData;
  var logDecodedJsonData;

  //Query variables
  DateTime startDate;
  DateTime endDate;
  String building;

  init() async {
    setBusy(true);
    buildingList = await _firestoreService.getBuildings();
    logList = await _firestoreService.getLogs();

    buildingEncodedJsonData = jsonEncode(buildingList);
    buildingDecodedJsonData = jsonDecode(buildingEncodedJsonData) as List;

    logEncodedJsonData = jsonEncode(logList);
    logDecodedJsonData = jsonDecode(logEncodedJsonData) as List;

    startDate = DateTime.now();
    endDate = DateTime(2021);
    building = "덕래관";
    setBusy(false);
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }

  Future setStartDateTime(BuildContext context) async {
    setBusy(true);
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2021));

    if (picked != null) {
      startDate = picked;
    }
    setBusy(false);
  }

  Future setEndDateTime(BuildContext context) async {
    setBusy(true);
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now(),
        lastDate: new DateTime(2021));

    if (picked != null) {
      endDate = picked;
    }
    setBusy(false);
  }

  void setBuildingName(String value) {
    setBusy(true);
    building = value;
    setBusy(false);
  }
}
