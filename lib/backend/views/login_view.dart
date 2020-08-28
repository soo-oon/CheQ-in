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
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 120),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/logo.jpg"),
                            fit: BoxFit.cover),
                      )),
                  const SizedBox(height: 40),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:25.0),
                    child: Row(
                      
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
                  ),
                  verticalSpaceMedium,
                ],
              ),
            ),
          )),
    );
  }
}
