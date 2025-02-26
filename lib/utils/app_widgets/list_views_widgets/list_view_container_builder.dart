import 'package:flutter/material.dart';

Widget listViewContainerBuilder({
  required BuildContext context,
  double verticalPadding = 0,
  double horizontalPadding = 0,
  int? minHeight,
  required int? itemCount,
  Color? bgColor,
  Color? borderColor,
  double borderRadius = 0,
  required Widget? Function(BuildContext, int) itemBuilder,
}) =>
    Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor ?? Colors.white),
        borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
      ),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - (minHeight ?? 0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          itemCount: itemCount,
          itemBuilder: itemBuilder,
        ),
      ),
    );
