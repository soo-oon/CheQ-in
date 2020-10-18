import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final FocusNode fieldFocusNode;
  final FocusNode nextFocusNode;
  final TextInputAction textInputAction;
  final Function(String) onChanged;
  final Function enterPressed;
  final Size size;
  final double widthRatio;
  final double height;
  final String hintText;
  final bool password;
  final Color color;
  final Color hintTextColor;

  const InputWidget(
      {Key key,
      @required this.controller,
      @required this.size,
      @required this.hintText,
      this.textInputType,
      this.fieldFocusNode,
      this.nextFocusNode,
      this.textInputAction,
      this.onChanged,
      this.enterPressed,
      this.widthRatio = 0.9,
      this.height = 55,
      this.password = false,
      this.color = Colors.white,
      this.hintTextColor = Colors.black})
      : super(key: key);
  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool isPassword;
  @override
  void initState() {
    super.initState();
    isPassword = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(13.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ]),
      height: widget.height,
      width: widget.size.width * widget.widthRatio,
      padding: EdgeInsets.only(left: 8.0, bottom: 5.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: widget.controller,
                keyboardType: widget.textInputType,
                focusNode: widget.fieldFocusNode,
                obscureText: isPassword,
                textInputAction: widget.textInputAction,
                onChanged: widget.onChanged,
                onEditingComplete: () {
                  if (widget.enterPressed != null) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    widget.enterPressed();
                  }
                },
                onFieldSubmitted: (value) {
                  if (widget.nextFocusNode != null) {
                    widget.nextFocusNode.requestFocus();
                  }
                },
                decoration: InputDecoration.collapsed(
                    hintText: widget.hintText,
                    hintStyle:
                        TextStyle(fontSize: 13, color: widget.hintTextColor)),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                isPassword = !isPassword;
              }),
              child: widget.password
                  ? Container(
                      width: widget.height,
                      height: widget.height,
                      alignment: Alignment.center,
                      child: Icon(
                          isPassword ? Icons.visibility : Icons.visibility_off))
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
