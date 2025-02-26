import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';

Widget customTextButtonApp({
  required String text,
  Color color = redColor2,
  double size = 14.0,
  int? maxLine = 1,
  FontWeight fontWeight = FontWeight.w600,
  Icon? icon,
  required void Function()? onPressed,
}) =>
    InkWell(
      onTap: onPressed,
      highlightColor: color.withOpacity(0.05),
      overlayColor: WidgetStateProperty.all(color.withOpacity(0.05)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            const Icon(Icons.arrow_back),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: size,
              color: color,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
