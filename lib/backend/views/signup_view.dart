import 'package:checkin/backend/viewModels/signup_view_model.dart';
import 'package:checkin/ui/shared/ui_helpers.dart';
import 'package:checkin/ui/widgets/input_widget.dart';
import 'package:checkin/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

class EnterPageScreen extends StatefulWidget {
  @override
  _EnterPageScreenState createState() => _EnterPageScreenState();
}

class _EnterPageScreenState extends State<EnterPageScreen> {
  final fieldColor = Colors.white.withOpacity(0.2);
  final textColor = Color.fromRGBO(207, 218, 255, 1);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final phoneCodeController = TextEditingController();
  final addressController = TextEditingController();

  final fullNameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final password2FocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final phoneCodeFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ViewModelProvider<SignUpViewModel>.withConsumer(
        viewModelBuilder: () => SignUpViewModel(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Color(0xff3d6bfc),
              body: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(color: Color(0xff3d6bfc)),
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height / 20,
                      ),
                      Text(
                        "회원가입",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27.45,
                        ),
                      ),
                      SizedBox(
                        height: size.height / 20,
                      ),
                      InputWidget(
                        controller: fullNameController,
                        hintText: '이름',
                        fieldFocusNode: fullNameFocusNode,
                        nextFocusNode: phoneFocusNode,
                        color: fieldColor,
                        hintTextColor: textColor,
                      ),
                      verticalSpaceSmall,
                      InputWidget(
                        controller: phoneController,
                        hintText: '휴대폰 번호( - 빼고 입력해주세요)',
                        textInputType: TextInputType.number,
                        fieldFocusNode: phoneFocusNode,
                        nextFocusNode: addressFocusNode,
                        color: fieldColor,
                        hintTextColor: textColor,
                      ),
                      const SizedBox(height: 10),
                      InputWidget(
                        controller: addressController,
                        hintText: '주소',
                        fieldFocusNode: addressFocusNode,
                        nextFocusNode: emailFocusNode,
                        color: fieldColor,
                        hintTextColor: textColor,
                      ),
                      verticalSpaceSmall,
                      InputWidget(
                        controller: emailController,
                        hintText: '이메일',
                        fieldFocusNode: emailFocusNode,
                        nextFocusNode: passwordFocusNode,
                        color: fieldColor,
                        hintTextColor: textColor,
                      ),
                      verticalSpaceSmall,
                      InputWidget(
                        controller: password2Controller,
                        password: true,
                        hintText: '비밀번호',
                        fieldFocusNode: passwordFocusNode,
                        nextFocusNode: password2FocusNode,
                        color: fieldColor,
                        hintTextColor: textColor,
                      ),
                      verticalSpaceSmall,
                      InputWidget(
                        controller: password2Controller,
                        password: true,
                        hintText: '비밀번호 확인',
                        fieldFocusNode: password2FocusNode,
                        color: fieldColor,
                        hintTextColor: textColor,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 25.0, top: 10.0),
                            child: Text(
                              "비밀번호는 최소 6자리 이상입니다.",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceLarge,
                      CustomButton(
                        title: '회원가입',
                        textColor: Color(0xff3d6bfc),
                        onTap: () {
                          if (model.checkPhoneNumber(phoneController.text)) {
                            model.signUp(
                                email: emailController.text,
                                password: passwordController.text,
                                password2: password2Controller.text,
                                fullName: fullNameController.text,
                                phoneNumber: model.formattedPhoneNumber,
                                address: addressController.text);
                          } else {
                            model.showPhoneNumberWrongDialog();
                          }
                        },
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 25.0, top: 10.0),
                            child: Text(
                              "이미 회원이십니까?",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, top: 10.0),
                            child: InkWell(
                              onTap: () {
                                model.navigateToLogin();
                              },
                              child: Text(
                                "로그인하기",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

Widget _boxWidget(String info, Size size, Color color) {
  return Container(
    height: 50,
    width: size.width * 0.9,
    child: Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Icon(Icons.check),
        SizedBox(
          width: 20,
        ),
        Text(info)
      ],
    ),
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ]),
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
      ],
    ),
  );
}

Widget _greetingWidget() {
  return Column(
    children: [
      Text(
        "soon 님 안녕하세요.",
        style: const TextStyle(
            color: Color.fromRGBO(126, 126, 126, 1),
            fontSize: 15.0,
            fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromRGBO(239, 239, 245, 1)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_comment,
              color: Color.fromRGBO(126, 126, 126, 1),
              size: 10,
            ),
            const SizedBox(width: 5),
            Text(
              "sw@test.com",
              style: const TextStyle(
                  color: Color.fromRGBO(126, 126, 126, 1), fontSize: 10),
            )
          ],
        ),
      ),
    ],
  );
}
