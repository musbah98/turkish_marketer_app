import 'package:flutter/material.dart';
import 'package:turkish_marketer/extentions.dart';
import '../app_widgets/custom_app_text.dart';

Widget bottomLoader({required bool hasMore}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: hasMore
            ? const CircularProgressIndicator(
                color: Color(0xFF718096),
              )
            : customTextApp(
                text: "no_more_data".localized(),
                size: 14,
                fontWeight: FontWeight.bold,
              ),
      ),
    );
