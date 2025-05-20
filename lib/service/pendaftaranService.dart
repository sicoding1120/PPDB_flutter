import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ppdb_project/model/studentModel.dart';


class SiswaService {
  final String baseUrl = 'http://localhost:5000';

  Future<List<DataStudent>> getSiswa() async {
    final response = await http.get(Uri.parse('$baseUrl/student/'));
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List<dynamic> siswaList = decoded['data'];
      return siswaList.map((json) => DataStudent.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}