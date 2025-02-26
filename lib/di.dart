import 'dart:async';
import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/repositories/lookup_repository.dart';
import 'package:turkish_marketer/repositories/registration_info_repository.dart';
import 'api_service/api_service.dart';
import 'environment.dart';
import 'repositories/auth_repository.dart';
import 'utils/common_widgets/error_dialog.dart';
import 'utils/local_repository.dart';
import 'utils/routing/navigation_service.dart';

/*
   This code represents the initialization and dependency injection setup for a Flutter application using the GetIt package.
   It registers and configures various singletons and dependencies for the application. 
 */

// sl and Env: sl is an instance of the GetIt service locator.
// Env is an enumeration that represents the running environment of the application.
final sl = GetIt.instance;
const Env runningEnvironment = Env.stage;

// This method is responsible for initializing the application's
// dependencies and configuring the service locator.
Future<void> init() async {
  //await Connectivity().checkConnectivity();

  sl.registerLazySingleton<LocalRepo>(
    () => LocalRepo(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<Environment>(() => Environment(runningEnvironment));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //  Creates a Dio client instance with the desired configuration and registers it as a lazy singleton.
  // interceptor for the Dio client that handles responses.
  // If the response indicates an unauthenticated status (status code 401),
  // it sets permit to false. However,
  // the code related to showing an error dialog and navigating to an unauthenticated route is currently commented out.
  Dio client = Dio(
    BaseOptions(
      baseUrl: sl<Environment>().baseURL,
      headers: sl<Environment>().headers,
      contentType: 'application/json',
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
    ),
  );
  client.interceptors.add(
    InterceptorsWrapper(
      onResponse: (response, handler) {
        bool permit = true;

        if (response.data != null) {
          if (response.data is Map<String, dynamic>) {
            Map<String, dynamic> res = response.data;
            if (res.containsKey('status')) {
              res = res['status'];
            }

            if (res["showMessage"] == true) {
              showErrorDialog(message: res["otherTxt"] ?? "");
            }

            if (res['messageCode'].toString() == '401') {
              permit = false;
              if (sl<NavigationService>().getParentName() != 'unauthenticated') {
                showErrorDialog(
                  title: 'Error'.localized(),
                  message: 'unauthenticated'.localized(),
                  onOkTap: () => {},
                  //routeSettings: const RouteSettings(name: 'unauthenticated'),
                );
              }
            }
          } else if (response.data is List<dynamic>) {
            //List<dynamic> res = response.data;
          }
        }

        if (permit) {
          handler.next(response);
        }
      },
      onError: (e, handler) {
        handler.next(e);
        return;
      },
    ),
  );

  sl.registerLazySingleton<Dio>(() => client);

  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(
        apiService: ApiService(dio: client),
      ));

  sl.registerLazySingleton<LookupRepository>(() => LookupRepository(
        apiService: ApiService(dio: client),
      ));

  sl.registerLazySingleton<RegistrationInfoRepository>(() => RegistrationInfoRepository(
        apiService: ApiService(dio: client),
      ));

  sl.registerLazySingleton(() => NavigationService());

  //refreshToken();
}

// This method is responsible for resetting specific singletons. However, in the provided code,
// the reset calls are commented out, so the method doesn't perform any actions.
void reset() {
  // sl.resetLazySingleton<inquiryViewModelProvider>();
  // sl.resetLazySingleton<AuthProvider>();
  // sl.resetLazySingleton<HomeProvider>();

  // sl.resetLazySingleton<ContactUsProvider>();
}
