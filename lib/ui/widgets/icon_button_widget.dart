import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Size size;
  final Color color;
  final Function onTap;

  const CustomIconButton(
      {Key key, this.title, this.icon, this.size, this.color, this.onTap})
      : super(key: key);
  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 50,
        width: widget.size.width * 0.9,
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Icon(widget.icon),
            SizedBox(
              width: 20,
            ),
            Text(widget.title)
          ],
        ),
        decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 3),
              )
            ]),
      ),
    );
  }
}
