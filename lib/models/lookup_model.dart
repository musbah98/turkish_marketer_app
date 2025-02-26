import 'dart:convert';

class LookupModel {
  String? code;
  String? intro;
  String? flag;
  int? id;
  String? name;

  LookupModel({
    this.code,
    this.intro,
    this.flag,
    this.id,
    this.name,
  });

  factory LookupModel.fromRawJson(String str) => LookupModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LookupModel.fromJson(dynamic json) => LookupModel(
        code: json["code"],
        intro: json["intro"],
        flag: json["flag"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "intro": intro,
        "flag": flag,
        "id": id,
        "name": name,
      };
}
