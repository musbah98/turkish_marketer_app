import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';

import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/repositories/auth_repository.dart';
import 'package:turkish_marketer/utils/IntlPhoneField/helpers.dart';
import 'package:turkish_marketer/utils/IntlPhoneField/phone_number.dart';
import 'package:file_picker/file_picker.dart';
import 'package:turkish_marketer/utils/common_widgets/show_snack_bar.dart';
import 'package:turkish_marketer/utils/routing/navigation_service.dart';
import 'package:turkish_marketer/utils/routing/routes.dart';

import '../../../di.dart';
import '../../../models/drop_down_obj.dart';
import '../../../repositories/registration_info_repository.dart';
import '../../../utils/common_widgets/loading_dialog.dart';

final addCompanyViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  return AddCompanyViewModel();
});

class AddCompanyViewModel extends ChangeNotifier {
  late BuildContext context;

  var phoneTextEditingController = TextEditingController();

  String? selectedCountryCode = "";
  String phoneHintText = "";

  String name = '';
  String email = '';
  String mobile = '';
  String description = "";
  String urlText = '';
  String billingAddress = '';
  String fileName = '';
  String filePath = '';
  String? fileBase64String;

  bool? isNameValid;
  bool? isCompanyTypeValid;
  bool? isEmailValid;
  bool? isPhoneValid;
  bool? isDescriptionValid;
  bool? isUrlTextValid;
  bool? isBillingAddressValid;

  String nameErrorText = '';
  String companyTypeErrorText = '';
  String emailErrorText = '';
  String phoneErrorText = '';
  String descriptionErrorText = '';
  String urlTextErrorText = '';
  String billingAddressTextErrorText = '';

  bool isObscureText = true;
  bool isLoading = false;

  DropdownObj? selectedCompanyType;

  DropdownObj? selectedCountry;

  List<DropdownObj> companiesTypesList = [];

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

  validateUrlText(String value) {
    urlText = value.trim();

    isUrlTextValid = value.isNotEmpty;

    if (isUrlTextValid ?? false) {
      urlTextErrorText = '';
    } else {
      urlTextErrorText = 'website_is_required'.localized();
    }

    notifyListeners();
  }

  validateDescription(String value) {
    description = value.trim();
    isDescriptionValid = value.isNotEmpty;

    if (isDescriptionValid ?? false) {
      descriptionErrorText = '';
    } else {
      descriptionErrorText = 'description_required'.localized();
    }

    notifyListeners();
  }

  validatePhone(PhoneNumber value) async {
    var text = "";
    mobile = value.countryCode + value.number.trim();
    text = value.number.trim();

    isPhoneValid = text.isNotEmpty;
    var isValid = await PhoneNumberUtil.isValidPhoneNumber(text, selectedCountryCode ?? "") ?? false;
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

  validateBillingAddress(String value) async {
    billingAddress = value.trim();
    isBillingAddressValid = value.isNotEmpty;

    if (isBillingAddressValid ?? false) {
      billingAddressTextErrorText = '';
    } else {
      billingAddressTextErrorText = 'billing_address_required'.localized();
    }

    notifyListeners();
  }

  Future<void> picFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['svg', 'jpg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      var file = File(result.files.single.path!);

      fileBase64String = file.toBase64();
      fileName = "${file.path.getFileName()}.${file.path.getFileExtension()}"; // Extracts the file name
      filePath = file.path;
    } else {
      // Handle the case when the user cancels the picker
      showSnackBar('File selection canceled');
    }

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

  setSelectedCompanyType(String? id) {
    selectedCompanyType = companiesTypesList.firstWhereOrNull((p0) => p0.id == id);
    notifyListeners();
  }

  setSelectedCounrty(String? id) {
    selectedCountry = countriesList.firstWhereOrNull((p0) => p0.id == id);
    notifyListeners();
  }

  bool checkValid() {
    return ((isNameValid ?? false) &&
            selectedCompanyType != null &&
            (isDescriptionValid ?? false) &&
            //(isEmailValid ?? false) &&
            (isPhoneValid ?? false) &&
            selectedCountry?.id != null &&
            fileBase64String != null)
        ? true
        : false;
  }

  Future getAddCompnyInfo() async {
    isLoading = true;
    notifyListeners();

    LoadingAlertDialog.show(
      context,
      title: "getSignUpInfo".localized(),
    );

    try {
      final response = await sl<RegistrationInfoRepository>().getAddCompanyInfo();

      countriesList =
          response.result!.countries!.map((e) => DropdownObj(id: "${e.id}", name: e.name, image: e.flag)).toList();
      companiesTypesList =
          response.result!.companyType!.map((e) => DropdownObj(id: "${e.id}", name: e.name, image: e.flag)).toList();
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

  Future addCompanyButton(WidgetRef ref) async {
    if (checkValid()) {
      isLoading = true;
      notifyListeners();

      LoadingAlertDialog.show(
        context,
        title: "addCompany".localized(),
      );

      try {
        final response = await sl<AuthRepository>().addCompany(
          name,
          selectedCompanyType?.id ?? "",
          mobile,
          urlText,
          selectedCountry?.id ?? "",
          billingAddress,
          filePath,
          description,
        );

        if (response.status?.success == true) {
          showSnackBar(response.status?.otherTxt ?? "");
          sl<NavigationService>().navigateToAndRemove(tabBarScreen);
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
