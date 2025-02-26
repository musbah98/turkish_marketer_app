import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/di.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';

import '../../../utils/app_widgets/app_top_header_image.dart';
import '../../../utils/app_widgets/buttons_widgets/custom_app_button.dart';
import '../../../utils/app_widgets/buttons_widgets/custom_app_text_button.dart';
import '../../../utils/app_widgets/text_field_widgets/custom_app_text_field.dart';
import '../../../utils/app_widgets/main_title_with_logo.dart';
import '../../../utils/connectivity_service.dart';
import '../../../utils/hide_keyboard_on_tap.dart';
import '../../../utils/routing/navigation_service.dart';
import '../../../utils/routing/routes.dart';
import 'login_view_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    super.initState();

    //bool checkInternetConnection() {
    var connectivityService = ref.read(connectivityServiceProvider);
    connectivityService.checkInternetConnection();
    //return connectivityService.isConnected;
    // }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(loginViewModelProvider);
      viewModel.context = context;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final loginViewModel = ref.watch(loginViewModelProvider);

          return HideKeyboardOnTap(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        appTopHeaderImage(),
                        SafeArea(
                          top: true,
                          child: Column(
                            children: [
                              mainTitleWithLogo(
                                topPadding: 46,
                                title: "${"welcome_to".localized()} Turkish Marketer",
                                subTitle: "you_can_sign_in_to_system_with_registered_email_password".localized(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 32),
                                    customAppTextField(
                                      autofocus: true,
                                      keyboardType: TextInputType.emailAddress,
                                      labelText: "email".localized(),
                                      hintText: "enter_your_email".localized(),
                                      onChanged: loginViewModel.validateEmail,
                                      errorText:
                                          (loginViewModel.isEmailValid ?? true) ? null : loginViewModel.emailErrorText,
                                    ),
                                    const SizedBox(height: 20),
                                    customAppTextField(
                                      autofocus: true,
                                      keyboardType: TextInputType.visiblePassword,
                                      isObscureText: true,
                                      labelText: "password".localized(),
                                      hintText: "••••••••".localized(),
                                      onChanged: loginViewModel.validatePassword,
                                      errorText: (loginViewModel.isPasswordValid ?? true)
                                          ? null
                                          : 'password_required'.localized(),
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        customTextButtonApp(
                                          onPressed: () {
                                            sl<NavigationService>().navigateTo(webViewApp);
                                          },
                                          text: "forget_password".localized(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    customButtonApp(
                                      width: double.infinity,
                                      text: 'login'.localized(),
                                      onPressed: () {
                                        if (loginViewModel.checkValid()) {
                                          loginViewModel.login(ref);
                                        }
                                      },
                                      isDisabled: !loginViewModel.checkValid(),
                                    ),
                                    const SizedBox(height: 32),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        customTextApp(
                                          text: "dont_have_account".localized(),
                                          size: 14,
                                        ),
                                        const SizedBox(width: 4),
                                        customTextButtonApp(
                                          onPressed: () {
                                            sl<NavigationService>().navigateTo(signupScreen);
                                          },
                                          text: "sign_up".localized(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
