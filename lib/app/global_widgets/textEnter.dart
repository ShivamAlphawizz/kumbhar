import 'package:flutter/material.dart';

class TextFieldShow extends StatelessWidget {
  final String text;
  final String fontFamily;
  final Color color;
  final FontWeight fontWeight;
  final double fontsize;
  final double height;
  final double letterSpacing;
  final int maxLines;
  final TextDecoration decoration;
  final TextAlign textAlign;

  TextFieldShow({
    this.text = "",
    this.fontFamily = "Lato",
    this.color = Colors.black87,
    this.fontsize = 15.0,
    this.height = 1,
    this.letterSpacing = 0.0,
    this.maxLines = 2,
    this.fontWeight = FontWeight.w500,
    this.textAlign = TextAlign.left,
    this.decoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        text,
          maxLines: maxLines == 0 ? null : maxLines,
          textAlign: textAlign,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: fontFamily,
            color: color,
            fontWeight: fontWeight,
            fontSize: fontsize,
            decoration: decoration,
            height: height,
            letterSpacing: letterSpacing),
      ),
    );
  }
}
