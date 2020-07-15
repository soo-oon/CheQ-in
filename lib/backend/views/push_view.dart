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
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Push Notification",
                  style: TextStyle(fontSize: 30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text("Building"),
                      onPressed: () {},
                    ),
                    FlatButton(
                      child: Text("Status"),
                      onPressed: () {},
                    ),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black))),
                  maxLines: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text("Clear"),
                      onPressed: () {},
                    ),
                    FlatButton(
                      child: Text("Send"),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ))));
  }
}
