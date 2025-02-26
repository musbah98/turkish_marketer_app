import 'package:flutter/material.dart';
import '../on_boarding_view_model.dart';

Widget indicatorView({required OnBoardingViewModel viewModel}) => Padding(
      padding: const EdgeInsets.all(22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buildIndicator(
          total: viewModel.data.length,
          currentIndx: viewModel.currentPageIndex,
        ),
      ),
    );

//Indicator Builder
List<Widget> buildIndicator({required int total, required int currentIndx}) {
  final indicators = <Widget>[];

  for (var i = 0; i < total; i++) {
    if (currentIndx == i) {
      indicators.add(indicatorsTrue(currentIndx));
    } else {
      indicators.add(indicatorsFalse());
    }
  }
  return indicators;
}

// Changes colors based on screen
Widget indicatorsTrue(int currentIndx) {
  //Active Indicator
  return AnimatedContainer(
    duration: const Duration(microseconds: 300),
    height: 8,
    width: 8,
    margin: const EdgeInsets.only(right: 8),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.white),
  );
}

//Inactive Indicator
Widget indicatorsFalse() {
  return AnimatedContainer(
    duration: const Duration(microseconds: 300),
    height: 8,
    width: 8,
    margin: const EdgeInsets.only(right: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Colors.white.withOpacity(0.56),
    ),
  );
}
