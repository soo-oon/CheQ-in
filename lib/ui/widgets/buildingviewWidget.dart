import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildingViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BuildingViewWidgetState();
}

class BuildingViewWidgetState extends State<BuildingViewWidget> {
  String building = "Engineering";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Text(
            building,
            style: TextStyle(fontSize: 30),
          ),
          DropdownButton<String>(
            value: building,
            onChanged: (String newValue) {
              setState(() {
                building = newValue;
              });
            },
            items: <String>["Engineering", "Sport", "Medical", "Center"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
