import 'package:checkin/backend/viewModels/info_view_model.dart';
import 'package:checkin/backend/views/modify_view.dart';
import 'package:checkin/ui/shared/ui_helpers.dart';
import 'package:checkin/ui/widgets/email_widget.dart';
import 'package:checkin/ui/widgets/icon_button_widget.dart';
import 'package:checkin/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class OptionScreen extends StatefulWidget {
  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ViewModelProvider<InfoViewModel>.withConsumer(
        viewModelBuilder: () => InfoViewModel(),
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
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
                            CustomIconButton(
                              title: "학교 및 기관 설정",
                              icon: Icons.ac_unit,
                              color: Colors.white,
                            ),
                            verticalSpaceSmall,
                            CustomIconButton(
                              title: "프로필 및 개인정보 변경",
                              icon: Icons.ac_unit,
                              color: Colors.white,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileScreen()));
                              },
                            ),
                            verticalSpaceSmall,
                            CustomIconButton(
                              title: "앱 정보",
                              icon: Icons.ac_unit,
                              color: Colors.white,
                            ),
                            verticalSpaceSmall,
                            CustomIconButton(
                              title: "공지사항",
                              icon: Icons.ac_unit,
                              color: Colors.white,
                            ),
                            verticalSpaceSmall,
                            CustomIconButton(
                              title: "로그아웃",
                              icon: Icons.ac_unit,
                              color: Colors.white,
                              onTap: () {
                                model.signOut();
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
