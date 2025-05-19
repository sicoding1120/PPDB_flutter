import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image_picker_web/image_picker_web.dart';

class UploadService {
  // Ganti dengan cloud_name dan upload_preset Cloudinary Anda
  final String cloudName = 'YOUR_CLOUD_NAME';
  final String uploadPreset = 'YOUR_UPLOAD_PRESET';

  Future<String?> uploadPhoto() async {
    // Ambil gambar dari user (web)
    Uint8List? bytes = await ImagePickerWeb.getImageAsBytes();
    if (bytes == null) return null;

    final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(http.MultipartFile.fromBytes('file', bytes, filename: 'upload.jpg'));

    final response = await request.send();
    if (response.statusCode == 200) {
      final resStr = await response.stream.bytesToString();
      final data = json.decode(resStr);
      return data['secure_url']; // URL foto di Cloudinary
    } else {
      return null;
    }
  }
}