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
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  final fullNameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final addressFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpViewModel>.withConsumer(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.lightBlue.shade100,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Text(
                  '회원가입',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                verticalSpaceMedium,
                InputField(
                    placeholder: '이름',
                    controller: fullNameController,
                    fieldFocusNode: fullNameFocusNode,
                    nextFocusNode: phoneFocusNode),
                verticalSpaceSmall,
                InputField(
                    placeholder: '휴대폰 번호',
                    controller: phoneController,
                    textInputType: TextInputType.numberWithOptions(),
                    fieldFocusNode: phoneFocusNode,
                    nextFocusNode: addressFocusNode),
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
                  additionalNote:
                      '비밀번호는 최소 6자리 이상입니다.',
                ),
                verticalSpaceSmall,
                /* No need for role right now
                ExpansionList<String>(
                    items: ['Admin', 'User'],
                    title: model.selectedRole,
                    onItemSelected: model.setSelectedRole),
                verticalSpaceMedium,*/
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                            fullName: fullNameController.text,
                            phoneNumber: phoneController.text,
                            address: addressController.text);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
