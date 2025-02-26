import 'package:flutter/material.dart';
import 'package:turkish_marketer/extentions.dart';

import '../../decoration_and_assets/colors.dart';
import 'custom_app_button.dart';

cancelAndSaveButtonsRow({
  String textCancelButton = "cancel",
  String textSaveButton = "save",
  bool isDisabledSaveButton = true,
  double textSizeCancel = 16.0,
  double textSizeSave = 16.0,
  double padding = 0,
  required void Function()? onPressedCancel,
  required void Function()? onPressedSave,
}) =>
    Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              // flex: 1,
              child: customButtonApp(
                isStroke: true,
                text: textCancelButton.localized(),
                backgroundColor: Colors.white,
                textColor: activeButtonColor,
                onPressed: onPressedCancel,
                size: textSizeCancel,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              //flex: 1,
              child: customButtonApp(
                text: textSaveButton.localized(),
                onPressed: onPressedSave,
                size: textSizeSave,
                isDisabled: isDisabledSaveButton,
              ),
            )
          ],
        ),
      ),
    );
