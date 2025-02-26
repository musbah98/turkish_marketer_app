import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/screens/auth/signup/signup_view_model.dart';

import '../../../utils/app_widgets/buttons_widgets/app_back_button.dart';
import '../../../utils/app_widgets/app_top_header_image.dart';
import '../../../utils/app_widgets/buttons_widgets/custom_app_button.dart';
import '../../../utils/app_widgets/text_field_widgets/custom_app_intl_phone_field.dart';
import '../../../utils/app_widgets/custom_app_text.dart';
import '../../../utils/app_widgets/buttons_widgets/custom_app_text_button.dart';
import '../../../utils/app_widgets/text_field_widgets/custom_app_text_field.dart';
import '../../../utils/app_widgets/drop_down_button.dart';
import '../../../utils/app_widgets/main_title_with_logo.dart';
import '../../../utils/hide_keyboard_on_tap.dart';
import 'widgets/clickable_text.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreen createState() => _SignupScreen();
}

class _SignupScreen extends ConsumerState<SignupScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final viewModel = ref.read(signupViewModelProvider);

        viewModel.context = context;
        viewModel.getSignUpInfo();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return HideKeyboardOnTap(
      child: Scaffold(
        body: Consumer(
          builder: (context, ref, _) {
            final signupViewModel = ref.watch(signupViewModelProvider);

            return SafeArea(
              top: false,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          appTopHeaderImage(),
                          Column(
                            children: [
                              //const SizedBox(height: 15),
                              AppBar(
                                leadingWidth: 80,
                                leading: appBackbutton(),
                                scrolledUnderElevation: 0,
                                elevation: 0.0,
                                backgroundColor: Colors.transparent,
                              ),
                              mainTitleWithLogo(
                                title: "sign_up_for_free".localized(),
                                subTitle: "forie_provides_users_to_save_time_resources_with_opportunity".localized(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 32),
                                    customAppTextField(
                                        autofocus: true,
                                        keyboardType: TextInputType.emailAddress,
                                        labelText: "name".localized(),
                                        hintText: "enter_your_name".localized(),
                                        onChanged: signupViewModel.validateName,
                                        errorText: (signupViewModel.isNameValid ?? true)
                                            ? null
                                            : signupViewModel.nameErrorText),
                                    const SizedBox(height: 20),
                                    customAppTextField(
                                      autofocus: true,
                                      keyboardType: TextInputType.emailAddress,
                                      labelText: "email".localized(),
                                      hintText: "enter_your_email".localized(),
                                      onChanged: signupViewModel.validateEmail,
                                      errorText: (signupViewModel.isEmailValid ?? true)
                                          ? null
                                          : signupViewModel.emailErrorText,
                                    ),
                                    const SizedBox(height: 20),
                                    customAppTextField(
                                      autofocus: true,
                                      keyboardType: TextInputType.visiblePassword,
                                      isObscureText: true,
                                      labelText: "password".localized(),
                                      hintText: "create_password".localized(),
                                      onChanged: signupViewModel.validatePassword,
                                      errorText: (signupViewModel.isPasswordValid ?? true)
                                          ? null
                                          : signupViewModel.passwordErrorText,
                                      helperText: "must_be_at_least_8_characters".localized(),
                                    ),
                                    const SizedBox(height: 20),
                                    if (signupViewModel.selectedCountryCode != "") ...[
                                      customAppIntlPhoneField(
                                        textController: signupViewModel.phoneTextEditingController,
                                        initialCountryCode: signupViewModel.selectedCountryCode,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z0-9]'),
                                          ),
                                          LengthLimitingTextInputFormatter(28),
                                          PhoneNumberTextInputFormatter(),
                                        ],
                                        autofocus: true,
                                        labelText: "phone_number".localized(),
                                        hintText: signupViewModel.phoneHintText,
                                        onChanged: (phone) {
                                          signupViewModel.validatePhone(phone);
                                        },
                                        onCountryChanged: (country) {
                                          signupViewModel.changeCountry(country.code);
                                        },
                                        errorText: (signupViewModel.isPhoneValid ?? true)
                                            ? null
                                            : signupViewModel.phoneErrorText,
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                    dropDownButton(
                                      hintText: "select_country".localized(),
                                      items: signupViewModel.countriesList,
                                      selectedItem: signupViewModel.selectedCountry?.id,
                                      didSelectItem: (vlaue) {
                                        signupViewModel.setSelectedCounrty(vlaue);
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    const ClickableText(),
                                    const SizedBox(height: 24),
                                    customButtonApp(
                                      width: double.infinity,
                                      //backgroundColor: signupViewModel.checkValid() ? null : activeButtonColor,
                                      text: 'get_started'.localized(),
                                      onPressed: () {
                                        signupViewModel.signupButton(ref);
                                      },
                                      isDisabled: !signupViewModel.checkValid(),
                                    ),
                                    const SizedBox(height: 32),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        customTextApp(
                                          text: "already_have_account".localized(),
                                          size: 14,
                                        ),
                                        const SizedBox(width: 4),
                                        customTextButtonApp(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          text: "login".localized(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 27),
                                  ],
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
