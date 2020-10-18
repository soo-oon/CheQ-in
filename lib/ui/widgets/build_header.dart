import 'package:flutter/material.dart';

class BuildHeader extends StatefulWidget {
  final String userName;
  final Size size;

  const BuildHeader({Key key, this.userName, this.size}) : super(key: key);
  @override
  _BuildHeaderState createState() => _BuildHeaderState();
}

class _BuildHeaderState extends State<BuildHeader> {
  @override
  Widget build(BuildContext context) {
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
            height: widget.size.height * 0.03,
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
                      style: const TextStyle(
                          color: Color(0xff3d6bfc), fontSize: 10),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.userName + " 님 안녕하세요.",
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
}
