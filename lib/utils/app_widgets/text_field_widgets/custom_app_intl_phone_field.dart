import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/IntlPhoneField/country_picker_dialog.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';

import '../../IntlPhoneField/countries.dart';
import '../../IntlPhoneField/intl_phone_field.dart';
import '../../IntlPhoneField/phone_number.dart';
import '../../decoration_and_assets/images.dart';

Widget customAppIntlPhoneField({
  TextEditingController? textController,
  String? initialCountryCode,
  String? initialValue,
  required String hintText,
  String? labelText,
  String? errorText,
  Color bgColor = Colors.white,
  Color placeHolderColor = placeHolderColor,
  Color borderColor = textBorderColor,
  Color fontColor = textColor,
  TextAlign textAlign = TextAlign.justify,
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.normal,
  double contentVerticalPadding = 0,
  double contentHorizontalPadding = 14,
  FocusNode? focusNode,
  bool autofocus = false,
  bool isEnabled = true,
  bool disableAutoFillHints = false,
  List<TextInputFormatter>? inputFormatters,
  Function(PhoneNumber)? onChanged,
  Function(Country)? onCountryChanged,
}) {
  var textFormField = IntlPhoneField(
    initialValue: initialValue,
    initialCountryCode: initialCountryCode,
    controller: textController,
    focusNode: focusNode,
    autofocus: autofocus,
    enabled: isEnabled,

    disableAutoFillHints: disableAutoFillHints,
    cursorColor: textColor,
    inputFormatters: inputFormatters,
    showCountryFlag: false,
    //disableLengthCheck: true,
    suffixIcon: (errorText != null)
        ? SvgPicture.asset(
            alertErrorCircle,
            fit: BoxFit.scaleDown,
          )
        : null,
    flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 7),
    flagsButtonMargin: const EdgeInsets.symmetric(horizontal: 0),
    dropdownIconPosition: IconPosition.trailing,
    dropdownTextStyle: TextStyle(
      color: placeHolderColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
    pickerDialogStyle: PickerDialogStyle(
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      searchFieldCursorColor: placeHolderColor,
      searchFieldPadding: const EdgeInsets.only(top: 20),
      listTilePadding: const EdgeInsets.symmetric(vertical: 0),
      countryCodeStyle: const TextStyle(
        color: subTitleColor,
        fontSize: 14,
      ),
      countryNameStyle: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      listTileDivider: Container(
        color: borderColor,
        height: 1,
      ),
      searchFieldInputDecoration: InputDecoration(
        suffixIcon: Icon(
          Icons.search,
          color: placeHolderColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(8.0),
          gapPadding: 0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(8.0),
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: textColor),
          borderRadius: BorderRadius.circular(8.0),
          gapPadding: 0,
        ),
        labelText: "search".localized(),
        labelStyle: TextStyle(
          color: placeHolderColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    ),
    dropdownIcon: const Icon(
      color: grayColor,
      Icons.expand_less,
      size: 20,
    ),
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(8.0),
        gapPadding: 0,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(8.0),
        gapPadding: 0,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(8.0),
        gapPadding: 0,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: errorBorderColor),
        borderRadius: BorderRadius.circular(8.0),
        gapPadding: 0,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: errorBorderColor),
        borderRadius: BorderRadius.circular(8.0),
        gapPadding: 0,
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: contentVerticalPadding,
        horizontal: contentHorizontalPadding,
      ),
      filled: false,
      //fillColor: bgColor,
      // floatingLabelStyle: TextStyle(
      //   color: subTitleColor,
      //   fontSize: fontSize,
      //   fontWeight: FontWeight.w400,
      // ),

      labelStyle: TextStyle(
        color: placeHolderColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      helperStyle: TextStyle(
        color: subTitleColor,
        fontSize: 14,
        fontWeight: fontWeight,
      ),
      hintStyle: TextStyle(
        color: placeHolderColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      errorStyle: TextStyle(
        color: redColor1,
        fontWeight: fontWeight,
        fontSize: 0,
      ),
      //labelText: labelText ?? hintText,

      hintTextDirection: TextDirection.ltr,
      hintText: hintText,
      errorText: errorText,
    ),
    style: TextStyle(
      color: titleColor,
      fontWeight: fontWeight,
      fontSize: fontSize,
    ),
    textAlign: textAlign,
    onChanged: onChanged,
    onCountryChanged: onCountryChanged,
  );

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customTextApp(
          text: labelText ?? '',
          fontWeight: FontWeight.w400,
          size: 14,
        ),
        const SizedBox(height: 4),
        textFormField,
        const SizedBox(height: 4),
        if (errorText != null) ...[
          customTextApp(
            text: errorText,
            color: redColor1,
            fontWeight: fontWeight,
            size: 14,
          ),
        ]
      ],
    ),
  );
}
