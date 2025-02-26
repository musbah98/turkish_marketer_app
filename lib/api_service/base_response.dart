class BaseResponse<T> {
  final dynamic data;
  final T? result;
  final Status? status;
  final String? message;

  BaseResponse({
    this.data,
    this.result,
    this.status,
    this.message,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    dynamic Function(dynamic) create,
  ) {
    T? resultObj;
    if (json.containsKey('result') && json['result'] is Map<String, dynamic>) {
      resultObj = create(json['result']);
    }

    return BaseResponse<T>(
      data: json['data'] != null ? create(json['data']) : null,
      result: resultObj,
      status: Status.fromJson(json['status']),
      message: json['message'],
    );
  }

  // Factory constructor to handle a list of objects (List<T>)
  factory BaseResponse.fromList(
    List<dynamic> jsonList,
    Status status,
    String message,
    dynamic Function(dynamic) fromJson,
  ) {
    List<T> dataList = jsonList.map<T>((item) => fromJson(item as Map<String, dynamic>)).toList();

    return BaseResponse<T>(
      data: dataList,
      status: status,
      message: message,
    );
  }
}

class Status {
  final bool? success;
  final int? messageCode;
  final String? otherTxt;
  final bool? showMessage;

  Status({
    this.success,
    this.messageCode,
    this.otherTxt,
    this.showMessage,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      success: json['success'],
      messageCode: json['messageCode'],
      otherTxt: json['otherTxt'],
      showMessage: json['showMessage'],
    );
  }
}

  // factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJson) {
  //   if (json['data'] is List) {
  //     return BaseResponse(
  //       dataList: List<T>.from((json['data'] as List).map((item) => fromJson(item))),
  //       status: json['status'],
  //       code: json['code'],
  //     );
  //   } else {
  //     return BaseResponse(
  //       data: json['data'] != null ? fromJson(json['data']) : null,
  //       status: json['status'],
  //       code: json['code'],
  //     );
  //   }
  // }
