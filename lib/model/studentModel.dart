// To parse this JSON data, do
//
//     final dataStudent = dataStudentFromJson(jsonString);

import 'dart:convert';

DataStudent dataStudentFromJson(String str) => DataStudent.fromJson(json.decode(str));

String dataStudentToJson(DataStudent data) => json.encode(data.toJson());

class DataStudent {
    String id;
    String nisn;
    String nik;
    String fullName;
    String placeOfBirth;
    DateTime dateOfBirth;
    String gender;
    String address;
    String phone;
    String major;
    DateTime dateIn;
    String pictureUrl;
    String religion;
    String status;
    DateTime createdAt;
    String orphanStatus;
    int childNumber;
    int brothers;
    String fromSchool;
    String citizenship;
    String bloodType;
    int age;
    dynamic documentId;
    dynamic userId;
    String motherId;
    String fatherId;

    DataStudent({
        required this.id,
        required this.nisn,
        required this.nik,
        required this.fullName,
        required this.placeOfBirth,
        required this.dateOfBirth,
        required this.gender,
        required this.address,
        required this.phone,
        required this.major,
        required this.dateIn,
        required this.pictureUrl,
        required this.religion,
        required this.status,
        required this.createdAt,
        required this.orphanStatus,
        required this.childNumber,
        required this.brothers,
        required this.fromSchool,
        required this.citizenship,
        required this.bloodType,
        required this.age,
        required this.documentId,
        required this.userId,
        required this.motherId,
        required this.fatherId,
    });

    factory DataStudent.fromJson(Map<String, dynamic> json) => DataStudent(
        id: json["ID"],
        nisn: json["NISN"],
        nik: json["NIK"],
        fullName: json["fullName"],
        placeOfBirth: json["placeOfBirth"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        gender: json["gender"],
        address: json["address"],
        phone: json["phone"],
        major: json["major"],
        dateIn: DateTime.parse(json["dateIn"]),
        pictureUrl: json["picture_url"],
        religion: json["religion"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        orphanStatus: json["orphanStatus"],
        childNumber: json["child_number"],
        brothers: json["Brothers"],
        fromSchool: json["from_school"],
        citizenship: json["citizenship"],
        bloodType: json["blood_type"],
        age: json["age"],
        documentId: json["documentID"],
        userId: json["userID"],
        motherId: json["motherID"],
        fatherId: json["fatherID"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "NISN": nisn,
        "NIK": nik,
        "fullName": fullName,
        "placeOfBirth": placeOfBirth,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "gender": gender,
        "address": address,
        "phone": phone,
        "major": major,
        "dateIn": dateIn.toIso8601String(),
        "picture_url": pictureUrl,
        "religion": religion,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "orphanStatus": orphanStatus,
        "child_number": childNumber,
        "Brothers": brothers,
        "from_school": fromSchool,
        "citizenship": citizenship,
        "blood_type": bloodType,
        "age": age,
        "documentID": documentId,
        "userID": userId,
        "motherID": motherId,
        "fatherID": fatherId,
    };
}
