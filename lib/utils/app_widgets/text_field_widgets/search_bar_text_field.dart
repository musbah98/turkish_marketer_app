import 'package:flutter/material.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/images.dart';

Widget searchBarTextField({
  TextEditingController? textController,
  String? hintText,
  required Function(String?) onChangeText,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: redColor2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Search icon container
            Container(
              height: 32,
              width: 32,
              // padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: redColor1,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Image.asset(whiteSearchIcon),
            ),
            const SizedBox(width: 10),

            Expanded(
              child: Container(
                height: 34,
                //padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: textBorderColor, width: 1),
                ),
                child: TextField(
                  controller: textController,
                  onChanged: onChangeText,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: -16,
                      horizontal: 8,
                    ),
                    hintText: hintText ?? 'post_company_or_whatever_you_have_in_you'.localized(),
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
