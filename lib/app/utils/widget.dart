
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'constant.dart';


Widget text(String text,
    {var fontSize = textSizeMedium,
      textColor = const Color(0xffffffff),
      var fontFamily = fontRegular,
      var isCentered = false,
      var isEnd = false,
      var maxLine = 2,
      var latterSpacing = 0.25,
      var textAllCaps = false,
      var isLongText = false,
      var overFlow = false,
      var decoration = false,
      var under = false,
      fontWeight}) {
  return Text(
    textAllCaps ? text.toUpperCase() : text,
    textAlign: isCentered
        ? TextAlign.center
        : isEnd
        ? TextAlign.end
        : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    softWrap: true,
    overflow: overFlow ? TextOverflow.ellipsis : TextOverflow.clip,
    style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: fontFamily,
        fontSize: double.parse(fontSize.toString()),
        color: textColor,
        height: 1.5,
        letterSpacing: latterSpacing,
        decoration: decoration
            ? TextDecoration.lineThrough
            : under
            ? TextDecoration.underline
            : TextDecoration.none),
  );
}

BoxDecoration boxDecoration(
    {double radius = spacing_middle,
    Color color = Colors.transparent,
    Color bgColor = Colors.white,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor,
    boxShadow: showShadow
        ? [
            BoxShadow(
                color:Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 1)
          ]
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

changeStatusBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: color, // navigation bar color
      statusBarColor: color,
      statusBarIconBrightness: Brightness.dark // status bar color
      ));
}

BoxDecoration boxDecoration2(
    {double radius = spacing_middle,
    Color color = Colors.transparent,
    Color bgColor = Colors.white,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor,
    boxShadow: showShadow
        ? [
            BoxShadow(
                color: Colors.grey, blurRadius: 6, spreadRadius: 2)
          ]
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius)),
  );
}

Widget commonImage(url, height, width, placeHolder, context, errorImage) {
  print("checking image url here ${url}");
  return CachedNetworkImage(
    imageUrl: url,
    height: height,
    width: width,
    fit: BoxFit.fill,
    placeholder: (context, url) {
      return Container(
        height: height,
        width: width,
        child: Center(
          child: loadingWidget(
            color: Colors.blue,
          ),
        ),
      );
    },
    errorWidget: (context, url, error) {
      return Image.asset(
        errorImage,
        fit: BoxFit.fill,
        height: height,
        width: width,
      );
    },
  );
}
Widget loadingWidget({color = Colors.blueAccent}){
  return LoadingAnimationWidget.halfTriangleDot(
    color: Colors.blueAccent,
    size: getWidth(100),
  );
}