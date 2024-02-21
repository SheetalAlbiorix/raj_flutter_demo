// To parse this JSON data, do
//
//     final loadCountry = loadCountryFromJson(jsonString);

import 'dart:convert';

List<LoadCountry> loadCountryFromJson(String str) => List<LoadCountry>.from(json.decode(str).map((x) => LoadCountry.fromJson(x)));

String loadCountryToJson(List<LoadCountry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoadCountry {
  String name;
  String dial_code;
  String code;

  LoadCountry({
    required this.name,
    required this.dial_code,
    required this.code,
  });

  factory LoadCountry.fromJson(Map<String, dynamic> json) => LoadCountry(
    name: json["name"],
    dial_code: json["dial_code"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "dial_code": dial_code,
    "code": code,
  };
}
