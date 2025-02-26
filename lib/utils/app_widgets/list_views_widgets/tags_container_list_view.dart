import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';
import 'package:turkish_marketer/utils/app_widgets/icon_tag_view.dart';

import '../../decoration_and_assets/colors.dart';

Widget tagsContainerListView({
  bool isLoading = false,
  required List<String> tags,
}) =>
    Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: bgColor,
        border: BorderDirectional(
          top: BorderSide(color: borderColor),
          bottom: BorderSide(color: borderColor),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextApp(
                text: "ASLANLAR AKDENIZ INSAAT LTD. ",
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...tags.map(
                    (item) => iconTagView(
                      isLoading: isLoading,
                      text: item,
                      fontWeight: FontWeight.w500,
                      borderRadius: 8,
                      verticalPadding: 7,
                      horizontalPadding: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
