import 'package:checkin/frontend/viewModels/covid_home_view_model.dart';
import 'package:checkin/ui/shared/app_colors.dart';
import 'package:checkin/ui/shared/ui_helpers.dart';
import 'package:checkin/ui/widgets/email_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:url_launcher/url_launcher.dart';

List<Widget> gridItems = [
  _buildButtons(Icons.location_city, "캠퍼스 맵",
      "https://www.kmu.ac.kr/uni/main/page.jsp?mnu_uid=3319"),
  _buildButtons(Icons.phone, "교내주요 연락처",
      "https://www.kmu.ac.kr/uni/main/page.jsp?mnu_uid=3322"),
  _buildButtons(Icons.location_on, "캠퍼스 맵",
      "https://www.kmu.ac.kr/uni/main/page.jsp?mnu_uid=3324"),
  _buildButtons(Icons.keyboard, "주요사이트",
      "https://www.kmu.ac.kr/uni/main/page.jsp?mnu_uid=3323"),
];

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ViewModelProvider<CovidViewModel>.withConsumer(
        viewModelBuilder: () => CovidViewModel(),
        builder: (context, model, child) => Scaffold(
              body: SingleChildScrollView(
                //width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildHeader(model.currentUser.fullName,
                        model.currentUser.email, size.height),
                    GridView.count(
                      padding: const EdgeInsets.all(35),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: gridItems,
                    ),
                    /*Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            launch("tel:1339");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 15),
                            decoration: BoxDecoration(
                              color: Color(0xff3d6bfc),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "보건소 및 콜센터 전화 1339",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )*/
                  ],
                ),
              ),
            ));
  }
}

Widget _buildHeader(String userName, String email, double screenHeight) {
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
          height: screenHeight * 0.03,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EmailTag(
              email: email,
              textColor: mainColor,
            ),
            const SizedBox(height: 10),
            Text(
              userName + " 님 안녕하세요.",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '감염이 의심되면 즉시 가까운 선별 진료소, 보건소 및 콜센터로 전화하거나 문자 메시지를 보내 도움을 요청하십시오.',
              softWrap: true,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ],
    ),
  );
}

Widget _buildButtons(IconData iconData, String text, String url) {
  return GestureDetector(
    onTap: () {
      launch(url);
    },
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
            color: mainColor,
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
