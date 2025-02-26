import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/routing/navigation_service.dart';

import '../../di.dart';

const double minBottomPadding = 10.0;

double getScreenHeightMinusAppBarMinusStatusBar(BuildContext context) {
  return MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top;
}

bool isRTL() {
  BuildContext context = sl<NavigationService>().getContext();
  return Directionality.of(context) == TextDirection.rtl;
}
