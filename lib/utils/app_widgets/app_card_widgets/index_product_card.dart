import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';
import 'package:turkish_marketer/utils/common_widgets/shimmer_loading.dart';

import '../../decoration_and_assets/colors.dart';
import '../icon_tag_view.dart';

indexProductCard({
  bool isLoading = false,
  required String title,
  String? total,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: bgColor,
          border: const BorderDirectional(
            start: BorderSide(color: redColor1, width: 3),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: ShimmerLoading(
                isLoading: isLoading,
                child: customTextApp(
                  text: title,
                  fontWeight: FontWeight.bold,
                  maxLine: null,
                ),
              ),
            ),
            //const Spacer(),
            iconTagView(
              isLoading: isLoading,
              text: total ?? "",
              textColor: redColor1,
              fontSize: 14,
              verticalPadding: 2,
              borderRadius: 8,
              borderColor: redBorderColor,
              bgColor: lightRedColor,
            ),
          ],
        ),
      ),
    );
