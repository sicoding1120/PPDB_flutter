import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ppdb_project/model/studentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiswaService {
  final String baseUrl = 'http://localhost:5000';

  // Ambil semua data siswa (GET)
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

  // Kirim data pendaftaran siswa (POST)
  Future<void> createStudent(Map<String, dynamic> data) async {
    // Ambil documentID dari data, bukan dari SharedPreferences
    final documentID = data['documentID'];
    if (documentID == null) {
      throw Exception('User belum login!');
    }

    final url = Uri.parse('$baseUrl/student/create');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final dataObj = responseData['data'];
      if (dataObj != null && dataObj['ID'] != null) {
        final studentId = dataObj['ID'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('StudentID', studentId.toString());
        print('StudentID saved: $studentId');
      } else {
        print('StudentID null, response: ${response.body}');
      }
    } else {
      print('Gagal daftar siswa: ${response.body}');
    }
  }

  Future createFather(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/parent/create-father');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    print('Status: ${response.statusCode}, Body: ${response.body}');
    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final fatherId = responseData['data']['ID'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('FatherID', fatherId);
      print('FatherID saved: $fatherId');
      return true;
    } else {
      print('Gagal daftar ayah: ${response.body}');
      return false;
    }
  }

  Future createMother(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/parent/create-mother');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    print('Status: ${response.statusCode}, Body: ${response.body}');
    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final motherId = responseData['data']['ID'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('MotherID', motherId);
      print('MotherID saved: $motherId');
      return true;
    } else {
      print('Gagal daftar ibu: ${response.body}');
      return false;
    }
  }
}
