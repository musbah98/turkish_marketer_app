import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/screens/auth/signup/signup_view_model.dart';

import '../../../utils/app_widgets/app_top_header_image.dart';
import '../../../utils/app_widgets/buttons_widgets/custom_app_back_button.dart';
import '../../../utils/app_widgets/buttons_widgets/custom_app_button.dart';
import '../../../utils/app_widgets/custom_app_bar.dart';

import '../../../utils/app_widgets/text_field_widgets/custom_app_text_field.dart';
import '../../../utils/decoration_and_assets/colors.dart';
import '../../../utils/hide_keyboard_on_tap.dart';

class ChangePaswsordScreen extends ConsumerStatefulWidget {
  const ChangePaswsordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChangePaswsordScreen createState() => _ChangePaswsordScreen();
}

class _ChangePaswsordScreen extends ConsumerState<ChangePaswsordScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final viewModel = ref.read(signupViewModelProvider);

        viewModel.context = context;
        viewModel.changeCountry("TR");
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

    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final signupViewModel = ref.watch(signupViewModelProvider);

          return HideKeyboardOnTap(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    appTopHeaderImage(),
                    Column(
                      children: [
                        customAppBar(
                          title: "change_password".localized(),
                          titleColor: subTitleColor,
                          titleSize: 16,
                          fontWeight: FontWeight.w600,
                          actions: [const SizedBox(width: 56)],
                          leading: customAppBackbutton(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              customAppTextField(
                                autofocus: true,
                                keyboardType: TextInputType.visiblePassword,
                                isObscureText: true,
                                labelText: "old_password".localized(),
                                hintText: "old_password".localized(),
                                onChanged: signupViewModel.validatePassword,
                                errorText: (signupViewModel.isPasswordValid ?? true)
                                    ? null
                                    : signupViewModel.passwordErrorText,
                                helperText: "must_be_at_least_8_characters".localized(),
                              ),
                              const SizedBox(height: 20),
                              customAppTextField(
                                autofocus: true,
                                keyboardType: TextInputType.visiblePassword,
                                isObscureText: true,
                                labelText: "new_password".localized(),
                                hintText: "new_password".localized(),
                                onChanged: signupViewModel.validatePassword,
                                errorText: (signupViewModel.isPasswordValid ?? true)
                                    ? null
                                    : signupViewModel.passwordErrorText,
                                helperText: "must_be_at_least_8_characters".localized(),
                              ),
                              const SizedBox(height: 20),
                              customAppTextField(
                                autofocus: true,
                                keyboardType: TextInputType.visiblePassword,
                                isObscureText: true,
                                labelText: "confirm_password".localized(),
                                hintText: "confirm_password".localized(),
                                onChanged: signupViewModel.validatePassword,
                                errorText: (signupViewModel.isPasswordValid ?? true)
                                    ? null
                                    : signupViewModel.passwordErrorText,
                                helperText: "must_be_at_least_8_characters".localized(),
                              ),
                              const SizedBox(height: 20),
                              customButtonApp(
                                width: double.infinity,
                                text: 'change_password'.localized(),
                                onPressed: () {
                                  // loginViewModel.login();
                                },
                                isDisabled: true,
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
