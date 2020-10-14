import 'package:checkin/frontend/viewModels/covid_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:url_launcher/url_launcher.dart';

final prevention = [
  {'assets/images/distance.png': '사회적\n거리두기'},
  {'assets/images/wash_hands.png': '손을 항상\n깨끗하게 씻기'},
  {'assets/images/mask.png': '마스크 \n항시 착용'},
];

class CovidView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ViewModelProvider<CovidViewModel>.withConsumer(
        viewModelBuilder: () => CovidViewModel(),
        builder: (context, model, child) => CustomScrollView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              slivers: [
                _buildHeader(model.currentUser.fullName, screenHeight),
                _buildEnd(
                    model.currentUser.fullName, screenHeight, screenWidth),
              ],
            ));
  }

  SliverToBoxAdapter _buildHeader(String userName, double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userName + " 님",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
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
                Text(
                  '계명대학교 편의 사이트입니다. ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildPreventionTips(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '예방 수칙',
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: prevention
                    .map((e) => Column(
                          children: [
                            Image.asset(e.keys.first,
                                height: screenHeight * 0.12),
                            SizedBox(
                              height: screenHeight * 0.015,
                            ),
                            Text(
                              e.values.first,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ))
                    .toList(),
              )
            ],
          )),
    );
  }

  SliverToBoxAdapter _buildYourOwnText(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: const EdgeInsets.all(10.0),
        height: screenHeight * 0.15,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFAD9FE4), Colors.blue],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/images/own_test.png'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '실천합시다!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '올바른 손씻기와 기침예절로 \n많은 감염병을 예방할 수 있습니다.',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  maxLines: 2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildEnd(
      String userName, double screenHeight, double screenWidth) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            //color: Color.fromRGBO(62, 65, 72, 0),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.black,
                    ),
                    Text(
                      '성서캠퍼스',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  '(우)42601 대구광역시 달서구 달구벌대로 1095',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 10.0,
                  ),
                ),
                Text(
                  '계명대학교 성서캠퍼스',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 10.0,
                  ),
                ),
                Text(
                  'TEL 053.580.5114',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 10.0,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.black,
                    ),
                    Text(
                      '대명캠퍼스',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  '(우)42403 대구광역시 남구 명덕로 104',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 10.0,
                  ),
                ),
                Text(
                  '계명대학교 대명캠퍼스',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 10.0,
                  ),
                ),
                Text(
                  'TEL 053.580.5114',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 10.0,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  children: [
                    _gridTile(
                        screenWidth,
                        screenHeight,
                        "https://www.kmu.ac.kr/uni/main/page.jsp?mnu_uid=3319",
                        Icons.location_city,
                        "캠퍼스맵"),
                    SizedBox(
                      width: screenWidth * 0.1,
                    ),
                    _gridTile(
                        screenWidth,
                        screenHeight,
                        "https://www.kmu.ac.kr/uni/main/page.jsp?mnu_uid=3322",
                        Icons.phone,
                        "교내주요연락처"),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  children: [
                    _gridTile(
                        screenWidth,
                        screenHeight,
                        "https://www.kmu.ac.kr/uni/main/page.jsp?mnu_uid=3324",
                        Icons.location_on,
                        "오시는 길"),
                    SizedBox(
                      width: screenWidth * 0.1,
                    ),
                    _gridTile(
                        screenWidth,
                        screenHeight,
                        "https://www.kmu.ac.kr/uni/main/page.jsp?mnu_uid=3323",
                        Icons.keyboard,
                        "주요사이트"),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _gridTile(double screenWidth, double screenHeight, String url,
    IconData icon, String title) {
  return Container(
    padding: const EdgeInsets.all(20.0),
    width: screenWidth * 0.4,
    height: screenHeight * 0.11,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        //color: Color.fromRGBO(62, 65, 72, 0),
        color: Colors.blueGrey),
    child: GestureDetector(
      onTap: () {
        print("baam");
        launch(url);
      },
      child: Center(
          child: Column(
        children: [
          Icon(icon),
          Text(title),
        ],
      )),
    ),
  );
}
