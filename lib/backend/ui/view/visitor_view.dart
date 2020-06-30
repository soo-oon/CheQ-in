import 'package:checkin/backend/viewModel/visitor_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class VisitorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<VisitorViewModel>.withConsumer(
      viewModelBuilder: () => VisitorViewModel(),
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
                    "Building",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  )),
                  DataColumn(
                      label: Text(
                    "Phone",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  )),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('2020/6/30')),
                    DataCell(Text('Taewook')),
                    DataCell(Text('Building1')),
                    DataCell(Text('010-9999999')),
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
