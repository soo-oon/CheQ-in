import 'package:checkin/backend/viewModels/visitor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:json_table/json_table.dart';

class VisitorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<VisitorViewModel>.withConsumer(
      viewModelBuilder: () => VisitorViewModel(),
      disposeViewModel: false,
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            model.busy
                ? CircularProgressIndicator()
                : JsonTable(
                    model.logDecodedJsonData,
                    showColumnToggle: false,
                    allowRowHighlight: true,
                    rowHighlightColor: Colors.yellow[500].withOpacity(0.7),
                    paginationRowCount: 20,
                    onRowSelect: (index, map) {
                      print(index);
                      print(map);
                    },
                  )
          ],
        ),
      ),
    );
  }
}
