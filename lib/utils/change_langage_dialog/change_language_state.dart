import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/routing/routes.dart';

import '../../../di.dart';
import '../app_translations/app_translations.dart';
import '../app_translations/language_model.dart';
import '../local_repository.dart';
import '../routing/navigation_service.dart';

class ChangeLanguageState {
  final List<LanguageModel> languagesList = application.supportedLanguages;

  Map<String, dynamic> languagesMap = {};

  int? currentLocale;

  init() {
    for (int index = 0; index < languagesList.length; index++) {
      var item = languagesList[index];
      languagesMap[item.language!] = item.languageCode;

      if (languagesList[index].languageCode == (sl<LocalRepo>().getLanguage() ?? Platform.localeName.split('_')[0])) {
        currentLocale = index;
      }
    }
  }

  changeLang({required int langNumber}) {
    application.onLocaleChanged!(
      Locale(languagesMap[languagesList[langNumber].language]),
    );
    sl<LocalRepo>().setLanguage(languagesMap[languagesList[langNumber].language]);

    currentLocale = langNumber;

    Timer(
      const Duration(milliseconds: 30),
      () {
        sl<NavigationService>().navigateToAndRemove(preAppScreen);
      },
    );
    // sl<NavigationService>().navigateToAndRemove(preAppScreen);
    // PreAappViewModel().navigator(screen: preAppScreen);
    // sl<PreAppProvider>().getMain();
    reset();
  }
}
