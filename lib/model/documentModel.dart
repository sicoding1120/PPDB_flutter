// To parse this JSON data, do
//
//     final dataDoc = dataDocFromJson(jsonString);

import 'dart:convert';

DataDoc dataDocFromJson(String str) => DataDoc.fromJson(json.decode(str));

String dataDocToJson(DataDoc data) => json.encode(data.toJson());

class DataDoc {
    String akteUrl;
    String familyCardUrl;
    String fatherKtpUrl;
    String motherKtpUrl;
    String ijazahUrl;
    String studentPictureUrl;

    DataDoc({
        required this.akteUrl,
        required this.familyCardUrl,
        required this.fatherKtpUrl,
        required this.motherKtpUrl,
        required this.ijazahUrl,
        required this.studentPictureUrl,
    });

    factory DataDoc.fromJson(Map<String, dynamic> json) => DataDoc(
        akteUrl: json["Akte_url"],
        familyCardUrl: json["familyCard_url"],
        fatherKtpUrl: json["fatherKTP_url"],
        motherKtpUrl: json["motherKTP_url"],
        ijazahUrl: json["Ijazah_url"],
        studentPictureUrl: json["studentPicture_url"],
    );

    Map<String, dynamic> toJson() => {
        "Akte_url": akteUrl,
        "familyCard_url": familyCardUrl,
        "fatherKTP_url": fatherKtpUrl,
        "motherKTP_url": motherKtpUrl,
        "Ijazah_url": ijazahUrl,
        "studentPicture_url": studentPictureUrl,
    };
}
