import 'package:checkin/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Function onTap;

  const CustomIconButton(
      {Key key, this.title, this.icon, this.color, this.onTap})
      : super(key: key);
  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 50,
        width: size.width * 0.9,
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Icon(
              widget.icon,
              size: 20,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              widget.title,
              style: TextStyle(fontSize: 11),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(245, 244, 249, 1),
                spreadRadius: 5,
                blurRadius: 3,
                offset: Offset(0, 3),
              )
            ]),
      ),
    );
  }
}
