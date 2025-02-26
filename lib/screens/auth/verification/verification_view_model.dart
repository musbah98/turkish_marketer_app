import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/di.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/repositories/auth_repository.dart';
import 'package:turkish_marketer/utils/common_widgets/show_snack_bar.dart';
import 'package:turkish_marketer/utils/routing/navigation_service.dart';
import 'package:turkish_marketer/utils/routing/routes.dart';

import '../../../utils/common_widgets/loading_dialog.dart';

final verificationViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  return VerificationViewModel();
});

class VerificationViewModel extends ChangeNotifier {
  late BuildContext context;
  String textCode = '';
  //String? activeCode;
  String? email;

  bool isTextCodeValid = false;

  bool isLoading = false;

  validateUserId(String value) {
    textCode = value.trim();

    isTextCodeValid = false;
    if (value.length == 4) {
      isTextCodeValid = true;
    }
    notifyListeners();
  }

  verifyButton() async {
    log(textCode);
    //log(activeCode ?? "null");
    log(email ?? "null");

    // if (textCode != activeCode) {
    //   showSnackBar("incorrect_activation_code".localized());
    //   return;
    // }

    if (isTextCodeValid) {
      isLoading = true;
      notifyListeners();

      LoadingAlertDialog.show(
        context,
        title: "Verify Email".localized(),
      );

      try {
        final response = await sl<AuthRepository>().verifyEmail(textCode);
        if (response.status?.success == true) {
          showSnackBar(response.status?.otherTxt ?? "");
          sl<NavigationService>().navigateTo(addCompanyScreen);
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

  resendActivationCodeButton() async {
    isLoading = true;
    notifyListeners();

    LoadingAlertDialog.show(
      context,
      title: "Resend Activation Code".localized(),
    );

    try {
      final response = await sl<AuthRepository>().resendActivationCode();
      if (response.status?.success == true) {
        showSnackBar(response.status?.otherTxt ?? "");
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
