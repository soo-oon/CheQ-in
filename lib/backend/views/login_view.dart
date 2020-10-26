import 'package:checkin/backend/viewModels/login_view_model.dart';
import 'package:checkin/ui/shared/ui_helpers.dart';
import 'package:checkin/ui/widgets/button_widget.dart';
import 'package:checkin/ui/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ViewModelProvider<LoginViewModel>.withConsumer(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    width: double.infinity,
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 30.0),
                              width: 150,
                              height: 180,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/logo.jpg"),
                                    fit: BoxFit.cover),
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          //_buildHeader("Soon", size.height),
                          InputWidget(
                              controller: emailController, hintText: '아이디'),
                          verticalSpaceSmall,
                          InputWidget(
                            controller: passwordController,
                            hintText: '비밀번호',
                            password: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value;
                                  });
                                },
                                value: isChecked,
                              ),
                              Text(
                                "로그인 상태를 유지시키시겠습니까?",
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            title: "로그인",
                            color: Color(0xff3d6bfc),
                            textColor: Colors.white,
                            onTap: () {
                              model.login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "아이디 혹은 비밀번호를 잊으셨나요?",
                            style: TextStyle(fontSize: 10),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              height: 1.0,
                              width: size.width * 0.9,
                              color: Colors.black26,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            title: "새로운 계정 만들기",
                            color: Color(0xff3d6bfc),
                            textColor: Colors.white,
                            onTap: () {
                              model.navigateToSignUp();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
