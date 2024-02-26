// To parse this JSON data, do
//
//     final userDetailModel = userDetailModelFromJson(jsonString);

import 'dart:convert';

List<UserDetailModel> userDetailModelFromJson(String str) =>
    List<UserDetailModel>.from(
        json.decode(str).map((x) => UserDetailModel.fromJson(x)));

String userDetailModelToJson(List<UserDetailModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDetailModel {
  String image;
  String name;
  String designation;
  String loaction;
  String department;
  String email;
  String mobile;

  UserDetailModel({
    required this.image,
    required this.name,
    required this.designation,
    required this.loaction,
    required this.department,
    required this.email,
    required this.mobile,
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
      UserDetailModel(
        image: json["image"],
        name: json["name"],
        designation: json["Designation"],
        loaction: json["Loaction"],
        department: json["Department"],
        email: json["Email"],
        mobile: json["Mobile"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "Designation": designation,
        "Loaction": loaction,
        "Department": department,
        "Email": email,
        "Mobile": mobile,
      };
}
