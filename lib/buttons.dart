import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({this.color, required this.text, this.textColor, this.onPressed});

  final color;
  final textColor;
  final String text;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: Container(
            color: color,
            child: Center(
                child: Text(
              text,
              style: TextStyle(color: textColor),
            )),
          ),
        ),
      ),
    );
  }
}
