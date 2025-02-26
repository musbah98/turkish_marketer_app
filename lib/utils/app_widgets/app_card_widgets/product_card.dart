import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/common_widgets/shimmer_loading.dart';

import '../../common_widgets/cached_url_image.dart';
import '../icon_tag_view.dart';

productCard({
  bool isLoading = false,
  required String title,
  required String imgUrl,
}) =>
    Column(
      children: [
        ShimmerLoading(
          isLoading: isLoading,
          child: cachedUrlImage(
            imageUrl: imgUrl,
            radius: 12,
            height: 111,
          ),
        ),
        const SizedBox(height: 12),
        ShimmerLoading(
          isLoading: isLoading,
          child: iconTagView(
            text: title,
            borderRadius: 8,
            verticalPadding: 8,
            fontWeight: FontWeight.w500,
            isExpand: true,
          ),
        ),
      ],
    );
