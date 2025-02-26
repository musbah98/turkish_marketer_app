import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';

import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/IntlPhoneField/helpers.dart';
import 'package:turkish_marketer/utils/IntlPhoneField/phone_number.dart';

import '../../../models/drop_down_obj.dart';

final editProfileViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  return EditProfileViewModel();
});

class EditProfileViewModel extends ChangeNotifier {
  late BuildContext context;

  var phoneTextEditingController = TextEditingController();

  String? selectedCountryCode = "TR";
  String phoneHintText = "";

  String name = '';
  String email = '';
  String password = '';
  String phone = '';

  bool isNameValid = true;
  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isPhoneValid = true;

  String nameErrorText = '';
  String emailErrorText = '';
  String passwordErrorText = '';
  String phoneErrorText = '';

  bool isObscureText = true;
  bool isLoading = false;

  DropdownObj? selectedCountry;

  var countriesList = [
    DropdownObj(
      id: "0",
      name: "India",
      image: "https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png",
    ),
    DropdownObj(
      id: "1",
      name: "Palestine",
      image: "https://www.rjtravelagency.com/wp-content/uploads/2023/09/Flag-of-Palestine.jpg",
    ),
    DropdownObj(
        id: "2",
        name: "Qatar",
        image:
            "https://www.colonialflag.com/cdn/shop/products/qatar-flag__19414.1639690374.1280.1280.jpg?v=1673391107"),
  ];

  obscureText() {
    isObscureText = !isObscureText;
    notifyListeners();
  }

  validateName(String value) {
    name = value.trim();
    isNameValid = value.isNotEmpty;

    if (isNameValid) {
      nameErrorText = '';
    } else {
      nameErrorText = 'name_required'.localized();
    }

    notifyListeners();
  }

  validateEmail(String value) {
    email = value.trim();
    isEmailValid = value.isNotEmpty;

    if (isEmailValid) {
      emailErrorText = '';
    } else {
      emailErrorText = 'email_required'.localized();
    }

    notifyListeners();
  }

  validatePassword(String value) {
    password = value.trim();
    isPasswordValid = value.isNotEmpty;

    if (isPasswordValid) {
      passwordErrorText = '';
    } else {
      passwordErrorText = 'password_required'.localized();
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

  changeCountry(String value) async {
    phoneTextEditingController.text = "";
    phone = "";
    isPhoneValid = true;
    selectedCountryCode = value;

    phoneHintText = (await getFormattedPhoneNumber(value)) ?? "";

    notifyListeners();
  }

  setSelectedCounrty(String? id) {
    selectedCountry = countriesList.firstWhereOrNull((p0) => p0.id == id);
    notifyListeners();
  }
}
