import 'dart:convert';
import 'package:turkish_marketer/models/lookup_model.dart';

class RegistrationInfoModel {
  List<LookupModel>? countries;
  List<LookupModel>? companyType;
  String? mobileIntro;
  int? countryId;

  RegistrationInfoModel({
    this.countries,
    this.companyType,
    this.mobileIntro,
    this.countryId,
  });

  factory RegistrationInfoModel.fromRawJson(String str) => RegistrationInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegistrationInfoModel.fromJson(dynamic json) => RegistrationInfoModel(
        countries: json["countries"] == null
            ? []
            : List<LookupModel>.from(json["countries"]!.map((x) => LookupModel.fromJson(x))),
        companyType: json["company_type"] == null
            ? []
            : List<LookupModel>.from(json["company_type"]!.map((x) => LookupModel.fromJson(x))),
        mobileIntro: json["mobile_intro"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "countries": countries == null ? [] : List<dynamic>.from(countries!.map((x) => x.toJson())),
        "company_type": companyType == null ? [] : List<dynamic>.from(companyType!.map((x) => x.toJson())),
        "mobile_intro": mobileIntro,
        "country_id": countryId,
      };
}
