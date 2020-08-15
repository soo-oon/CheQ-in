import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;
  List catagories = ['All', 'Engineering', 'Medical', 'Center', 'Sport'];
  Color tabColor;

  List selectedIndexs = [true, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 30,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: catagories.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    selectedIndexs[index] = !selectedIndexs[index];
                    if (selectedIndexs[index])
                      tabColor = Colors.blueAccent.withOpacity(0.4);
                    else {
                      tabColor = Colors.transparent;
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: 15, right: index == catagories.length - 1 ? 15 : 0),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(color: tabColor),
                  child: Text(catagories[index]),
                ),
              )),
    );
  }
}
