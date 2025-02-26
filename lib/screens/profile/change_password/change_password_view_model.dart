import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:turkish_marketer/extentions.dart';

final changePasswordViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  return ChangePasswordViewModel();
});

class ChangePasswordViewModel extends ChangeNotifier {
  late BuildContext context;

  var oldTextEditingController = TextEditingController();
  var newTextEditingController = TextEditingController();
  var confirmTextEditingController = TextEditingController();

  String oldPassword = '';
  String newPassword = '';
  String confirmPassword = '';

  bool isOldPasswordValid = true;
  bool isNewPasswordValid = true;
  bool isConfirmPasswordValid = true;

  String oldPasswordErrorText = '';
  String newPasswordErrorText = '';
  String confirmPasswordErrorText = '';

  bool isObscureText = true;
  bool isLoading = false;

  validateName(String value) {
    oldPassword = value.trim();
    isOldPasswordValid = value.isNotEmpty;

    if (isOldPasswordValid) {
      oldPasswordErrorText = '';
    } else {
      oldPasswordErrorText = 'old_assword_required'.localized();
    }

    notifyListeners();
  }

  validateEmail(String value) {
    newPassword = value.trim();
    isNewPasswordValid = value.isNotEmpty;

    if (isNewPasswordValid) {
      newPasswordErrorText = '';
    } else {
      newPasswordErrorText = 'new_password_required'.localized();
    }

    notifyListeners();
  }

  validatePassword(String value) {
    confirmPassword = value.trim();
    isConfirmPasswordValid = value.isNotEmpty;

    if (isConfirmPasswordValid) {
      confirmPasswordErrorText = '';
    } else {
      confirmPasswordErrorText = 'confirm_password_required'.localized();
    }

    notifyListeners();
  }
}
