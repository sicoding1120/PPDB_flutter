// To parse this JSON data, do
//
//     final dataLogin = dataLoginFromJson(jsonString);

import 'dart:convert';

DataLogin dataLoginFromJson(String str) => DataLogin.fromJson(json.decode(str));

String dataLoginToJson(DataLogin data) => json.encode(data.toJson());

class DataLogin {
    String phone;
    String email;
    String password;

    DataLogin({
        required this.phone,
        required this.email,
        required this.password,
    });

    factory DataLogin.fromJson(Map<String, dynamic> json) => DataLogin(
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
        "email": email,
        "password": password,
    };
}
