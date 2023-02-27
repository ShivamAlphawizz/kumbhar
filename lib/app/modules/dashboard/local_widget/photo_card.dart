import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:indianmilan/app/global_widgets/image_design.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/utils/image_helper.dart';


class PhotoCard extends StatelessWidget {
  final double height;
  final double width;
  final String name;
  final String img;

  PhotoCard(
      {required this.height,
      required this.width,
      required this.name,
      required this.img});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Stack(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ImageDesign(
              height,
              width,
              img,
              10,
              "",
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 7.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(Side_Menu, width: 80),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: TextFieldShow(
                      textAlign: TextAlign.center,
                      text: name,
                      color: Colors.white70,
                      fontsize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(Side_Menu, width: 18, height: 18),
        )
      ],
    ));
  }
}
