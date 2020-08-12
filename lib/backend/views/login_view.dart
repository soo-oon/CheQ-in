import 'package:checkin/ui/shared/ui_helpers.dart';
import 'package:checkin/ui/widgets/busy_button.dart';
import 'package:checkin/ui/widgets/input_field.dart';
import 'package:checkin/ui/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:checkin/backend/viewModels/login_view_model.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>.withConsumer(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.lightBlue.shade100,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InputField(
                  placeholder: '이메일',
                  controller: emailController,
                ),
                verticalSpaceSmall,
                InputField(
                  placeholder: '비밀번호',
                  password: true,
                  controller: passwordController,
                ),
                verticalSpaceMedium,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextLink(
                      '회원가입',
                      onPressed: () {
                        model.navigateToSignUp();
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    BusyButton(
                      title: '로그인',
                      busy: model.busy,
                      onPressed: () {
                        model.login(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      },
                    ),
                  ],
                ),
                verticalSpaceMedium,
              ],
            ),
          )),
    );
  }
}
