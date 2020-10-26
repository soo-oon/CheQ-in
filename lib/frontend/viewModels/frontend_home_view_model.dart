import 'package:checkin/frontend/views/covid_view_new.dart';
import 'package:checkin/frontend/views/visited_building.dart';
import 'package:flutter/material.dart';
import 'package:checkin/models/models.dart';
import 'package:checkin/frontend/views/front_views.dart';

class FrontEndHomeViewModel extends BaseModel {
  List<Widget> pages = [
    MyHome(),
    VisitBuildingView(),
    QRScanView(),
    InquiryScreen(),
    OptionScreen(),
  ];

  init() async {
    setBusy(true);
    if (qrScanned == true) {
      setIndex(1);
    } else {
      setIndex(0);
    }
    setBusy(false);
  }
}
