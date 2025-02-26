import 'package:flutter/material.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';
import 'package:turkish_marketer/utils/common_widgets/shimmer_loading.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/images.dart';

import '../../decoration_and_assets/colors.dart';
import '../app_card_widgets/list_card.dart';

Widget contactInfoContainerView({
  bool isLoading = false,
  required String? name,
  required String? country,
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
                  text: "contact_information".localized(),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              listCard(
                isLoading: isLoading,
                image: contactNameIcon,
                title: 'name'.localized(),
                subTitle: name ?? "",
                bgColor: Colors.white,
                borderColor: Colors.white,
              ),
              listCard(
                isLoading: isLoading,
                image: locationIIcon,
                title: 'country'.localized(),
                subTitle: country ?? "",
                bgColor: Colors.white,
                borderColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
