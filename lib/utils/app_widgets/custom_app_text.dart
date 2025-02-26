import 'package:flutter/material.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';

Widget customTextApp({
  required String text,
  Color color = textColor,
  //String fontFamily = 'Poppins',
  double size = 16.0,
  int? maxLine = 1,
  FontWeight fontWeight = FontWeight.normal,
  TextAlign? align = TextAlign.start,
  overflow = TextOverflow.ellipsis,
}) =>
    Text(
      text,
      textDirection: text.textDirection,
      maxLines: maxLine,
      overflow: TextOverflow.clip,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        overflow: overflow,
      ),
    );
