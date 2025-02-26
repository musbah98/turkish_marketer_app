import 'package:flutter/material.dart';
import 'package:turkish_marketer/extentions.dart';

import '../../../di.dart';
import '../../decoration_and_assets/dimentions.dart';
import '../../decoration_and_assets/images.dart';
import '../../routing/navigation_service.dart';
import '../custom_app_text.dart';

Widget appBackbutton({
  double? context,
}) =>
    InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.pop(
          sl<NavigationService>().getContext(),
        );
      },
      child: Row(
        children: [
          const SizedBox(width: 16),
          Transform.flip(
            flipX: isRTL() ? true : false,
            child: Image.asset(backArrow),
          ),
          const SizedBox(width: 6),
          customTextApp(
            text: "back".localized(),
            fontWeight: FontWeight.w600,
            size: 14,
          ),
        ],
      ),
    );
