import 'package:checkin/backend/viewModels/visitor_view_model.dart';
import 'package:checkin/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height / 2 - 50,
                    )
                  : Container(
                      child: ExpansionTile(
                        title: Text("Filter"),
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("날짜"),
                              SizedBox(
                                width: 10,
                              ),
                              Text(model.startDate.toString().substring(0, 10)),
                              FlatButton(
                                child: Icon(Icons.calendar_today),
                                onPressed: () {
                                  model.setStartDateTime(context);
                                },
                              ),
                              DropdownButton(
                                value: model.numberOfDates,
                                onChanged: (value) {},
                                items: <int>[1, 2, 3]
                                    .map<DropdownMenuItem<int>>((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(
                                      value.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }).toList(),
                              ),
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
                              FlatButton(
                                child: Icon(FontAwesomeIcons.search),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
              model.logDecodedJsonData == null
                  ? Center(child: CircularProgressIndicator())
                  : JsonTable(
                      model.logDecodedJsonData,
                      showColumnToggle: false,
                      allowRowHighlight: true,
                      rowHighlightColor: Colors.yellow[500].withOpacity(0.7),
                      paginationRowCount: 15,
                      tableHeaderBuilder: (String header) {
                        if (header == "userName")
                          header = "이름";
                        else if (header == "buildingName")
                          header = "건물";
                        else if (header == "phoneNumber")
                          header = "번호";
                        else
                          header = "시간";
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 8.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.8,
                              ),
                              color: mainColor.withOpacity(0.5)),
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
                                  color: Colors.grey.withOpacity(0.3))),
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
