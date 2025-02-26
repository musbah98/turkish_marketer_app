import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';
import 'package:turkish_marketer/utils/common_widgets/shimmer_loading.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/dimentions.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/images.dart';

import '../../decoration_and_assets/decorations.dart';
import '../../common_widgets/triangle_painter.dart';
import '../../common_widgets/cached_url_image.dart';
import '../icon_tag_view.dart';

Widget companyCard({
  bool isLoading = false,
  double vertical = 6,
  double horizontal = 16,
  int? minHeight,
  int? itemCount,
  Color? bgColor,
  bool isDescrption = false,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: Container(
        decoration: postCardContainer,
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ShimmerLoading(
                          isLoading: isLoading,
                          child: cachedUrlImage(
                            imageUrl: "https://corporategenie.in/wp-content/uploads/2021/07/import-export.jpg",
                            width: double.infinity,
                            height: 142,
                            radius: 12,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: -22,
                          right: isRTL() ? null : 17,
                          left: isRTL() ? 17 : null,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: 58,
                            height: 63,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: disabledButtonColor,
                            ),
                            child: ShimmerLoading(
                              isLoading: isLoading,
                              child: cachedUrlImage(
                                  imageUrl:
                                      "https://static.vecteezy.com/system/resources/previews/023/654/784/non_2x/golden-logo-template-free-png.png"),
                            ),
                          ),
                        ),
                        if (isLoading == false) ...[
                          sponserdWidget(),
                        ],
                      ],
                    ),
                    const SizedBox(height: 12),
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
                    if (isDescrption) ...[
                      Row(
                        children: [
                          iconTagView(
                            isLoading: isLoading,
                            text: "Clothing - Fashion",
                            image: arrowUpIcon,
                            borderRadius: 8,
                            verticalPadding: 4,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                    ],
                    ShimmerLoading(
                      isLoading: isLoading,
                      child: customTextApp(
                        text:
                            "We are a textile garment manufacturer established in 2007. We provide the highest quality products. We can help you with all your requests. T-Shirt, Sweatshirt, Hoodie, Shorts, Leggings, Crop, Tank Tops etc.the highest quality products. We can help you with all your requests. T-Shirt, Sweatshirt, Hoodie, Shorts, Leggings, Crop, Tank Tops etc.",
                        size: 12,
                        color: subTitleColor,
                        maxLine: isDescrption ? null : 2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ShimmerLoading(
                      isLoading: isLoading,
                      child: customTextApp(
                        text: "#striped socks #wool socks",
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
                          text: "10 Credits",
                          image: creditsIcon,
                          fontSize: 12,
                          textColor: subTitleColor,
                          borderColor: Colors.white,
                          horizontalPadding: 0,
                        ),
                        const SizedBox(width: 20),
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
                    if (isDescrption) ...[
                      ShimmerLoading(
                        isLoading: isLoading,
                        child: Row(
                          children: [
                            iconTagView(
                              text: "Manufacturer",
                              image: settingsIcon,
                              borderRadius: 8,
                              verticalPadding: 4,
                            ),
                            const SizedBox(width: 8),
                            iconTagView(
                              text: "Exporter",
                              image: arrowUpLeftIcon,
                              borderRadius: 8,
                              verticalPadding: 4,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ],
            )),
      ),
    );

sponserdWidget() => Positioned(
      top: 23,
      right: -20,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
              color: orangeColor,
            ),
            child: customTextApp(
              size: 14,
              text: "Sponsored",
              color: Colors.white,
            ),
          ),
          Positioned(
            bottom: -10,
            right: 0,
            child: CustomPaint(
              size: const Size(10, 10),
              painter: TrianglePainter(),
            ),
          )
        ],
      ),
    );
