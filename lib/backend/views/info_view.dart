import 'package:checkin/backend/viewModels/info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class InfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InfoViewModel>.withConsumer(
        viewModelBuilder: () => InfoViewModel(),
        builder: (context, model, child) => SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25),
                            child: ListTile(
                              leading: Icon(
                                LineAwesomeIcons.user,
                                color: Colors.blue[300],
                              ),
                              title: Text(
                                model.currentUser.fullName,
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25),
                            child: ListTile(
                              leading: Icon(
                                LineAwesomeIcons.envelope,
                                color: Colors.blue[300],
                              ),
                              title: Text(
                                model.currentUser.email,
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25),
                            child: ListTile(
                              leading: Icon(
                                LineAwesomeIcons.phone,
                                color: Colors.blue[300],
                              ),
                              title: Text(
                                model.currentUser.phoneNumber,
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25),
                            child: ListTile(
                              leading: Icon(
                                LineAwesomeIcons.map_marker,
                                color: Colors.blue[300],
                              ),
                              title: Text(
                                model.currentUser.address,
                              ),
                            ),
                          ),
                        ],
                      ),
                      RaisedButton(
                        child: Text("Modify account"),
                        onPressed: () {},
                      ),
                      TextField(
                        controller: model.titleController,
                        decoration: InputDecoration(
                          hintText: "푸시알람 제목"
                        ),
                      ),
                      TextField(
                        controller: model.bodyController,
                        decoration: InputDecoration(
                          hintText: "푸시알람 본문"
                        ),
                      ),
                      RaisedButton(
                        child: Text("send Push"),
                        onPressed: () {
                          model.sendPush(model.titleController.text, model.bodyController.text);
                          model.titleController.clear();
                          model.bodyController.clear();
                        },
                      ),
                      RaisedButton(
                        child: Text("Sign Out"),
                        onPressed: () {
                          model.signOut();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
