import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';
import 'package:turkish_marketer/utils/common_widgets/shimmer_loading.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';

listCard({
  bool isLoading = false,
  required String title,
  required String subTitle,
  Color? bgColor = bgColor,
  Color borderColor = Colors.white,
  String? image,
  double? imageWidth,
  double borderRadius = 8,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius),
          color: bgColor,
        ),
        child: Row(
          children: [
            if (image != null) ...[
              ShimmerLoading(
                isLoading: isLoading,
                child: Image.asset(
                  image,
                  width: imageWidth,
                ),
              ),
              const SizedBox(width: 4),
            ],
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: ShimmerLoading(
                      isLoading: isLoading,
                      child: customTextApp(
                        text: title,
                        maxLine: null,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Flexible(
                    child: ShimmerLoading(
                      isLoading: isLoading,
                      child: customTextApp(
                        text: subTitle,
                        size: 12,
                        color: subTitleColor,
                        maxLine: null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
