import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';
import 'package:turkish_marketer/utils/common_widgets/shimmer_loading.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/images.dart';

import '../icon_tag_view.dart';

Widget postDetailsCard({
  bool isLoading = false,
  double vertical = 0,
  double horizontal = 0,
  int? minHeight,
  int? itemCount,
  Color? bgColor = bgColor,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: Container(
        color: bgColor,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    iconTagView(
                      isLoading: isLoading,
                      text: "Export",
                      textColor: redColor2,
                      borderColor: redBorderColor,
                      bgColor: lightRedColor,
                      image: exportIcon,
                    ),
                    const SizedBox(width: 8),
                    iconTagView(
                      isLoading: isLoading,
                      text: "Egypt",
                      image: eygptFlag,
                    ),
                    const Spacer(),
                    iconTagView(
                      isLoading: isLoading,
                      borderRadius: 6,
                      bgColor: Colors.white,
                      verticalPadding: 2,
                      text: "Credits | 10",
                      image: greenDot,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ShimmerLoading(
                  isLoading: isLoading,
                  child: Row(
                    children: [
                      Expanded(
                        child: customTextApp(
                          text: "Curtain Pole import Egypt",
                          fontWeight: FontWeight.bold,
                          maxLine: null,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                ShimmerLoading(
                  isLoading: isLoading,
                  child: customTextApp(
                    text:
                        "Hello, my friend, I am a trading company from China, if you need any products, please contact me. email:wangyaru@beijingholycity.com",
                    size: 12,
                    color: subTitleColor,
                    maxLine: null,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    iconTagView(
                      isLoading: isLoading,
                      text: "1views",
                      image: eyeIcon,
                      fontSize: 12,
                      widthImage: 18,
                      paddingImage: 8,
                      textColor: subTitleColor,
                      borderColor: Colors.white,
                      horizontalPadding: 0,
                    ),
                    const SizedBox(width: 20),
                    iconTagView(
                      isLoading: isLoading,
                      text: "23/08/2024",
                      image: eyeIcon,
                      widthImage: 18,
                      fontSize: 12,
                      paddingImage: 8,
                      textColor: subTitleColor,
                      borderColor: Colors.white,
                      horizontalPadding: 0,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            )),
      ),
    );
