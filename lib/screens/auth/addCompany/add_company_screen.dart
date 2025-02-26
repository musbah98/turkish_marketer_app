import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/di.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/screens/auth/addCompany/add_company_view_model.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/dimentions.dart';
import 'package:turkish_marketer/utils/routing/navigation_service.dart';
import 'package:turkish_marketer/utils/routing/routes.dart';

import '../../../utils/app_widgets/buttons_widgets/app_back_button.dart';
import '../../../utils/app_widgets/app_top_header_image.dart';
import '../../../utils/app_widgets/buttons_widgets/cancel_and_save_buttons_row.dart';
import '../../../utils/app_widgets/text_field_widgets/custom_app_intl_phone_field.dart';
import '../../../utils/app_widgets/custom_app_text.dart';
import '../../../utils/app_widgets/text_field_widgets/custom_app_text_field.dart';
import '../../../utils/app_widgets/drop_down_button.dart';
import '../../../utils/app_widgets/main_title_with_logo.dart';
import '../../../utils/decoration_and_assets/colors.dart';
import '../../../utils/decoration_and_assets/images.dart';
import '../../../utils/hide_keyboard_on_tap.dart';

class AddCompanyScreen extends ConsumerStatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddCompanyScreen createState() => _AddCompanyScreen();
}

class _AddCompanyScreen extends ConsumerState<AddCompanyScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final viewModel = ref.read(addCompanyViewModelProvider);

        viewModel.context = context;
        viewModel.getAddCompnyInfo();
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
          final addCompanyViewModel = ref.watch(addCompanyViewModelProvider);
          return HideKeyboardOnTap(
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
                        logo: addCompanyIcon,
                        title: "add_company".localized(),
                        subTitle: "share_where_you_worked_on_your_profile".localized(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 8,
                                spreadRadius: 4,
                                offset: const Offset(0, 9),
                                //blurStyle: BlurStyle.inner,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                const SizedBox(height: 32),
                                customAppTextField(
                                  autofocus: true,
                                  keyboardType: TextInputType.emailAddress,
                                  labelText: "company_type".localized(),
                                  hintText: "what_is_your_title".localized(),
                                  onChanged: addCompanyViewModel.validateName,
                                  errorText: (addCompanyViewModel.isNameValid ?? true)
                                      ? null
                                      : addCompanyViewModel.nameErrorText,
                                ),
                                const SizedBox(height: 20),
                                dropDownButton(
                                  hintText: "select_type".localized(),
                                  items: addCompanyViewModel.companiesTypesList,
                                  selectedItem: addCompanyViewModel.selectedCompanyType?.id,
                                  didSelectItem: (vlaue) {
                                    addCompanyViewModel.setSelectedCompanyType(vlaue);
                                  },
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: (addCompanyViewModel.isEmailValid ?? true) ? 128 : 152,
                                  child: customAppTextField(
                                    //autofocus: true,
                                    isExpand: true,
                                    labelText: "description".localized(),
                                    hintText: "enter_description".localized(),
                                    onChanged: addCompanyViewModel.validateDescription,
                                    errorText: (addCompanyViewModel.isDescriptionValid ?? true)
                                        ? null
                                        : addCompanyViewModel.descriptionErrorText,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                dropDownButton(
                                  hintText: "select_country".localized(),
                                  items: addCompanyViewModel.countriesList,
                                  selectedItem: addCompanyViewModel.selectedCountry?.id,
                                  didSelectItem: (vlaue) {
                                    addCompanyViewModel.setSelectedCounrty(vlaue);
                                  },
                                ),

                                const SizedBox(height: 20),
                                customAppTextField(
                                  autofocus: true,
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.url,
                                  labelText: "website".localized(),
                                  hintText: "www.example.com".localized(),
                                  prefixNewIcon: isRTL() ? null : httpWidget(),
                                  suffixIcon: isRTL() ? httpWidget() : null,
                                  onChanged: addCompanyViewModel.validateUrlText,
                                  errorText: (addCompanyViewModel.isUrlTextValid ?? true)
                                      ? null
                                      : addCompanyViewModel.urlTextErrorText,
                                ),
                                const SizedBox(height: 20),
                                if (addCompanyViewModel.selectedCountryCode != "") ...[
                                  customAppIntlPhoneField(
                                    textController: addCompanyViewModel.phoneTextEditingController,
                                    initialCountryCode: addCompanyViewModel.selectedCountryCode,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Z0-9]'),
                                      ),
                                      LengthLimitingTextInputFormatter(28),
                                      PhoneNumberTextInputFormatter(),
                                    ],
                                    autofocus: true,
                                    labelText: "phone_number".localized(),
                                    hintText: addCompanyViewModel.phoneHintText,
                                    onChanged: (phone) {
                                      addCompanyViewModel.validatePhone(phone);
                                    },
                                    onCountryChanged: (country) {
                                      addCompanyViewModel.changeCountry(country.code);
                                    },
                                    errorText: (addCompanyViewModel.isPhoneValid ?? true)
                                        ? null
                                        : addCompanyViewModel.phoneErrorText,
                                  ),
                                  const SizedBox(height: 20),
                                ],
                                // customAppTextField(
                                //   autofocus: true,
                                //   keyboardType: TextInputType.emailAddress,
                                //   labelText: "email".localized(),
                                //   hintText: "enter_your_email".localized(),
                                //   onChanged: addCompanyViewModel.validateEmail,
                                //   errorText:
                                //       (addCompanyViewModel.isEmailValid ?? true) ? null : addCompanyViewModel.emailErrorText,
                                // ),
                                // const SizedBox(height: 20),
                                customAppTextField(
                                  autofocus: true,
                                  keyboardType: TextInputType.streetAddress,
                                  labelText: "billing_address".localized(),
                                  hintText: "what_is_your_address".localized(),
                                  onChanged: addCompanyViewModel.validateBillingAddress,
                                  errorText: (addCompanyViewModel.isBillingAddressValid ?? true)
                                      ? null
                                      : addCompanyViewModel.billingAddressTextErrorText,
                                ),
                                const SizedBox(height: 20),
                                InkWell(
                                  onTap: addCompanyViewModel.picFile,
                                  child: customAppTextField(
                                    fontSize: 12,
                                    isEnabled: false,
                                    labelText: "company_license_files".localized(),
                                    hintText: addCompanyViewModel.fileName != ""
                                        ? addCompanyViewModel.fileName
                                        : "SVG, PNG, JPG  (max. 800x400px)".localized(),
                                    suffixIcon: uploadButton(context),
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      cancelAndSaveButtonsRow(
                        padding: 16,
                        textCancelButton: "skip_to_home_page".localized(),
                        textSizeCancel: 12,
                        textSaveButton: "add_company".localized(),
                        isDisabledSaveButton: !addCompanyViewModel.checkValid(),
                        onPressedCancel: () {
                          sl<NavigationService>().navigateToAndRemove(tabBarScreen);
                        },
                        onPressedSave: () {
                          addCompanyViewModel.addCompanyButton(ref);
                        },
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget httpWidget() => Container(
      width: 80,
      margin: const EdgeInsets.only(left: 5, right: 10),
      decoration: const BoxDecoration(
          border: Border(
        right: BorderSide(
          color: textBorderColor,
          width: 1,
        ),
      )),
      child: Center(
        child: customTextApp(
          color: subTitleColor,
          text: "https://",
          align: TextAlign.center,
        ),
      ),
    );

Widget uploadButton(BuildContext context) => Container(
      margin: EdgeInsets.only(
        right: isRTL() ? 0 : 10,
        left: isRTL() ? 10 : 0,
        top: 9,
        bottom: 9,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: borderColor,
      ),
      width: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.vertical_align_top,
            size: 16,
            color: textColor,
          ),
          customTextApp(
            text: "upload".localized(),
            size: 12,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
