import 'package:flutter/material.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';
import 'package:turkish_marketer/utils/common_widgets/shimmer_loading.dart';

import '../../decoration_and_assets/colors.dart';
import '../../decoration_and_assets/images.dart';
import '../app_card_widgets/list_card.dart';

Widget attachmentsContainerListView({
  bool isLoading = false,
  List<String>? attachments,
  Color containerborderColor = borderColor,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        border: BorderDirectional(
          top: BorderSide(color: containerborderColor),
          bottom: BorderSide(color: containerborderColor),
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
                  text: "attachments".localized(),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...attachments!.map(
                (item) => SizedBox(
                  child: listCard(
                    isLoading: isLoading,
                    title: item,
                    imageWidth: 28,
                    subTitle: "200 KB",
                    image: pdfIcon,
                    bgColor: Colors.white,
                    borderColor: borderColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
