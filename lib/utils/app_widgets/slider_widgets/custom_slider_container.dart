import 'package:flutter/material.dart';
import '../../decoration_and_assets/colors.dart';

Widget customSliderContainer({
  //required BuildContext context,
  bool isCornerRadius = false,
  double horizontalMargin = 0.0,
  double spaceBetween = 8.0,
  required int itemCount,
  required Widget? Function(BuildContext, int) itemBuilder,
}) =>
    Container(
      //constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
      height: 48,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(isCornerRadius ? 8 : 0),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        scrollDirection: Axis.horizontal,
        primary: false,
        shrinkWrap: false,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        separatorBuilder: (context, index) {
          return SizedBox(width: spaceBetween);
        },
      ),
    );
