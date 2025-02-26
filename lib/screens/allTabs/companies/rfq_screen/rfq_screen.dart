import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_bar.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/images.dart';

import '../../../../utils/app_widgets/buttons_widgets/cancel_and_save_buttons_row.dart';
import '../../../../utils/app_widgets/buttons_widgets/custom_app_back_button.dart';
import '../../../../utils/app_widgets/buttons_widgets/switch_with_text_button.dart';
import '../../../../utils/app_widgets/custom_app_text.dart';
import '../../../../utils/app_widgets/text_field_widgets/custom_app_intl_phone_field.dart';
import '../../../../utils/app_widgets/text_field_widgets/custom_app_text_field.dart';
import '../../../../utils/decoration_and_assets/colors.dart';
import 'rfq_view_model.dart';

class RfqScreen extends ConsumerStatefulWidget {
  const RfqScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RfqScreen createState() => _RfqScreen();
}

class _RfqScreen extends ConsumerState<RfqScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final viewModel = ref.read(rfqViewModelProvider);

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
          final viewModel = ref.watch(rfqViewModelProvider);

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      customAppBar(
                        title: "rfq_form".localized(),
                        titleColor: subTitleColor,
                        titleSize: 16,
                        fontWeight: FontWeight.w600,
                        actions: [const SizedBox(width: 56)],
                        leading: customAppBackbutton(),
                      ),
                      const SizedBox(height: 28),
                      customTextApp(
                        text: "share_where_you_worked_on_your_profile".localized(),
                        fontWeight: FontWeight.bold,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            const SizedBox(height: 32),
                            customAppTextField(
                              autofocus: true,
                              keyboardType: TextInputType.emailAddress,
                              labelText: "company_name".localized(),
                              hintText: "company_name".localized(),
                              onChanged: viewModel.validateName,
                              errorText: viewModel.isNameValid ? null : viewModel.nameErrorText,
                            ),
                            const SizedBox(height: 20),
                            customAppIntlPhoneField(
                              textController: viewModel.phoneTextEditingController,
                              initialCountryCode: viewModel.selectedCountryCode,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9]'),
                                ),
                                LengthLimitingTextInputFormatter(28),
                                PhoneNumberTextInputFormatter(),
                              ],
                              autofocus: true,
                              labelText: "phone_number".localized(),
                              hintText: viewModel.phoneHintText,
                              onChanged: (phone) {
                                viewModel.validatePhone(phone);
                              },
                              onCountryChanged: (country) {
                                viewModel.changeCountry(country.code);
                              },
                              errorText: viewModel.isPhoneValid ? null : viewModel.phoneErrorText,
                            ),
                            const SizedBox(height: 20),
                            customAppTextField(
                              autofocus: true,
                              keyboardType: TextInputType.emailAddress,
                              labelText: "subject".localized(),
                              hintText: "subject".localized(),
                              onChanged: viewModel.validateSubject,
                              errorText: viewModel.isSubjectValid ? null : viewModel.subjectErrorText,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: viewModel.isSubjectValid ? 128 : 152,
                              child: customAppTextField(
                                //autofocus: true,
                                isExpand: true,
                                labelText: "description".localized(),
                                hintText: "enter_description".localized(),
                                //onChanged: addCompanyViewModel.validateEmail,
                              ),
                            ),
                            const SizedBox(height: 12),
                            switchWithTextButton(
                              text: 'i_hereby_consent_to_processing_of_personal_data'.localized(),
                              value: viewModel.isAgree,
                              onChanged: viewModel.changeIsAgree,
                            ),
                            const SizedBox(height: 24),
                            GestureDetector(
                              onTap: viewModel.picFile,
                              child: uploadButton(fileName: viewModel.filePath),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              cancelAndSaveButtonsRow(
                padding: 16,
                textSaveButton: "send".localized(),
                onPressedSave: () {},
                onPressedCancel: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

uploadButton({String? fileName}) => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: redColor1, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              uploadeBoxIcon,
            ),
            const SizedBox(height: 12),
            customTextApp(
              text: "click_to_upload".localized(),
              size: 14,
              color: redColor1,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 4),
            customTextApp(
              text: fileName ?? "PDF, PNG, JPG or GIF (max. 800x400px)",
              size: 12,
              color: subTitleColor,
            ),
          ],
        ),
      ),
    );
