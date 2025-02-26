// ignore_for_file: avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:turkish_marketer/extentions.dart';

import '../../../../utils/decoration_and_assets/colors.dart';

class ClickableText extends StatelessWidget {
  const ClickableText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: 'by_clicking_sign_up_button_you_agree_the_processing_personal_data_under'.localized(),
          style: appTextStyle(),
          children: <TextSpan>[
            text(text: " "),
            text(
                text: 'membership_clarification_text'.localized(),
                color: const Color(0xFF528BFF),
                onPressed: () {
                  //print("Press the Membership button");
                }),
            text(text: ", "),
            text(
              text: 'express_consent_ext'.localized(),
              color: const Color(0xFF528BFF),
              onPressed: () {
                //print("Press the text button");
              },
            ),
            text(text: " "),
            text(
              text: 'and'.localized(),
            ),
            text(text: " "),
            text(
              text: 'commercial_email_message_approval_form'.localized(),
              color: const Color(0xFF528BFF),
              onPressed: () {
                //print("Press the text button");
              },
            ),
          ],
        ),
      ),
    );
  }

  text({
    required String text,
    Color? color,
    void Function()? onPressed,
  }) =>
      TextSpan(
        text: text,
        style: appTextStyle(color: color),
        recognizer: TapGestureRecognizer()..onTap = onPressed,
      );

  TextStyle appTextStyle({Color? color}) => TextStyle(
        color: color ?? subTitleColor,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.5,
      );
}
