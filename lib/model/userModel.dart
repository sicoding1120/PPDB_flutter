// To parse this JSON data, do
//
//     final dataFather = dataFatherFromJson(jsonString);

import 'dart:convert';

DataUser dataFatherFromJson(String str) => DataUser.fromJson(json.decode(str));

String dataFatherToJson(DataUser data) => json.encode(data.toJson());

class DataUser {
    final String? ID;
    final String username;
    final String? email;
    final String password;
    final String? phone;

    DataUser({
        required this.ID,
        required this.username,
        required this.email,
        required this.password,
        required this.phone,
    });

    factory DataUser.fromJson(Map<String, dynamic> json) {
      return DataUser(
        ID: json["ID"] as String?,
        email: json['email'] as String?, // nullable
        phone: json['phone'] as String?, // nullable
        username: json["username"] ?? '', // default empty string jika null
        password: json["password"] ?? '', // default empty string jika null
      );
    }

    Map<String, dynamic> toJson() => {
        "ID": ID,
        "username": username,
        "email": email,
        "password": password,
        "phone": phone,
    };
}
