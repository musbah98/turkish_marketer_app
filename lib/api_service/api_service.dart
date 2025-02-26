import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:turkish_marketer/api_service/base_response.dart';
import 'package:turkish_marketer/api_service/dio_error_printer.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/common_widgets/show_snack_bar.dart';
import 'package:turkish_marketer/utils/connectivity_service.dart';

import '../di.dart';
import '../utils/routing/navigation_service.dart';

class ApiService<T> {
  final Dio dio;

  late BuildContext context;
  late ConnectivityService connectivityService;

  ApiService({required this.dio}) {
    context = sl<NavigationService>().getContext();
    connectivityService = context.read(connectivityServiceProvider);
  }

  bool checkInternetConnection() {
    return connectivityService.isConnected;
  }

  Future<BaseResponse<T>> postData(String endpoint, Map<String, dynamic> data, T Function(dynamic) fromJson) async {
    if (!checkInternetConnection()) {
      showSnackBar("No internet connection");

      throw Exception('No internet connection');
    }

    try {
      final response = await dio.post(
        endpoint,
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      BaseResponse<T> dataResponse;

      if (response.data["data"] is List) {
        dataResponse = BaseResponse<T>.fromList(
          response.data["data"],
          Status.fromJson(response.data['status']),
          response.data['message'] ?? '',
          fromJson,
        );
      } else {
        dataResponse = BaseResponse<T>.fromJson(response.data, fromJson);
      }

      return dataResponse;
    } on DioException catch (e) {
      printDioError(e, "postData");
      throw Exception("Failed to post data: ${e.message}");
    }
  }

  Future<BaseResponse<T>> postWithImage(
    String endpoint,
    Map<String, dynamic> data,
    String imageKey,
    String imagePath,
    dynamic Function(dynamic) fromJson,
  ) async {
    if (!checkInternetConnection()) {
      showSnackBar("No internet connection");

      throw Exception('No internet connection');
    }

    try {
      FormData formData = FormData.fromMap({
        ...data,
        imageKey: await MultipartFile.fromFile(imagePath),
      });
      final response = await dio.post(endpoint, data: formData);

      if (response.data["data"] is List) {
        return BaseResponse<T>.fromList(
          response.data["data"],
          Status.fromJson(response.data['status']),
          response.data['message'] ?? '',
          fromJson,
        );
      } else {
        return BaseResponse<T>.fromJson(response.data, fromJson);
      }

      //return fromJsonToBaseResponse(response, fromJson);
    } on DioException catch (e) {
      printDioError(e, "postWithImage");
      throw Exception("Failed to upload image: ${e.message}");
    }
  }

  Future<BaseResponse<T>> fetchData(
    String endpoint,
    dynamic Function(dynamic) fromJson, {
    Map<String, dynamic>? data,
  }) async {
    if (!checkInternetConnection()) {
      showSnackBar("No internet connection");
      throw Exception('No internet connection');
    }

    try {
      final response = await dio.get(endpoint, queryParameters: data);

      // Debug: Print the raw response
      print('Raw response data: ${response.data}');

      if (response.data["data"] is List) {
        return BaseResponse<T>.fromList(
          response.data["data"],
          Status.fromJson(response.data['status']),
          response.data['message'] ?? '',
          fromJson,
        );
      } else {
        return BaseResponse<T>.fromJson(response.data, fromJson);
      }
    } on DioException catch (e) {
      printDioError(e, "fetchData");
      print(e.error);
      throw Exception("Failed to fetch data: ${e.message}");
    }
  }
}
