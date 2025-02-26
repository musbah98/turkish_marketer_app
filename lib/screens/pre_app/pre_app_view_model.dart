// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../di.dart';
import '../../utils/routing/navigation_service.dart';
import '../../utils/routing/routes.dart';

final preAppViewModelProvider = ChangeNotifierProvider.autoDispose((ref) => PreAppViewModel());

class PreAppViewModel with ChangeNotifier {
  bool refreshTokenLoading = false;
  String? refreshTokenError;

  var isConnected = false;

  void getMain() {
    // refreshTokenLoading = true;
    // refreshTokenError = null;

    runZonedGuarded(
      () async {
        // var user = sl<LocalUserRepo>().getUserToken();
        // //var isRememberMe = sl<LocalRepo>().getIsRememberMe();
        // if (user?.accessToken != null) {
        //   sl<Dio>().options.headers.remove("Authorization");
        //   refreshToken(user!);
        // } else {
        navigator(screen: onBoardingScreen);
        // }
      },
      (e, s) {
        refreshTokenLoading = false;
        notifyListeners();
        // ErrorResponse.handelError(null, e, "refreshAccessToken");
      },
    );
  }

  // void setNewToken(String token) {
  //   User? _user = sl<LocalRepo>().getUser();
  //   if (_user != null) {
  //     _user.data!.accessToken = token;
  //     sl<LocalRepo>().setUser(_user);
  //     refreshToken();
  //   }
  // }

  void navigator({required String screen}) {
    Timer(
      const Duration(seconds: 2),
      () {
        sl<NavigationService>().navigateToAndRemove(screen);
      },
    );
  }
}
