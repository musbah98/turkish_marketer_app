import 'dart:io';

import 'package:dio/dio.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:flutter/material.dart';

import '../di.dart';
import '../utils/common_widgets/error_dialog.dart';
import '../utils/routing/navigation_service.dart';

// function is used to print information about a DioError that occurred in a specific method.

//  The function takes two parameters:
//  e: The DioError object representing the error that occurred.
//  callingMethod: A string indicating the name of the method where the error occurred.
void printDioError(DioException e, String callingMethod) {
  debugPrint(
      'DioError in $callingMethod:\ntype: ${e.type.toString()}\nmessage: ${e.message}\nmessage: ${e.response?.data.toString()}');
}

// This method is responsible for handling Dio errors. It checks the type of the
// error and displays an error dialog based on the error type or message.
handleDioError(Exception e) {
  if (e is DioException) {
    if (e.type == DioExceptionType.sendTimeout) {
      showErrorDialog(message: e.message ?? "");
    } else if (e.type == DioExceptionType.badResponse) {
      if (e.response?.data is String) {
        if (e.response?.statusCode == 400) {
          showErrorDialog(
            message: e.response?.data ?? "Error".localized(),
            onOkTap: () {
              sl<NavigationService>().navigateToPrevious();
            },
          );
        } else {
          showErrorDialog(
            message: e.response?.data ?? "Error".localized(),
            onOkTap: () {
              sl<NavigationService>().navigateToPrevious();
            },
          );
        }
      } else if (e.response?.data['error_description'] is String) {
        if (e.response?.data['error'] == "invalid_grant") {
          showErrorDialog(message: "errorPassword".localized());
        } else {
          final errorMessage = e.response?.data['error_description'];
          showErrorDialog(message: errorMessage);
        }
      }
    } else if (e.error is SocketException) {
      var res = e.error as SocketException;
      if (res.osError?.errorCode == 101) {
        showErrorDialog(title: 'error'.localized(), message: "no_internet_connection".localized());

        return;
      }
    } else {
      showErrorDialog(message: e.message ?? "");
    }
  }
}
