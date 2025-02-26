import 'dart:io';

import 'package:turkish_marketer/di.dart';
import 'package:turkish_marketer/utils/local_repository.dart';

import 'api_service/endpoints.dart';

enum Env { production, stage }

class Environment {
  final Env environment;
  late String baseURL;
  late String testUsername;
  late String testUserPass;
  late Map<String, dynamic> headers;

  Environment(this.environment) {
    switch (environment) {
      case Env.production:
        baseURL = Endpoints.url;
        testUsername = 'qq';
        testUserPass = '123@@@aaaAAA';
        headers = {
          'Content-Language': sl<LocalRepo>().getLanguage() ?? Platform.localeName.split('_')[0],
          // 'Accept-Encoding': 'gzip, deflate, br',
          // 'Accept': '*/*',
          // 'Content-Type': 'application/x-www-form-urlencoded',
        };
        break;
      case Env.stage:
        baseURL = Endpoints.url;
        testUsername = 'qq';
        testUserPass = '123@@@aaaAAA';
        headers = {
          'Content-Language': sl<LocalRepo>().getLanguage() ?? Platform.localeName.split('_')[0],
          // 'Accept-Encoding': 'gzip, deflate, br',
          // 'Accept': '*/*',
          // 'Content-Type': 'application/x-www-form-urlencoded',
        };
        break;
    }
  }
}
