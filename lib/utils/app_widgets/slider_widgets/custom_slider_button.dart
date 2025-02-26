import 'package:flutter/material.dart';

import '../../decoration_and_assets/colors.dart';
import '../custom_app_text.dart';

Widget customSliderButton({
  required String text,
  String? totalText,
  required void Function()? onPressed,
  required bool isSelected,
  double width = 0,
}) =>
    ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        overlayColor: textColor,
        minimumSize: Size(width, 20),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        backgroundColor: isSelected ? Colors.white : bgColor,
        elevation: isSelected ? 0.5 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Row(
        children: [
          customTextApp(
            text: text,
            fontWeight: FontWeight.w600,
            size: 14,
            color: isSelected ? textColor : placeHolderColor,
          ),
          if (totalText != null) ...[
            const SizedBox(width: 8),
            Container(
              //width: 20,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: borderColor,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: customTextApp(
                    text: totalText,
                    size: 12,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
