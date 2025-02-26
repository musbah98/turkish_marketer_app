import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/screens/auth/verification/verification_view_model.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_text.dart';

import '../../../utils/app_widgets/buttons_widgets/app_back_button.dart';
import '../../../utils/app_widgets/app_top_header_image.dart';
import '../../../utils/app_widgets/buttons_widgets/custom_app_button.dart';
import '../../../utils/app_widgets/buttons_widgets/custom_app_text_button.dart';
import '../../../utils/app_widgets/main_title_with_logo.dart';
import '../../../utils/decoration_and_assets/colors.dart';
import '../../../utils/decoration_and_assets/images.dart';
import '../../../utils/hide_keyboard_on_tap.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VerificationScreen createState() => _VerificationScreen();
}

class _VerificationScreen extends ConsumerState<VerificationScreen> {
  @override
  void initState() {
    super.initState();
    final viewModel = ref.read(verificationViewModelProvider);
    viewModel.context = context;
  }

  @override
  Widget build(BuildContext context) {
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
            final viewModel = ref.watch(verificationViewModelProvider);

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
                              AppBar(
                                leadingWidth: 80,
                                leading: appBackbutton(),
                                scrolledUnderElevation: 0,
                                elevation: 0.0,
                                backgroundColor: Colors.transparent,
                              ),
                              mainTitleWithLogo(
                                logo: messageIcon,
                                title: "check_your_email".localized(),
                                subTitle: "${"we_sent_verification_link_to".localized()}\n" "${viewModel.email}",
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 32),
                                    VerificationCode(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      itemSize: 64,
                                      fullBorder: true,
                                      textStyle: const TextStyle(
                                        fontSize: 48,
                                        color: redColor1,
                                        fontWeight: FontWeight.w500,
                                        height: 0.8,
                                      ),
                                      keyboardType: TextInputType.number,
                                      underlineColor: redColor1,
                                      underlineUnfocusedColor: redColor1,
                                      underlineWidth: 2,
                                      length: 4,
                                      cursorColor: redColor2,
                                      onCompleted: (String value) {
                                        viewModel.validateUserId(value);
                                      },
                                      onEditing: (bool value) {
                                        viewModel.validateUserId("0");
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    customButtonApp(
                                      width: double.infinity,
                                      text: 'verify_email'.localized(),
                                      onPressed: () {
                                        viewModel.verifyButton();
                                      },
                                      isDisabled: !viewModel.isTextCodeValid,
                                    ),
                                    const SizedBox(height: 32),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        customTextApp(
                                          text: "didnt_receive_email".localized(),
                                          size: 14,
                                        ),
                                        const SizedBox(width: 4),
                                        customTextButtonApp(
                                          onPressed: () {
                                            viewModel.resendActivationCodeButton();
                                          },
                                          text: "click_to_resend".localized(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 32),
                                    customTextButtonApp(
                                      icon: const Icon(Icons.arrow_back),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      color: subTitleColor,
                                      text: "back_to_log_in".localized(),
                                    ),
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
