import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';
import 'package:turkish_marketer/extentions.dart';

import '../../../../utils/IntlPhoneField/helpers.dart';
import '../../../../utils/IntlPhoneField/phone_number.dart';

final rfqViewModelProvider = ChangeNotifierProvider((ref) => RfqViewModel());

class RfqViewModel with ChangeNotifier {
  late BuildContext context;

  var phoneTextEditingController = TextEditingController();

  String? selectedCountryCode = "TR";
  String phoneHintText = "";

  String name = '';
  String phone = '';
  String subject = '';
  String description = '';

  String? filePath;

  bool isNameValid = true;
  bool isPhoneValid = true;
  bool isSubjectValid = true;
  bool isDescriptionValid = true;

  bool isAgree = false;

  String nameErrorText = '';
  String phoneErrorText = '';
  String subjectErrorText = '';
  String descriptionErrorText = '';

  bool isObscureText = true;
  bool isLoading = false;

  validateName(String value) {
    name = value.trim();
    isNameValid = value.isNotEmpty;

    if (isNameValid) {
      nameErrorText = '';
    } else {
      nameErrorText = 'name_is_required'.localized();
    }

    notifyListeners();
  }

  validatePhone(PhoneNumber value) async {
    var text = "";
    phone = value.countryCode + value.number.trim();
    text = value.number.trim();

    isPhoneValid = text.isNotEmpty;
    var isValid = await PhoneNumberUtil.isValidPhoneNumber(text, selectedCountryCode ?? "") ?? false;
    phoneErrorText = '';

    if (!isValid) {
      phoneErrorText = 'invalid_phone_number'.localized();
    }
    if (!isPhoneValid) {
      phoneErrorText = 'phone_number_required'.localized();
    }

    isPhoneValid = isValid;

    notifyListeners();
  }

  validateSubject(String value) {
    subject = value.trim();
    isSubjectValid = value.isNotEmpty;

    if (isSubjectValid) {
      subjectErrorText = '';
    } else {
      subjectErrorText = 'subject_required'.localized();
    }

    notifyListeners();
  }

  validateDescription(String value) {
    description = value.trim();
    isDescriptionValid = value.isNotEmpty;

    if (isDescriptionValid) {
      descriptionErrorText = '';
    } else {
      descriptionErrorText = 'description_required'.localized();
    }

    notifyListeners();
  }

  changeCountry(String value) async {
    phoneTextEditingController.text = "";
    phone = "";
    isPhoneValid = true;
    selectedCountryCode = value;

    phoneHintText = (await getFormattedPhoneNumber(value)) ?? "";

    notifyListeners();
  }

  changeIsAgree(bool value) async {
    isAgree = value;
    notifyListeners();
  }

  Future<void> picFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'svg',
        'jpg',
        'png',
      ],
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      // String base64String = files[0].toBase64();
      String fileName = files[0].path.getFileName();
      String extension = files[0].path.getFileExtension();
      filePath = fileName + extension;
    } else {
      // User canceled the picker
    }

    notifyListeners();
  }
}
