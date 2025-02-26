import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'di.dart';
import 'utils/app_translations/app_translations.dart';
import 'utils/local_repository.dart';
import 'utils/routing/navigation_service.dart';
import 'package:turkish_marketer/utils/routing/router.dart' as router;

import 'utils/routing/routes.dart';

final reloadAppProvider = Provider<VoidCallback>((ref) {
  throw UnimplementedError();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppTranslationsDelegate _appTranslationsDelegate;

  @override
  void initState() {
    super.initState();

    // var connectivityService = context.read(connectivityServiceProvider);
    // connectivityService.checkInternetConnection();

    initLocale();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turkish Marketer',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        _appTranslationsDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
        Locale('ar'),
      ],

      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          // primarySwatch: Colors.deepOrange,
          accentColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        primaryColor: Colors.white,
        fontFamily: "Inter",
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: "Inter",
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleSpacing: 15,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      locale: Locale(sl<LocalRepo>().getLanguage() ?? Platform.localeName),
      // builder: (_, child) {
      //   return Directionality(
      //     textDirection: _appTranslationsDelegate.getLanguageCode() == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      //     child: child!,
      //   );
      // },
      navigatorKey: sl<NavigationService>().navigatorKey,
      initialRoute: preAppScreen,
      onGenerateRoute: router.Router.generateRoute,
    );
  }

  void initLocale() {
    String? lang = sl<LocalRepo>().getLanguage();
    _appTranslationsDelegate = AppTranslationsDelegate(
      locale: lang == null ? null : Locale(lang, ''),
    );
    application.onLocaleChanged = onLocaleChange;
  }

  void onLocaleChange(Locale locale) {
    sl<Dio>().options.headers.addAll({'Content-Language': locale.languageCode});
    setState(
      () {
        _appTranslationsDelegate = AppTranslationsDelegate(locale: locale);
      },
    );
  }
}
