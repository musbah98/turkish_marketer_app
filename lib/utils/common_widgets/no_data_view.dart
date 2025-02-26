import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';
import 'package:turkish_marketer/utils/routing/navigation_service.dart';
import '../../di.dart';
import '/extentions.dart';
import '../app_widgets/custom_app_text.dart';

Widget showNoDataView({
  int minHeight = 0,
  String? text,
  String? image,
}) =>
    Center(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(sl<NavigationService>().getContext()).size.height - minHeight,
        ),
        //height: double.infinity, // Expand the container vertically
        child: Center(
          child: Column(
            children: [
              if (image != null) ...[
                Image.asset(image),
                const SizedBox(height: 16),
              ],
              customTextApp(
                text: text ?? "no_data".localized(),
                fontWeight: FontWeight.w500,
                size: 16,
                align: TextAlign.center,
                maxLine: null,
              ),
            ],
          ),
        ),
      ),
    );
