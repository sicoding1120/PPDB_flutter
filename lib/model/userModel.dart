// To parse this JSON data, do
//
//     final dataFather = dataFatherFromJson(jsonString);

import 'dart:convert';

DataUser dataFatherFromJson(String str) => DataUser.fromJson(json.decode(str));

String dataFatherToJson(DataUser data) => json.encode(data.toJson());

class DataUser {
    String username;
    String email;
    String password;
    String phone;

    DataUser({
        required this.username,
        required this.email,
        required this.password,
        required this.phone,
    });

    factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "phone": phone,
    };
}
