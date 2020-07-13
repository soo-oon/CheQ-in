import 'package:checkin/backend/viewModels/suggestion_viewModel.dart';
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
                    "Date",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  )),
                  DataColumn(
                      label: Text(
                    "Name",
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
                rows: [
                  //Need to limit content's text length
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('2020/6/30')),
                    DataCell(Text('Taewook')),
                    DataCell(Text('This must be fixed')),
                  ])
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
