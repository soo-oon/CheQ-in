import 'package:checkin/backend/viewModels/signup_view_model.dart';
import 'package:checkin/ui/shared/ui_helpers.dart';
import 'package:checkin/ui/widgets/email_widget.dart';
import 'package:checkin/ui/widgets/input_widget.dart';
import 'package:checkin/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  final fullNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ViewModelProvider<SignUpViewModel>.withConsumer(
        viewModelBuilder: () => SignUpViewModel(),
        onModelReady: (model) {
          emailController.text = model.currentUser.email;
          fullNameController.text = model.currentUser.fullName;
          phoneController.text = model.currentUser.phoneNumber;
          addressController.text = model.currentUser.address;
        },
        builder: (context, model, child) => Scaffold(
              body: SingleChildScrollView(
                child: model.busy
                    ? CircularProgressIndicator()
                    : Container(
                        decoration: BoxDecoration(color: Colors.white),
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                _buildHeader("Soon", size.height),
                                SizedBox(
                                  height: 170,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    margin: EdgeInsets.symmetric(horizontal: 0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/CheQ.png"),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 5,
                                            blurRadius: 5,
                                            offset: Offset(0, 5),
                                          )
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                            verticalSpaceMedium,
                            _greetingWidget(model.currentUser.fullName,
                                model.currentUser.email),
                            verticalSpaceMedium,
                            SizedBox(
                              height: size.height / 20,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => new AlertDialog(
                                    title: new Text(
                                      'email은 변경할 수 없습니다.',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    actions: [
                                      new FlatButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: new Text('아니요'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: InputWidget(
                                hintText: model.currentUser.email,
                                controller: emailController,
                                fieldFocusNode: emailFocusNode,
                                nextFocusNode: addressFocusNode,
                                changed: true,
                                isReadOnly: true,
                              ),
                            ),
                            verticalSpaceSmall,
                            InputWidget(
                              hintText: model.currentUser.fullName,
                              controller: fullNameController,
                              fieldFocusNode: fullNameFocusNode,
                              nextFocusNode: phoneFocusNode,
                              changed: true,
                            ),
                            verticalSpaceSmall,
                            InputWidget(
                              hintText: model.currentUser.phoneNumber,
                              controller: phoneController,
                              fieldFocusNode: phoneFocusNode,
                              nextFocusNode: addressFocusNode,
                              changed: true,
                            ),
                            verticalSpaceSmall,
                            InputWidget(
                              hintText: model.currentUser.address,
                              controller: addressController,
                              fieldFocusNode: addressFocusNode,
                              changed: true,
                            ),
                            verticalSpaceTiny,
                            Text("체크표시 클릭후 수정가능합니다."),
                            const SizedBox(height: 50),
                            CustomButton(
                              title: "수정하기",
                              color: Color.fromRGBO(239, 239, 245, 1),
                              textColor: Colors.black,
                              onTap: () {
                                if (addressController.text.isNotEmpty)
                                  model.currentUser.address =
                                      addressController.text;
                                if (fullNameController.text.isNotEmpty)
                                  model.currentUser.fullName =
                                      fullNameController.text;
                                if (phoneController.text.isNotEmpty)
                                  model.currentUser.phoneNumber =
                                      phoneController.text;
                                Navigator.pop(context);
                              },
                            ),
                            verticalSpaceSmall,
                            CustomButton(
                              title: "돌아가기",
                              color: Color.fromRGBO(239, 239, 245, 1),
                              textColor: Colors.black,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
              ),
            ));
  }
}

Widget _buildHeader(String userName, double screenHeight) {
  return Container(
    padding: const EdgeInsets.all(15.0),
    decoration: BoxDecoration(
        color: Color(0xff3d6bfc),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(192, 198, 232, 1),
            spreadRadius: 4,
            blurRadius: 4,
            offset: Offset(0, 5),
          )
        ]),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/images/CheQ.png"),
                ),
              ),
            ),
            horizontalSpaceSmall,
            Padding(
              padding: EdgeInsets.only(bottom: 3.0),
              child: Text(
                "CHEQ-IN",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.06,
        ),
      ],
    ),
  );
}

Widget _greetingWidget(String name, String email) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
                color: Color.fromRGBO(126, 126, 126, 1),
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            " 님 안녕하세요.",
            style: const TextStyle(
                color: Color.fromRGBO(126, 126, 126, 1),
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      const SizedBox(height: 10),
      EmailTag(
        email: email,
        backgroundColor: Color.fromRGBO(239, 239, 245, 1),
        textColor: Color.fromRGBO(126, 126, 126, 1),
      )
    ],
  );
}
