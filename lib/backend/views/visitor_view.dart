import 'package:auto_size_text/auto_size_text.dart';
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
      builder: (context, model, child) => SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              model.busy
                  ? SizedBox()
                  : Container(
                      child: ExpansionTile(
                        expandedAlignment: Alignment.centerLeft,
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        childrenPadding: EdgeInsets.all(20),
                        title: Text("Filter"),
                        children: [
                          Text("Start"),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(model.startDate.toString().substring(0, 10)),
                              FlatButton(
                                child: Icon(Icons.calendar_today),
                                onPressed: () {
                                  model.setStartDateTime(context);
                                },
                              )
                            ],
                          ),
                          Text("End"),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(model.endDate.toString().substring(0, 10)),
                              FlatButton(
                                child: Icon(Icons.calendar_today),
                                onPressed: () {
                                  model.setEndDateTime(context);
                                },
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButton(
                                value: model.building,
                                items: <String>[
                                  "봉경관",
                                  "덕래관",
                                  "공대1호관"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  model.setBuildingName(value);
                                },
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                child: Text("Query Now"),
                                onPressed: () {},
                              )
                            ],
                          )
                        ],
                      ),
                    ),
              model.busy
                  ? CircularProgressIndicator()
                  : JsonTable(
                      model.logDecodedJsonData,
                      showColumnToggle: false,
                      allowRowHighlight: true,
                      rowHighlightColor: Colors.yellow[500].withOpacity(0.7),
                      paginationRowCount: 11,
                      tableHeaderBuilder: (String header) {
                        if (header == "userName")
                          header = "이름";
                        else if (header == "buildingName")
                          header = "건물";
                        else
                          header = "시간";
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 8.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.8,
                              ),
                              color: Colors.grey[300]),
                          child: Text(
                            header,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.grey[900]),
                          ),
                        );
                      },
                      tableCellBuilder: (value) {
                        return Container(
                          height: 30,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.8,
                                  color: Colors.grey.withOpacity(0.5))),
                          child: Text(
                            value,
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.grey[900]),
                          ),
                        );
                      },
                      onRowSelect: (index, map) {},
                    )
            ],
          ),
        ),
      ),
    );
  }
}
