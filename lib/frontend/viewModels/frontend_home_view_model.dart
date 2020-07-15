import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/backend/views/info_view.dart';
import 'package:checkin/frontend/views/building_view.dart';
import 'package:checkin/frontend/views/suggestion_view.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class FrontEndHomeViewModel extends BaseModel {
  List<Widget> pages = [BuildingView(), SizedBox(), SuggestionView(), InfoView()];
  int currentIndex = 0;

  void setIndex(int index) {
    setBusy(true);

    if(index == 1) {
      _enterBuilding();
    } else {
      currentIndex = index;
    }
    setBusy(false);
  }

  void _enterBuilding() async {
    // scan the QR of building
    String scannedBuilding = await scanner.scan();
  }
}