import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final Size size;
  final Color color;
  final Color textColor;
  final Function onTap;

  const CustomButton(
      {Key key,
      @required this.title,
      @required this.size,
      this.color = Colors.white,
      this.onTap,
      this.textColor = Colors.black})
      : super(key: key);
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 50,
        width: widget.size.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: TextStyle(color: widget.textColor),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}
