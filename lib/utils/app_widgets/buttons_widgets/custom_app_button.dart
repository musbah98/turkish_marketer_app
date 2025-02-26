import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';

Widget customButtonApp({
  required String text,
  double size = 16.0,
  double? width,
  int? maxLine = 1,
  FontWeight fontWeight = FontWeight.w600,
  isDisabled = false,
  isStroke = false,
  String? image,
  backgroundColor = activeButtonColor,
  textColor = Colors.white,
  required void Function()? onPressed,
}) =>
    SizedBox(
      width: width,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                width: isStroke ? 1 : 0,
                color: isStroke ? textBorderColor : Colors.transparent,
              ),
            ),
          ),
          backgroundColor:
              isDisabled ? WidgetStateProperty.all(disabledButtonColor) : WidgetStateProperty.all(backgroundColor),
          overlayColor: isDisabled
              ? WidgetStateProperty.all(backgroundColor.withOpacity(0.1))
              : WidgetStateProperty.all(disabledButtonColor.withOpacity(0.1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.cover,
              child: customTextApp(
                text: text,
                size: size,
                color: isDisabled ? grayColor : textColor,
                fontWeight: fontWeight,
                maxLine: maxLine,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (image != null) ...[
              const SizedBox(width: 6),
              Image.asset(image),
            ],
          ],
        ),
      ),
    );
