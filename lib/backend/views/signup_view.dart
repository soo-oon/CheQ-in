import 'package:checkin/ui/shared/ui_helpers.dart';
import 'package:checkin/ui/widgets/busy_button.dart';
import 'package:checkin/ui/widgets/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:checkin/backend/viewModels/signup_view_model.dart';

class SignUpView extends StatelessWidget {
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
  final addressFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpViewModel>.withConsumer(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "회원가입",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                verticalSpaceMedium,
                InputField(
                    placeholder: '이름',
                    controller: fullNameController,
                    fieldFocusNode: fullNameFocusNode,
                    nextFocusNode: phoneFocusNode),
                verticalSpaceSmall,
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 3,
                        child: InputField(
                            placeholder: '휴대폰 번호',
                            controller: phoneController,
                            textInputType: TextInputType.numberWithOptions(),
                            fieldFocusNode: phoneFocusNode,
                            nextFocusNode: addressFocusNode),
                      ),
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                            child: BusyButton(
                              title: "인증",
                              busy: model.busy,
                              onPressed: () {
                                //model.sendOTP(phoneNumber: phoneController.text);
                                model.verifyPhoneNumber(context, phoneCodeController, phoneController.text);
                              },
                            ),
                          )),
                    ]),
                verticalSpaceSmall,
                InputField(
                    placeholder: '주소',
                    controller: addressController,
                    fieldFocusNode: addressFocusNode,
                    nextFocusNode: emailFocusNode),
                verticalSpaceSmall,
                InputField(
                    placeholder: '이메일',
                    controller: emailController,
                    fieldFocusNode: emailFocusNode,
                    nextFocusNode: passwordFocusNode),
                verticalSpaceSmall,
                InputField(
                  placeholder: '비밀번호',
                  password: true,
                  controller: passwordController,
                  fieldFocusNode: passwordFocusNode,
                  nextFocusNode: password2FocusNode,
                  additionalNote: '비밀번호는 최소 6자리 이상입니다.',
                ),
                InputField(
                  placeholder: '비밀번호 확인',
                  password: true,
                  controller: password2Controller,
                  fieldFocusNode: password2FocusNode,
                ),
                verticalSpaceSmall,
                /* No need for role right now
                  ExpansionList<String>(
                      items: ['Admin', 'User'],
                      title: model.selectedRole,
                      onItemSelected: model.setSelectedRole),
                  verticalSpaceMedium,*/
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        child: Text("이미 회원이신가요?"),
                        onPressed: () {
                          model.navigateToLogin();
                        },
                      ),
                      BusyButton(
                        title: "취소",
                        busy: model.busy,
                        onPressed: () {
                          model.navigateToLoginPage();
                        },
                      ),
                      SizedBox(width: 10),
                      BusyButton(
                          title: '회원가입',
                          busy: model.busy,
                          onPressed: () {
                            model.signUp(
                                email: emailController.text,
                                password: passwordController.text,
                                password2: password2Controller.text,
                                fullName: fullNameController.text,
                                phoneNumber: phoneController.text,
                                address: addressController.text);
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
