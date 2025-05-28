import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final String baseUrl = 'http://localhost:5000';

class UploadService {
  final String cloudName = 'dlnfp5fej';
  final String uploadPreset = 'ppdb_doc';

  Future uploadImage(Uint8List imageBytes) async {
    Uri uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );
    var request =
        http.MultipartRequest('POST', uri)
          ..fields['upload_preset'] = uploadPreset
          ..files.add(
            await http.MultipartFile.fromBytes(
              "file",
              imageBytes,
              filename: "upload.jpg",
            ),
          );

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      print('Your image file is : $responseData');
      final data = jsonDecode(responseData);
      return data;
    } else {
      return null;
    }
  }

  Future saveDocument(Map<String, dynamic> payload) async {
    final url = Uri.parse('$baseUrl/document/save');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final documentId = responseData['data']['ID'];
      final prefs = await SharedPreferences.getInstance();
      if (documentId != null && documentId != ''){
        payload['documentID'] = documentId;
      }
      await prefs.setString('documentID', documentId);
      print('Dokumen berhasil disimpan, dan ID: $documentId');
      return true;
    } else {
      print('Gagal simpan dokumen: ${response.body}');
      return false;
    }
  }
}
