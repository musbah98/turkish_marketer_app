import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../decoration_and_assets/colors.dart';
import 'custom_app_text.dart';
import '../decoration_and_assets/images.dart';

mainTitleWithLogo({
  double? topPadding,
  String? logo,
  required String title,
  String? subTitle,
}) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: topPadding),
          SvgPicture.asset(
            logo ?? fullLogo,
          ),
          const SizedBox(height: 12),
          customTextApp(
            text: title,
            size: 22,
            color: titleColor,
            fontWeight: FontWeight.bold,
            align: TextAlign.center,
          ),
          if (subTitle != null) ...[
            const SizedBox(height: 8),
            customTextApp(
              text: subTitle,
              maxLine: 2,
              color: subTitleColor,
              align: TextAlign.center,
            ),
          ]
        ],
      ),
    );
