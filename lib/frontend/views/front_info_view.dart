import 'package:checkin/backend/viewModels/info_view_model.dart';
import 'package:checkin/backend/views/modify_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider_architecture/provider_architecture.dart';

class FrontInfoView extends StatelessWidget {
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
                          buildheader(model.currentUser.fullName, context),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            child: Text("계정정보 수정하기"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ModifyView()),
                              );
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
                      SizedBox(
                        width: 300,
                        height: 100,
                        child: Image.asset('assets/images/logo.jpg'),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

Widget buildheader(String userName, BuildContext context) {
  return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              userName + " 님",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Text(
          "프로필",
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ]));
}
