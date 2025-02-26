import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';
import 'package:turkish_marketer/utils/common_widgets/shimmer_loading.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';

subCategoryCard({
  bool isLoading = false,
  required String title,
  Color? bgColor = Colors.white,
  Color borderColor = borderColor,
  double borderRadius = 0,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          color: bgColor,
        ),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 100,
              child: ShimmerLoading(
                isLoading: isLoading,
                child: customTextApp(
                  text: title,
                  fontWeight: FontWeight.w500,
                  size: 14,
                  maxLine: null,
                  color: textColor,
                ),
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: placeHolderColor,
            )
          ],
        ),
      ),
    );
