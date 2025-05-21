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
  Future<bool> createStudent(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('Login');
    if (userJson == null) {
      throw Exception('User belum login!');
    }
    final userMap = jsonDecode(userJson);
    final userId = userMap['ID'];
    final fatherId = prefs.getString('FatherID');
    final motherId = prefs.getString('MotherID');
    data['userID'] = userId;
    data['fatherID'] = fatherId;
    data['motherID'] = motherId;

    final url = Uri.parse('$baseUrl/student/create');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    
    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final studentId = responseData['data']['ID'];
      await prefs.setString('StudentID', studentId);
      print('StudentID saved: $studentId');
      return true;
    } else {
      print('Gagal daftar siswa: ${response.body}');
      return false;
    }
  }

  Future<bool> createFather(Map<String, dynamic> data) async {
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

  Future<bool> createMother(Map<String, dynamic> data) async {
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
