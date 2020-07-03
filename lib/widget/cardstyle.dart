import 'package:checkin/widget/notificationlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const kDefaultShadow = BoxShadow(
  blurRadius: 27,
  offset: Offset(0, 15),
  color: Colors.black12,
);

class CardWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount:
          Provider.of<NotificationList>(context).getNotificationList().length,
      itemBuilder: (context, index) {
        if (Provider.of<NotificationList>(context)
            .getNotificationList()[index]
            .getIsDanger())
          return NoticeSampleWidget(
              context,
              "Alert",
              Provider.of<NotificationList>(context)
                  .getNotificationList()[index]
                  .getComment(),
              Colors.redAccent,
              index);
        else {
          return NoticeSampleWidget(
              context,
              "Notice",
              Provider.of<NotificationList>(context)
                  .getNotificationList()[index]
                  .getComment(),
              Colors.yellowAccent,
              index);
        }
      },
    );
  }
}

Widget NoticeSampleWidget(BuildContext context, String stateOfRisk,
    String comment, Color color, int index) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 10.0,
    ),
    //color: Colors.blueAccent,
    height: MediaQuery.of(context).size.height / 5,
    //width: MediaQuery.of(context).size.width,
    child: GestureDetector(
      child: InkWell(
        onTap: () {
          print(index);
          Provider.of<NotificationList>(context, listen: false)
              .removeAtList(index);
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 4 - 20,
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: color,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 5,
              child: SizedBox(
                height: 136,
                width: MediaQuery.of(context).size.width - 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(stateOfRisk),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(22),
                              bottomRight: Radius.circular(22))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        comment,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
