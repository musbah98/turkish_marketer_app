import 'package:flutter/material.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/app_widgets/buttons_widgets/custom_app_text_button.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';
import '../../../screens/profile/profile_view_model.dart';

profileCard(
  ProfileItem item, {
  bool isItem = true,
  bool isDelete = false,
}) =>
    InkWell(
      onTap: item.onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isItem ? bgColor : const Color(0xFFFCFCFD),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (isItem && !isDelete) ...[
                  Image.asset(item.icon ?? ""),
                  // Icon(item.icon, color: Colors.grey, size: 20),
                  const SizedBox(width: 12),
                ],
                customTextApp(
                  text: item.title,
                  size: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            if (isItem) ...[
              if (isDelete) ...[
                customTextButtonApp(text: "delete".localized(), size: 12, onPressed: () {})
              ] else ...[
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ]
            ],
          ],
        ),
      ),
    );
