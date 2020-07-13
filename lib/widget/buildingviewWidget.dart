import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildingViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BuildingViewWidgetState();
}

class BuildingViewWidgetState extends State<BuildingViewWidget> {
  String building = "Building1";
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
            items: <String>["Building1", "Building2", "Building3", "Building4"]
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
