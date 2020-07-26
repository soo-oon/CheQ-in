import 'package:checkin/backend/viewModels/info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class InfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InfoViewModel>.withConsumer(
        viewModelBuilder: () => InfoViewModel(),
        builder: (context, model, child) => SafeArea(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        ListTile(
                          title: Text("이름"),
                          trailing: Text(model.currentUser.fullName),
                        ),
                        ListTile(
                          title: Text("e-mail"),
                          trailing: Text(model.currentUser.email),
                        ),
                        ListTile(
                          title: Text("직책"),
                          trailing: Text(model.currentUser.userRole),
                        ),
                      ],
                    ),
                    RaisedButton(
                      child: Text("계정정보 수정하기"),
                      onPressed: () {},
                    ),
                    RaisedButton(
                      child: Text("send Push"),
                      onPressed: () {
                        model.sendPush("", "");
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
            ));
  }
}
