import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/backend/views/info_view.dart';
import 'package:checkin/backend/views/push_view.dart';
import 'package:checkin/backend/views/suggestion_view.dart';
import 'package:checkin/backend/views/visitor_view.dart';
import 'package:flutter/material.dart';

class BackEndHomeViewModel extends BaseModel {
  List<Widget> pages = [VisitorView(), SuggestionView(), PushView(), InfoView()];
  int currentIndex = 0;

  void setIndex(int index) {
    setBusy(true);
    currentIndex = index;
    setBusy(false);
    print(currentIndex);
  }
}