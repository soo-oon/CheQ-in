import 'package:flutter/material.dart';
import 'package:checkin/models/models.dart';
import 'package:checkin/frontend/views/front_views.dart';

class FrontEndHomeViewModel extends BaseModel {
  List<Widget> pages = [
    CovidView(),
    VisitedView(),
    QRScanView(),
    SuggestionView(),
    FrontInfoView(),
  ];

  init() async {
    setBusy(true);
    if(qrScanned == true) {
      setIndex(1);
    } else {
      setIndex(0);
    }
    setBusy(false);
  }
}
