import 'package:flutter/material.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/app_widgets/icon_tag_view.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';
import '../app_widgets/buttons_widgets/custom_app_button.dart';
import '../app_widgets/custom_app_text.dart';
import 'change_language_state.dart';
import '../decoration_and_assets/images.dart';

class ChangeLanguageView extends StatefulWidget {
  const ChangeLanguageView({super.key});

  @override
  State<ChangeLanguageView> createState() => _ChangeLanguageViewState();
}

class _ChangeLanguageViewState extends State<ChangeLanguageView> {
  var languageState = ChangeLanguageState();

  @override
  void initState() {
    super.initState();
    languageState.init();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: 200,
        //padding: const EdgeInsets.symmetric()
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  languageIcon,
                  height: 20,
                ),
                const SizedBox(width: 10),
                customTextApp(text: "select_language".localized()),
              ],
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 6,
              runSpacing: 8,
              children: [
                ...languageState.languagesList.asMap().entries.map(
                      (item) => InkWell(
                        onTap: () {
                          languageState.changeLang(langNumber: item.key);
                        },
                        child: iconTagView(
                          bgColor: item.key == languageState.currentLocale ? redColor1 : Colors.white,
                          textColor: item.key == languageState.currentLocale ? Colors.white : textColor,
                          horizontalPadding: 10,
                          verticalPadding: 4,
                          text: item.value.language ?? "",
                        ),
                      ),
                    ),
                const SizedBox(height: 60),
                Row(
                  children: [
                    Expanded(
                      child: customButtonApp(
                        text: "cancel".localized(),
                        backgroundColor: lightRedColor,
                        textColor: const Color(0xFF912018),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
