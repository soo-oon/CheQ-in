import 'package:checkin/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class BuildingTile extends StatefulWidget {
  final String buildingName;
  final String englishName;
  final String date;
  final Color color;
  final Function onTap;

  const BuildingTile(
      {Key key,
      this.buildingName,
      this.englishName,
      this.date,
      this.color,
      this.onTap})
      : super(key: key);
  @override
  _BuildingTileState createState() => _BuildingTileState();
}

class _BuildingTileState extends State<BuildingTile> {
  bool isSelected = false;
  List<BoxShadow> shadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.15),
      spreadRadius: 5,
      blurRadius: 5,
      offset: Offset(0, 3),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
        isSelected = !isSelected;
      },
      onTapCancel: () {
        isSelected = false;
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: widget.color,
            boxShadow: isSelected ? shadow : null),
        child: Center(
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.ac_unit),
                      horizontalSpaceSmall,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.buildingName,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.englishName,
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.date,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.englishName,
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
