import 'package:flutter/material.dart';

class EmailTag extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;
  final String email;

  const EmailTag(
      {Key key,
      this.backgroundColor = Colors.white,
      this.textColor,
      @required this.email})
      : super(key: key);

  @override
  _EmailTagState createState() => _EmailTagState();
}

class _EmailTagState extends State<EmailTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: widget.backgroundColor),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_comment,
              color: widget.textColor,
              size: 10,
            ),
            const SizedBox(width: 5),
            Text(
              widget.email,
              style: TextStyle(color: widget.textColor, fontSize: 10),
            )
          ],
        ));
  }
}
