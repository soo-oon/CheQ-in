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
        builder: (context, model, child) => Center(
                child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Text(
                  "푸시 알림",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 40,
                ),
                Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                    child: TextField(
                      controller: model.titleController,
                      decoration: InputDecoration(hintText: "푸시알림 제목"),
                    )),
                Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                    child: TextField(
                      controller: model.bodyController,
                      decoration: InputDecoration(hintText: "푸시알림 내용"),
                    )),
                RaisedButton(
                  child: Text("보내기"),
                  onPressed: () {
                    model.sendPush(
                        model.titleController.text, model.bodyController.text);
                    model.titleController.clear();
                    model.bodyController.clear();
                  },
                ),
              ]),
            )));
  }
}
