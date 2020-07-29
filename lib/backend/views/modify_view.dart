import 'package:checkin/ui/shared/ui_helpers.dart';
import 'package:checkin/ui/widgets/busy_button.dart';
import 'package:checkin/ui/widgets/expansion_list.dart';
import 'package:checkin/ui/widgets/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:checkin/backend/viewModels/signup_view_model.dart';

class ModifyView extends StatelessWidget {
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
                  'Register',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                verticalSpaceSmall,
                InputField(
                    placeholder: 'Full Name',
                    controller: fullNameController,
                    fieldFocusNode: fullNameFocusNode,
                    nextFocusNode: phoneFocusNode),
                verticalSpaceSmall,
                InputField(
                    placeholder: 'Phone',
                    controller: phoneController,
                    textInputType: TextInputType.numberWithOptions(),
                    fieldFocusNode: phoneFocusNode,
                    nextFocusNode: addressFocusNode),
                verticalSpaceSmall,
                InputField(
                    placeholder: 'Address',
                    controller: addressController,
                    fieldFocusNode: addressFocusNode,
                    nextFocusNode: emailFocusNode),
                verticalSpaceSmall,
                InputField(
                  placeholder: 'Password',
                  password: true,
                  controller: passwordController,
                  fieldFocusNode: passwordFocusNode,
                  additionalNote:
                      'Password has to be a minimum of 6 characters.',
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
                      title: "Cancel",
                      busy: model.busy,
                      onPressed: () {
                        model.navigateToLoginPage();
                      },
                    ),
                    SizedBox(width: 10),
                    BusyButton(
                        title: 'Submit',
                        busy: model.busy,
                        onPressed: () {
                          model.currentUser.address = addressController.text;
                          model.currentUser.fullName = fullNameController.text;
                          model.currentUser.phoneNumber = phoneController.text;
                          model.updateUserdata(passwordController.text);
                          Navigator.of(context).pop(true);
                        })
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
