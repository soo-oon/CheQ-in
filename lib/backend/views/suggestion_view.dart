import 'package:checkin/backend/viewModels/suggestion_view_model.dart';
import 'package:checkin/ui/shared/app_colors.dart';
import 'package:checkin/ui/shared/ui_helpers.dart';
import 'package:checkin/ui/widgets/button_widget.dart';
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
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: <Widget>[
                    DataTable(
                      columnSpacing: 0.5,
                      headingRowHeight: 60,
                      dataRowHeight: 30.0,
                      columns: [
                        DataColumn(
                            label: Text(
                          "번호",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        )),
                        DataColumn(
                            label: Text(
                          "제목",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        )),
                        DataColumn(
                            label: Text(
                          "내용",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        )),
                      ],
                      rows: model.rows,
                    ),
                  ],
                ),
              ),
              CustomButton(
                title: "로그아웃",
                color: mainColor,
                textColor: Colors.white,
                onTap: () {
                  model.navigateToLogin();
                },
              ),
              verticalSpaceMedium
            ],
          ),
        ),
      ),
    );
  }
}
