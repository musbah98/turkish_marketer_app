import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';

import '../custom_app_text.dart';

switchWithTextButton({
  required String text,
  required bool value,
  required void Function(bool)? onChanged,
}) =>
    Container(
      color: Colors.white,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Switch(
            thumbColor: WidgetStateProperty.all(Colors.white),
            activeColor: redColor1,
            inactiveTrackColor: textBorderColor,
            value: value,
            onChanged: onChanged,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: customTextApp(
              text: text,
              size: 14,
              fontWeight: FontWeight.w500,
              maxLine: null,
            ),
          )
        ],
      ),
    );
