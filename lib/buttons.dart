import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  MyButton({this.color, this.textColor, this.buttonText, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      onPressed: buttonTapped,
      color: color,
      child: Container(
          child: Text(
            buttonText,
            style: TextStyle(
                color: textColor, fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
    );
  }
}
