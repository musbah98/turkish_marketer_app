import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/repositories/auth_repository.dart';
import 'package:turkish_marketer/screens/auth/verification/verification_view_model.dart';
import 'package:turkish_marketer/utils/routing/navigation_service.dart';
import 'package:turkish_marketer/utils/routing/routes.dart';

import '../../../di.dart';
import '../../../utils/common_widgets/loading_dialog.dart';
import '../../../utils/local_repository.dart';

final loginViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  return LoginViewModel();
});

class LoginViewModel extends ChangeNotifier {
  late BuildContext context;

  //final AuthUseCase _authService = AuthUseCase(ApiService(Dio()));

  bool isLoading = false;
  String? errorMessage;

  String email = '';
  String password = '';

  bool? isEmailValid;
  bool? isPasswordValid;

  String emailErrorText = '';
  String passwordErrorText = '';

  bool isObscureText = true;

  obscureText() {
    isObscureText = !isObscureText;
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
    isPasswordValid = value.isNotEmpty; //&& value.length > 6;

    if (isPasswordValid ?? false) {
      passwordErrorText = '';
    } else {
      passwordErrorText = 'password_required';
    }

    notifyListeners();
  }

  bool checkValid() {
    return ((isEmailValid ?? false) && (isPasswordValid ?? false)) ? true : false;
  }

  Future<void> login(WidgetRef ref) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    LoadingAlertDialog.show(
      context,
      title: "login".localized(),
    );

    try {
      final response = await sl<AuthRepository>().login(email, password);

      if (response.result?.emailVerified == false) {
        var verificationViewModel = ref.watch(verificationViewModelProvider);
        verificationViewModel.email = email;

        sl<LocalRepo>().setUserObject(response.result!);

        sl<Dio>().options.headers.addAll(
          {'Authorization': 'Bearer ${response.result?.token}'},
        );

        sl<NavigationService>().navigateTo(verificationScreen);
      } else if (response.result?.hasCompany == false) {
        sl<NavigationService>().navigateTo(addCompanyScreen);
      } else if (response.status?.success == true) {
        sl<NavigationService>().navigateToAndRemove(tabBarScreen);
      }
    } catch (e) {
      log('errorMessage : ${e.toString()}');
      errorMessage = e.toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
      LoadingAlertDialog.dismiss();
    }
  }
}
