import 'package:checkin/backend/viewModels/info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class InfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InfoViewModel>.withConsumer(
      viewModelBuilder: () => InfoViewModel(),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("BackHomeView"),
                RaisedButton(
                  child: Text("Sign Out"),
                  onPressed: () {
                    model.signOut();
                  },
                )
              ],
            ),
          )
      ),
    );
  }
}