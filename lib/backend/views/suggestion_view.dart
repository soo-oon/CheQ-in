import 'package:checkin/backend/viewModels/suggestion_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class SuggestionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SuggestionViewModel>.withConsumer(
      viewModelBuilder: () => SuggestionViewModel(),
      disposeViewModel: false,
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              DataTable(
                columnSpacing: 0.5,
                headingRowHeight: 60,
                dataRowHeight: 30.0,
                columns: [
                  DataColumn(
                      label: Text(
                    "NO",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  )),
                  DataColumn(
                      label: Text(
                    "title",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  )),
                  DataColumn(
                      label: Text(
                    "Content",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  )),
                ],
                rows: model.rows,
              )
            ],
          ),
        ),
      ),
    );
  }
}
