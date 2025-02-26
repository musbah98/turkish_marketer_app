import 'package:flutter/widgets.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';
import 'package:turkish_marketer/utils/common_widgets/shimmer_loading.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';

iconTagView({
  bool isLoading = false,
  required String text,
  Color? bgColor,
  Color textColor = textColor,
  Color borderColor = borderColor,
  String? image,
  double? widthImage,
  double paddingImage = 4,
  double borderRadius = 15,
  FontWeight fontWeight = FontWeight.bold,
  double fontSize = 14,
  double horizontalPadding = 8,
  double verticalPadding = 1,
  bool isExpand = false,
}) =>
    ShimmerLoading(
      isLoading: isLoading,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius),
          color: bgColor,
        ),
        child: Row(
          mainAxisSize: isExpand ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: isExpand ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            if (image != null) ...[
              Image.asset(
                image,
                width: widthImage,
              ),
              SizedBox(width: paddingImage),
            ],
            Flexible(
              child: customTextApp(
                text: text,
                size: fontSize,
                color: textColor,
                fontWeight: fontWeight,
                maxLine: null,
              ),
            ),
          ],
        ),
      ),
    );
