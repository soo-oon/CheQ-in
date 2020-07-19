import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/models/suggestion.dart';
import 'package:checkin/services/firestore_service.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';

class SuggestionViewModel extends BaseModel {
  
  final FirestoreService _firestoreService = locator<FirestoreService>();
  List<Suggestion> _suggestions;
  List<Suggestion> get suggestions => _suggestions;
  List<List<DataCell>> datas;
  List<DataCell> data;
  List<DataRow> rows = [];
  init() async{
    setBusy(true);
    _suggestions = await _firestoreService.getSuggestions();
    int n = 1;
    for(var i in _suggestions)
    {
      rows.add(DataRow(
        cells: [DataCell(Text("${n}")),
      DataCell(Text(i.title)),
      DataCell(Text(i.content))]));
      n+=1;
    }
    setBusy(false);
  }

  sortByNumber() {}
  sortByTime() {}
  sortByName() {}
}
