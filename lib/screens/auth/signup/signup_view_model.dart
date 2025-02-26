import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';

import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/repositories/auth_repository.dart';
import 'package:turkish_marketer/screens/auth/verification/verification_view_model.dart';
import 'package:turkish_marketer/utils/IntlPhoneField/helpers.dart';
import 'package:turkish_marketer/utils/IntlPhoneField/phone_number.dart';
import 'package:turkish_marketer/utils/local_repository.dart';
import 'package:turkish_marketer/utils/routing/navigation_service.dart';
import 'package:turkish_marketer/utils/routing/routes.dart';

import '../../../di.dart';
import '../../../models/drop_down_obj.dart';
import '../../../repositories/registration_info_repository.dart';
import '../../../utils/common_widgets/loading_dialog.dart';

final signupViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  return SignupViewModel();
});

class SignupViewModel extends ChangeNotifier {
  late BuildContext context;

  var phoneTextEditingController = TextEditingController();

  String selectedCountryCode = "";
  String phoneHintText = "";

  String name = '';
  String email = '';
  String password = '';
  String mobile = '';
  String mobileIntro = '';

  bool? isNameValid;
  bool? isEmailValid;
  bool? isPasswordValid;
  bool? isPhoneValid;

  String nameErrorText = '';
  String emailErrorText = '';
  String passwordErrorText = '';
  String phoneErrorText = '';

  bool isObscureText = true;
  bool isLoading = false;

  DropdownObj? selectedCountry;

  List<DropdownObj> countriesList = [];

  obscureText() {
    isObscureText = !isObscureText;
    notifyListeners();
  }

  validateName(String value) {
    name = value.trim();
    isNameValid = value.isNotEmpty;

    if (isNameValid ?? false) {
      nameErrorText = '';
    } else {
      nameErrorText = 'name_is_required'.localized();
    }

    notifyListeners();
  }

  validateEmail(String value) {
    email = value.trim();
    isEmailValid = value.isNotEmpty;

    if (isEmailValid ?? false) {
      emailErrorText = '';

      if (!value.isValidEmail()) {
        isEmailValid = false;
        emailErrorText = 'please_enter_valid_email'.localized();
      } else {
        emailErrorText = '';
      }
    } else {
      emailErrorText = 'email_required'.localized();
    }

    notifyListeners();
  }

  validatePassword(String value) {
    password = value.trim();
    isPasswordValid = value.isNotEmpty;

    if (isPasswordValid ?? false) {
      passwordErrorText = '';
    } else {
      passwordErrorText = 'password_required'.localized();
    }

    notifyListeners();
  }

  validatePhone(PhoneNumber value) async {
    var text = "";
    mobile = value.number.trim();
    mobileIntro = value.countryCode;
    text = value.number.trim();

    isPhoneValid = text.isNotEmpty;
    var isValid = await PhoneNumberUtil.isValidPhoneNumber(text, selectedCountryCode) ?? false;
    phoneErrorText = '';

    if (!isValid) {
      phoneErrorText = 'invalid_phone_number'.localized();
    }
    if (!(isPhoneValid ?? false)) {
      phoneErrorText = 'phone_number_required'.localized();
    }

    isPhoneValid = isValid;

    notifyListeners();
  }

  changeCountry(String value) async {
    phoneTextEditingController.text = "";
    mobile = "";
    isPhoneValid = true;
    selectedCountryCode = value;
    phoneHintText = (await getFormattedPhoneNumber(value)) ?? "";
    notifyListeners();
  }

  setSelectedCounrty(String? id) {
    selectedCountry = countriesList.firstWhereOrNull((p0) => p0.id == id);
    notifyListeners();
  }

  bool checkValid() {
    return ((isNameValid ?? false) &&
            (isEmailValid ?? false) &&
            (isPasswordValid ?? false) &&
            (isPhoneValid ?? false) &&
            selectedCountry?.id != null)
        ? true
        : false;
  }

  Future getSignUpInfo() async {
    isLoading = true;
    notifyListeners();

    LoadingAlertDialog.show(
      context,
      title: "getSignUpInfo".localized(),
    );

    try {
      final response = await sl<RegistrationInfoRepository>().getSignUpInfo();

      countriesList =
          response.result!.countries!.map((e) => DropdownObj(id: "${e.id}", name: e.name, image: e.flag)).toList();
      var countryCode = (getCountryCodeByDialCode("+${response.result?.mobileIntro ?? ""}"));

      changeCountry(countryCode ?? "");
    } catch (e) {
      log('errorMessage : ${e.toString()}');
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
      LoadingAlertDialog.dismiss();
    }
  }

  Future signupButton(WidgetRef ref) async {
    if (checkValid()) {
      isLoading = true;
      notifyListeners();

      LoadingAlertDialog.show(
        context,
        title: "Signup".localized(),
      );

      try {
        final response = await sl<AuthRepository>().signUp(
          name,
          email,
          password,
          mobile,
          mobileIntro,
          selectedCountry?.id ?? "",
        );

        if (response.result?.activateCode != null) {
          var verificationViewModel = ref.watch(verificationViewModelProvider);
          //verificationViewModel.activeCode = "${response.result?.activateCode!}";
          verificationViewModel.email = email;

          sl<LocalRepo>().setUserObject(response.result!);

          sl<Dio>().options.headers.addAll(
            {'Authorization': 'Bearer ${response.result?.token}'},
          );

          sl<NavigationService>().navigateTo(verificationScreen);
        }

        notifyListeners();
      } catch (e) {
        log('errorMessage : ${e.toString()}');
        notifyListeners();
      } finally {
        isLoading = false;
        notifyListeners();
        LoadingAlertDialog.dismiss();
      }
    }
  }
}
