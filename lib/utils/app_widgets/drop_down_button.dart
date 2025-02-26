import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/images.dart';

import '../../models/drop_down_obj.dart';
import '../common_widgets/cached_url_image.dart';
import '../decoration_and_assets/colors.dart';
import 'custom_app_text.dart';

Widget dropDownButton({
  double? height,
  double? width,
  String? hintText,
  String? errorText,
  Color backgroundColor = Colors.white,
  required List<DropdownObj>? items,
  String? selectedItem,
  double horizontalPadding = 14,
  bool isEnabled = true,
  Color borderColor = textBorderColor,
  required Function(String?) didSelectItem,
}) {
  var dropDown = Container(
    decoration: BoxDecoration(
      border: Border.all(color: borderColor),
      borderRadius: BorderRadius.circular(8.0),
    ),
    padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 0),
    height: height ?? 44,
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        enableFeedback: isEnabled,
        isExpanded: true,
        value: selectedItem,
        hint: customTextApp(
          text: hintText ?? "--",
          size: 14,
          fontWeight: FontWeight.normal,
          color: subTitleColor,
        ),
        elevation: 4,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        icon: Image.asset(
          downIcon,
          width: 9,
        ),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: subTitleColor,
        ),
        items: items?.map<DropdownMenuItem<String>>((DropdownObj value) {
          return DropdownMenuItem<String>(
            enabled: isEnabled,
            value: "${value.id}",
            child: Row(
              children: [
                if (value.image != null) ...[
                  Container(
                    width: 24,
                    height: 24,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: cachedUrlImage(imageUrl: value.image ?? ""),
                  ),
                  const SizedBox(width: 8),
                ],
                customTextApp(
                  text: value.name ?? "",
                  size: 14,
                  fontWeight: FontWeight.normal,
                  color: subTitleColor,

                  //selectedItem == value.id
                  //  ? primaryColor
                  // : textFiledBackgroundColor,
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: didSelectItem,
      ),
    ),
  );

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customTextApp(
          text: hintText ?? '',
          fontWeight: FontWeight.w400,
          size: 14,
        ),
        const SizedBox(height: 4),
        dropDown,
        const SizedBox(height: 4),
        if (errorText != null) ...[
          customTextApp(
            text: errorText,
            color: redColor1,
            size: 14,
          ),
        ]
      ],
    ),
  );
}
