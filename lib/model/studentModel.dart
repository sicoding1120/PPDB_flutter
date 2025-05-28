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
  String dateOfBirth;
  String gender;
  String address;
  String phone;
  String major;
  String? dateIn;
  String? pictureUrl;
  String? religion;
  String academyStatus;
  String createdAt;
  String orphanStatus;
  int? childNumber;
  int? brothers;
  String? ta;
  String fromSchool;
  String? citizenship;
  String? bloodType;
  int age;
  String status;
  String tes;
  String? documentId;
  String? userId;
  String? motherId;
  String? fatherId;

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
    this.dateIn,
    this.pictureUrl,
    this.religion,
    required this.academyStatus,
    required this.createdAt,
    required this.orphanStatus,
    this.childNumber,
    this.brothers,
    this.ta,
    required this.fromSchool,
    this.citizenship,
    this.bloodType,
    required this.age,
    required this.status,
    required this.tes,
    this.documentId,
    this.userId,
    this.motherId,
    this.fatherId,
  });

  factory DataStudent.fromJson(Map<String, dynamic> json) => DataStudent(
    id: json["ID"],
    nisn: json["NISN"],
    nik: json["NIK"],
    fullName: json["fullName"],
    placeOfBirth: json["placeOfBirth"],
    dateOfBirth: json["dateOfBirth"],
    gender: json["gender"],
    address: json["address"],
    phone: json["phone"],
    major: json["major"],
    dateIn: json["dateIn"],
    pictureUrl: json["picture_url"],
    religion: json["religion"],
    academyStatus: json["AcademyStatus"] ?? "ACTIVE",
    createdAt: json["createdAt"],
    orphanStatus: json["orphanStatus"],
    childNumber: json["child_number"],
    brothers: json["Brothers"],
    ta: json["TA"],
    fromSchool: json["from_school"],
    citizenship: json["citizenship"],
    bloodType: json["blood_type"],
    age: json["age"],
    status: json["status"] ?? "PENDING",
    tes: json["tes"] ?? "OFFLINE",
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
    "dateOfBirth": dateOfBirth,
    "gender": gender,
    "address": address,
    "phone": phone,
    "major": major,
    "dateIn": dateIn,
    "picture_url": pictureUrl,
    "religion": religion,
    "AcademyStatus": academyStatus,
    "createdAt": createdAt,
    "orphanStatus": orphanStatus,
    "child_number": childNumber,
    "Brothers": brothers,
    "TA": ta,
    "from_school": fromSchool,
    "citizenship": citizenship,
    "blood_type": bloodType,
    "age": age,
    "status": status,
    "tesType": tes,
    "documentID": documentId,
    "userID": userId,
    "motherID": motherId,
    "fatherID": fatherId,
  };
}
