import 'package:checkin/ui/shared/app_colors.dart';
import 'package:checkin/ui/shared/ui_helpers.dart';
import 'package:checkin/ui/widgets/button_widget.dart';
import 'package:checkin/ui/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:checkin/backend/viewModels/push_view_model.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

class PushView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<PushViewModel>.withConsumer(
        viewModelBuilder: () => PushViewModel(),
        disposeViewModel: false,
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => SafeArea(
                child: SingleChildScrollView(
              child: Column(children: <Widget>[
                verticalSpaceLarge,
                InputWidget(
                    controller: model.titleController,
                    hintText: "푸시알림 제목",
                    hintTextColor: Color.fromRGBO(152, 152, 152, 1)),
                verticalSpaceSmall,
                InputWidget(
                    controller: model.bodyController,
                    hintText: "푸시알림 내용",
                    maxLine: 7,
                    height: 200,
                    hintTextColor: Color.fromRGBO(152, 152, 152, 1)),
                verticalSpaceLarge,
                CustomButton(
                  title: "보내기",
                  color: mainColor,
                  textColor: Colors.white,
                  onTap: () {
                    model.sendPush(
                        model.titleController.text, model.bodyController.text);
                    model.titleController.clear();
                    model.bodyController.clear();
                  },
                )
              ]),
            )));
  }
}
