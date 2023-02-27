import 'package:flutter/material.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:sizer/sizer.dart';

class TextFieldDesigned extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final Color? hintStyle;
  final String hintText;
  final String initialValue;
  final int maxLength, minLines;
  final int maxLines;
  final bool readOnly;
  final bool obscureText;
  final TextInputType keyboardType;
  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator<String>? validator;
  final GestureTapCallback? onTap;
  final TextAlign textAlign;
  final double fontSize;
  final FontWeight fontWeight;
  late final String? counterText;

  TextFieldDesigned({
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.controller,
    this.hintStyle = Colors.black,
    this.initialValue = "",
    this.suffixIcon,
    this.prefixIcon,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w300,
    this.autovalidateMode,
    this.hintText = "",
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength = 300,
    this.validator,
    this.keyboardType = TextInputType.number,
    this.textAlign = TextAlign.start,
    this.counterText = "",
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      cursorColor: Colors.black,
      textCapitalization: TextCapitalization.sentences,
      readOnly: readOnly,
      autovalidateMode: autovalidateMode,
      validator: validator,
      onTap: onTap,
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      textAlign: textAlign,
      buildCounter: counter,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontMedium,
        fontWeight: fontWeight,
        color: Color(0xff000000),
      ),
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: hintStyle,
          fontSize: 10.sp,
          fontFamily: fontRegular
        ),
        prefixIcon: prefixIcon,
        filled: true,
        counterText: counterText,
        hintText: hintText,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffC4C4C4)),
          //36325A
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffC4C4C4)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffC4C4C4)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffC4C4C4)),
          borderRadius: BorderRadius.circular(10),
        ),
       // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        fillColor: Colors.transparent,
      ),
    );
  }

  Widget counter(BuildContext context,
      {required int currentLength,
      required int? maxLength,
      required bool isFocused}) {
    if (isFocused && currentLength > 0) {
      return Text('$currentLength / $maxLength');
    } else {
      return Text("");
    }
  }
}
