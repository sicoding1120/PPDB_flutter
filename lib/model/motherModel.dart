// To parse this JSON data, do
//
//     final dataMother = dataMotherFromJson(jsonString);

import 'dart:convert';

DataMother dataMotherFromJson(String str) => DataMother.fromJson(json.decode(str));

String dataMotherToJson(DataMother data) => json.encode(data.toJson());

class DataMother {
    String id;
    String name;
    String job;
    String phone;
    String address;
    String religion;
    String placeOfBirth;
    DateTime dateOfBirth;
    String status;
    String education;
    String title;
    String citizenship;

    DataMother({
        required this.id,
        required this.name,
        required this.job,
        required this.phone,
        required this.address,
        required this.religion,
        required this.placeOfBirth,
        required this.dateOfBirth,
        required this.status,
        required this.education,
        required this.title,
        required this.citizenship,
    });

    factory DataMother.fromJson(Map<String, dynamic> json) => DataMother(
        id: json["ID"],
        name: json["name"],
        job: json["job"],
        phone: json["phone"],
        address: json["address"],
        religion: json["religion"],
        placeOfBirth: json["placeOfBirth"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        status: json["status"],
        education: json["education"],
        title: json["title"],
        citizenship: json["citizenship"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "name": name,
        "job": job,
        "phone": phone,
        "address": address,
        "religion": religion,
        "placeOfBirth": placeOfBirth,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "status": status,
        "education": education,
        "title": title,
        "citizenship": citizenship,
    };
}
