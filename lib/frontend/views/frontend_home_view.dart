import 'package:checkin/frontend/viewModels/frontend_home_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class FrontEndHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<FrontEndHomeViewModel>.withConsumer(
      viewModelBuilder: () => FrontEndHomeViewModel(),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("FrontHomeView"),
                FlatButton(
                  child: Text("Sign Out"),
                  onPressed: () {
                    model.signOut();
                  },
                )
              ],
            ),
          )),
    );
  }
}