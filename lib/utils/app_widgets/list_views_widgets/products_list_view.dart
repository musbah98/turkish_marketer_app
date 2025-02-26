import 'package:flutter/material.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';
import 'package:turkish_marketer/utils/common_widgets/shimmer_loading.dart';

import '../../decoration_and_assets/colors.dart';
import '../app_card_widgets/product_card.dart';

Widget productsListView({
  List<String>? products,
  bool isLoading = false,
}) =>
    LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var width = constraints.maxWidth;
        return Container(
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
                  ShimmerLoading(
                    isLoading: isLoading,
                    child: customTextApp(
                      text: "products".localized(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (products?.isNotEmpty ?? false) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 16,
                      alignment: WrapAlignment.center,
                      runSpacing: 12,
                      children: [
                        ...products!.map(
                          (item) => SizedBox(
                            width: width / 2 - 40,
                            child: productCard(
                              isLoading: isLoading,
                              title: item,
                              imgUrl:
                                  "https://media.istockphoto.com/id/1339057752/photo/a-large-container-cargo-ship-in-motion.jpg?s=612x612&w=0&k=20&c=l39VgVcB6NSmMjwAgS3nmZoZ-PEjEbGEnMFQEqHOOCg=",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
