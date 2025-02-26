import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';
import 'package:turkish_marketer/utils/common_widgets/shimmer_loading.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';

checkBoxCard({
  bool isLoading = false,
  required String title,
  Color? bgColor = Colors.white,
  Color borderColor = borderColor,
  double borderRadius = 0,
  bool isSelected = false,
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
              color: isSelected ? redColor1 : borderColor,
              width: 1,
            ),
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          color: bgColor,
        ),
        child: Row(
          children: [
            Flexible(
              flex: 10,
              fit: FlexFit.tight,
              child: ShimmerLoading(
                isLoading: isLoading,
                child: customTextApp(
                  text: title,
                  fontWeight: FontWeight.w500,
                  size: 14,
                  color: textColor,
                  maxLine: null,
                ),
              ),
            ),
            const Spacer(),
            checBox(isSelected),
          ],
        ),
      ),
    );

checBox(bool isSelected) => Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? redColor1 : textBorderColor),
        borderRadius: BorderRadius.circular(4),
        color: isSelected ? redColor1 : bgColor,
      ),
      child: const Icon(
        Icons.check,
        size: 15,
        color: Colors.white,
      ),
    );
