import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';
import 'package:turkish_marketer/utils/common_widgets/shimmer_loading.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/images.dart';

import '../../decoration_and_assets/decorations.dart';
import '../../common_widgets/cached_url_image.dart';
import '../icon_tag_view.dart';

Widget postCard({
  bool isLoading = false,
  double vertical = 6,
  double horizontal = 16,
  int? minHeight,
  int? itemCount,
  Color? bgColor,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: Container(
        decoration: postCardContainer,
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading(
                      isLoading: isLoading,
                      child: cachedUrlImage(
                        imageUrl: "https://corporategenie.in/wp-content/uploads/2021/07/import-export.jpg",
                        width: 98,
                        height: 98,
                        radius: 12,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
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
                              text: "We are a textile garment manufacturer established in 2007",
                              size: 12,
                              color: subTitleColor,
                              maxLine: 2,
                            ),
                          ),
                          const SizedBox(height: 6),
                          ShimmerLoading(
                            isLoading: isLoading,
                            child: Row(
                              children: [
                                Expanded(
                                  child: customTextApp(
                                    text: "#striped socks #wool socks",
                                    size: 12,
                                    color: subTitleColor,
                                    maxLine: null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              iconTagView(
                                isLoading: isLoading,
                                text: "10 Credits",
                                image: creditsIcon,
                                fontSize: 12,
                                textColor: subTitleColor,
                                borderColor: Colors.white,
                                horizontalPadding: 0,
                              ),
                              const Spacer(),
                              iconTagView(
                                isLoading: isLoading,
                                text: "5 hours ago",
                                image: timeIcon,
                                fontSize: 12,
                                textColor: subTitleColor,
                                borderColor: Colors.white,
                                horizontalPadding: 0,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
