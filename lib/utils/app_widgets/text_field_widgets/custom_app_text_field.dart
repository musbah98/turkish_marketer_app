import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/images.dart';

Widget customAppTextField({
  TextEditingController? textController,
  String? initialValue,
  required String hintText,
  String? labelText,
  String? helperText,
  String? errorText,
  Widget? prefixNewIcon,
  Widget? suffixIcon,
  Color bgColor = Colors.white,
  Color placeHolderColor = placeHolderColor,
  Color borderColor = textBorderColor,
  Color fontColor = textColor,
  TextAlign textAlign = TextAlign.justify,
  double fontSize = 16,
  double contentVerticalPadding = 0,
  double contentHorizontalPadding = 14,
  FocusNode? focusNode,
  bool autofocus = false,
  FontWeight fontWeight = FontWeight.normal,
  bool isDropDown = false,
  bool isEnabled = true,
  bool isExpand = false,
  bool isObscureText = false,
  TextInputType? keyboardType = TextInputType.text,
  List<TextInputFormatter>? inputFormatters,
  Function(String)? onChanged,
  Function()? suffixIconAction,
  String? Function(String?)? validator,
  int? maxLength,
}) {
  var textFormField = TextFormField(
    initialValue: initialValue,
    controller: textController,
    focusNode: focusNode,
    validator: validator,
    autofocus: autofocus,
    enabled: isEnabled,
    obscureText: isObscureText,
    keyboardType: isExpand ? TextInputType.multiline : keyboardType,
    maxLines: isExpand ? null : 1,
    expands: isExpand,
    textAlignVertical: isExpand ? TextAlignVertical.top : TextAlignVertical.center,
    cursorErrorColor: errorBorderColor,
    cursorColor: textColor,
    inputFormatters: inputFormatters,
    maxLength: maxLength,
    decoration: InputDecoration(
      prefixIcon: prefixNewIcon,

      suffixIcon: isDropDown
          ? const Icon(Icons.keyboard_arrow_down)
          : (suffixIcon != null)
              ? InkWell(
                  onTap: suffixIconAction,
                  child: suffixIcon,
                )
              : (errorText != null)
                  ? SvgPicture.asset(
                      alertErrorCircle,
                      fit: BoxFit.scaleDown,
                    )
                  : null,
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
        vertical: isExpand ? 12 : contentVerticalPadding,
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
      hintText: hintText,
      helperText: helperText,
      errorText: errorText,
    ),
    style: TextStyle(
      color: titleColor,
      fontWeight: fontWeight,
      fontSize: fontSize,
    ),
    textAlign: textAlign,
    onChanged: onChanged,
  );
  return Padding(
    padding: EdgeInsets.symmetric(vertical: isExpand ? 0 : 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customTextApp(
          text: labelText ?? '',
          fontWeight: FontWeight.w400,
          size: 14,
        ),
        const SizedBox(height: 4),
        if (isExpand) ...[
          Expanded(
            child: textFormField,
          ),
        ] else ...[
          textFormField,
        ],
        if (errorText != null) ...[
          const SizedBox(height: 4),
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
