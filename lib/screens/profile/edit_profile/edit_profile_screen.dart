import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/screens/auth/signup/signup_view_model.dart';

import '../../../utils/app_widgets/app_top_header_image.dart';
import '../../../utils/app_widgets/buttons_widgets/cancel_and_save_buttons_row.dart';
import '../../../utils/app_widgets/buttons_widgets/custom_app_back_button.dart';
import '../../../utils/app_widgets/custom_app_bar.dart';

import '../../../utils/app_widgets/text_field_widgets/custom_app_text_field.dart';
import '../../../utils/app_widgets/drop_down_button.dart';
import '../../../utils/decoration_and_assets/colors.dart';
import '../../../utils/hide_keyboard_on_tap.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileScreen createState() => _EditProfileScreen();
}

class _EditProfileScreen extends ConsumerState<EditProfileScreen> {
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
                              customAppBar(
                                title: "edit_profile".localized(),
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
                                    dropDownButton(
                                      hintText: "select_country".localized(),
                                      items: signupViewModel.countriesList,
                                      selectedItem: signupViewModel.selectedCountry?.id,
                                      didSelectItem: (vlaue) {
                                        signupViewModel.setSelectedCounrty(vlaue);
                                      },
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
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: cancelAndSaveButtonsRow(
                      textSaveButton: "send".localized(),
                      onPressedSave: () {},
                      onPressedCancel: () {
                        Navigator.pop(context);
                      },
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
