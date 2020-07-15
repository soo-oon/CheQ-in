import 'dart:convert';
import 'package:checkin/backend/viewModels/visitor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:json_table/json_table.dart';

class VisitorView extends StatelessWidget {

  final String jsonSample =
      '[{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India","area":"abc"}]';

  final bool toggle = true;

  @override
  Widget build(BuildContext context) {

    var json = jsonDecode(jsonSample);

    return ViewModelProvider<VisitorViewModel>.withConsumer(
      viewModelBuilder: () => VisitorViewModel(),
      disposeViewModel: false,
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => SingleChildScrollView(
        child: toggle ? Column(
            children: [
                JsonTable(
                      json,
                      showColumnToggle: true,
                      allowRowHighlight: true,
                      rowHighlightColor: Colors.yellow[500].withOpacity(0.7),
                      paginationRowCount: 20,
                      onRowSelect: (index, map) {
                        print(index);
                        print(map);
                      },
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                  ],
                )
                : Center(
                  child: Text(model.getPrettyJSONString(jsonSample)),
                ),
        ),
    );
  }
}


