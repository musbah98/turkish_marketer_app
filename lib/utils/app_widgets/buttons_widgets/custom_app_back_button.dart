import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../decoration_and_assets/dimentions.dart';
import '../../decoration_and_assets/images.dart';
import '../../routing/navigation_service.dart';

Widget customAppBackbutton({
  double? context,
}) =>
    IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        Navigator.pop(sl<NavigationService>().getContext());
      },
      icon: Transform.flip(
        flipX: isRTL() ? true : false,
        child: Image.asset(backButton),
      ),
    );
