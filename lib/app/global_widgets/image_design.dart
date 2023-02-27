import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/image_helper.dart';

// Note : photo video app bar worked diffrently
ClipRRect ImageDesign(double height, double width, String img_url,
        double borderRadius, String default_img) =>
    ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: (identical(img_url, 'show_more'))
            ? Image(
                fit: BoxFit.cover,
                height: height,
                width: width,
                color: Colors.amber,
                image: NetworkImage(img_url),
              )
            : Image(
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    default_img,
                    fit: BoxFit.cover,
                    height: height,
                    width: width,
                  );
                },
                fit: BoxFit.cover,
                height: height,
                width: width,
                image: NetworkImage(img_url),
              ));
