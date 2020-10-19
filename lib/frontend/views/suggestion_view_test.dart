import 'package:checkin/frontend/viewModels/suggestion_view_model.dart';
import 'package:checkin/models/models.dart';
import 'package:checkin/ui/shared/app_colors.dart';
import 'package:checkin/ui/shared/ui_helpers.dart';
import 'package:checkin/ui/widgets/button_widget.dart';
import 'package:checkin/ui/widgets/email_widget.dart';
import 'package:checkin/ui/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class InquiryScreen extends StatefulWidget {
  @override
  _InquiryScreenState createState() => _InquiryScreenState();
}

class _InquiryScreenState extends State<InquiryScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final TextEditingController _textController = TextEditingController();
    final TextEditingController _titleController = TextEditingController();

    return ViewModelProvider<SuggestionViewModel>.withConsumer(
        viewModelBuilder: () => SuggestionViewModel(),
        disposeViewModel: false,
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildHeader(model.currentUser.fullName,
                          model.currentUser.email, size.height),
                      verticalSpaceLarge,
                      InputWidget(
                        controller: _textController,
                        hintText: '제목을 입력하시오.',
                        hintTextColor: Color.fromRGBO(152, 152, 152, 1),
                      ),
                      verticalSpaceSmall,
                      InputWidget(
                          controller: _titleController,
                          hintText: '내용을 입력하시오.',
                          maxLine: 7,
                          height: 200,
                          hintTextColor: Color.fromRGBO(152, 152, 152, 1)),
                      verticalSpaceMedium,
                      CustomButton(
                        title: "보내기",
                        color: mainColor,
                        textColor: Colors.white,
                        onTap: () {
                          model.addSuggestion(Suggestion(
                              content: _textController.text,
                              title: _titleController.text));
                          _textController.clear();
                          _titleController.clear();
                        },
                      )
                    ],
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
        children: [
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            info,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 5,
              blurRadius: 3,
              offset: Offset(0, 3),
            )
          ]),
    ),
  );
}

Widget _buildHeader(String userName, String email, double screenHeight) {
  return Container(
    padding: const EdgeInsets.all(20.0),
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
            Text(
              "문의하기",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.03,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
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
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        userName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      " 님의 제안사항",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                EmailTag(
                  email: email,
                  textColor: mainColor,
                )
              ],
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
