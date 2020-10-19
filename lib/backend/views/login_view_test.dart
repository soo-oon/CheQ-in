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
              body: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
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
                        _boxWidget("새로운 계정 만들기", size, Color(0xff3d6bfc), () {
                          model.navigateToSignUp();
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

Widget _boxWidget(String info, Size size, Color color, Function onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 50,
      width: size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            info,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),
  );
}

Widget _buildHeader(String userName, double screenHeight) {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Color(0xff3d6bfc),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.access_time,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              "CHEQ-IN",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.03,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_comment,
                    color: Color(0xff3d6bfc),
                    size: 10,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "sw@test.com",
                    style:
                        const TextStyle(color: Color(0xff3d6bfc), fontSize: 10),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              userName + " 님의 제안사항",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ],
    ),
  );
}

Widget _buildButtons(IconData iconData, String text) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 50,
            color: Colors.blue,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}
