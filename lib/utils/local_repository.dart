import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

/*
  The LocalRepo class is responsible for managing local data using the SharedPreferences package.
  It provides methods to set and retrieve various types of data from the shared preferences.
*/

class LocalRepo {
  final SharedPreferences sharedPreferences;

  LocalRepo({required this.sharedPreferences});

  // *****************user************************* //
  static const _userToken = 'userToken';
  Future setUserObject(UserModel user) {
    String userJson = jsonEncode(user);
    return sharedPreferences.setString(_userToken, userJson);
  }

  UserModel? getUserObject() {
    String? user = sharedPreferences.getString(_userToken);
    if (user != null) {
      var map = jsonDecode(user);
      return UserModel.fromJson(map);
    }
    return null;
  }

  void removeUserObject() {
    sharedPreferences.remove(_userToken);
  }
  //****************************************** //

  // *****************languange************************* //
  static const _languange = 'language';
  Future setLanguage(String value) {
    return sharedPreferences.setString(_languange, value);
  }

  String? getLanguage() {
    return sharedPreferences.getString(_languange);
  }
  // ****************************************** //

  // ****************************************** //

  // logout() {
  //   BuildContext context = sl<NavigationService>().getContext();
  //   final filterViewModel = context.read(filterInquiryViewModelProvider);
  //   filterViewModel.reset();
  //   //sl<ApiRepo>().logout();
  //   sl<LocalUserRepo>().removeUserToken();
  //   sl<LocalListsRepo>().removeUserCompanies();

  //   //sl<LocalUserRepo>().removeLoggedUser();
  //   //sl<LocalRepo>().setIsRememberMe(false);
  //   sl<NavigationService>().navigateToAndRemove(preAppScreen);

  //   reset();
  // }
}
