import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';

Widget appCircularProgress({
  double? width,
  double? height,
  double? strokeWidth,
}) =>
    SizedBox(
      width: width ?? 20,
      height: height ?? 20,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth ?? 2.0,
        backgroundColor: redColor1,
        color: borderColor,
      ),
    );
