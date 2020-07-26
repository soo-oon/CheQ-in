import 'package:checkin/backend/viewModels/info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider_architecture/provider_architecture.dart';

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
                        children: <Widget>[
                          Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25),
                            child: ListTile(
                              leading: FaIcon(
                                FontAwesomeIcons.user,
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
                              leading: FaIcon(
                                FontAwesomeIcons.envelope,
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
                              leading: FaIcon(
                                FontAwesomeIcons.phone,
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
                              leading: FaIcon(
                                FontAwesomeIcons.mapMarker,
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
                        child: Text("계정정보 수정하기"),
                        onPressed: () {},
                      ),
                      Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25),
                          child: TextField(
                            controller: model.titleController,
                            decoration: InputDecoration(hintText: "푸시알림 제목"),
                          )),
                      Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25),
                          child: TextField(
                            controller: model.bodyController,
                            decoration: InputDecoration(hintText: "푸시알림 내용"),
                          )),
                      RaisedButton(
                        child: Text("send Push"),
                        onPressed: () {
                          model.sendPush(model.titleController.text,
                              model.bodyController.text);
                          model.titleController.clear();
                          model.bodyController.clear();
                        },
                      ),
                      RaisedButton(
                        child: Text("로그아웃"),
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
