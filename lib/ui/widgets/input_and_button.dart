import 'package:flutter/material.dart';

import 'input_widget.dart';

class InputFieldWithButton extends StatefulWidget {
  final Size size;
  final String hintText;
  final String buttonText;
  final Function onTap;
  final TextEditingController controller;
  final FocusNode fieldFocusNode;
  final FocusNode nextFocusNode;

  const InputFieldWithButton(
      {Key key,
      @required this.size,
      @required this.hintText,
      @required this.buttonText,
      @required this.onTap,
      @required this.controller,
      this.fieldFocusNode,
      this.nextFocusNode})
      : super(key: key);
  @override
  _InputFieldWithButtonState createState() => _InputFieldWithButtonState();
}

class _InputFieldWithButtonState extends State<InputFieldWithButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InputWidget(
            controller: widget.controller,
            size: widget.size,
            widthRatio: 0.7 * 0.9,
            hintText: '이름',
            fieldFocusNode: widget.fieldFocusNode,
            nextFocusNode: widget.nextFocusNode),
        SizedBox(
          width: widget.size.width * 0.9 * 0.02,
        ),
        InkWell(
          onTap: widget.onTap,
          child: Container(
              alignment: Alignment.topLeft,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              width: widget.size.width * 0.9 * 0.28,
              child: Center(
                child: Text("인증"),
              )),
        ),
      ],
    );
  }
}
