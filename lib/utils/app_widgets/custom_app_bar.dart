import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';
import 'package:turkish_marketer/utils/routing/routes.dart';

import '../../di.dart';
import '../decoration_and_assets/images.dart';
import '../routing/navigation_service.dart';
import 'custom_app_text.dart';

Widget customAppBar({
  Widget? leading,
  String? title,
  Color titleColor = titleColor2,
  double titleSize = 24,
  FontWeight fontWeight = FontWeight.bold,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: leading ??
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              sl<NavigationService>().navigateTo(profileScreen);
            },
            icon: Image.asset(profileIcon),
          ),
      title: Center(
        child: customTextApp(
          text: title ?? "",
          fontWeight: fontWeight,
          size: titleSize,
          color: titleColor,
        ),
      ),
      backgroundColor: Colors.transparent,
      actions: actions ??
          [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                sl<NavigationService>().navigateTo(searchScreen);
              },
              icon: Image.asset(searchIcon),
            )
          ],
    );
