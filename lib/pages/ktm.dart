// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KTM extends StatefulWidget {
  const KTM({super.key});

  @override
  State<KTM> createState() => _KTMState();
}

class _KTMState extends State<KTM> {
  List<dynamic> studentList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('UserId');
      print('DEBUG userId dari SharedPreferences: $userId');

      final response = await http.get(Uri.parse('http://localhost:5000/student/user/$userId'));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        print('DEBUG body dari backend: $body');

        // Pastikan data adalah List, kalau bukan, buat jadi list satu elemen
        if (body['data'] is List) {
          studentList = body['data'];
        } else if (body['data'] != null) {
          studentList = [body['data']];
        } else {
          studentList = [];
        }
      } else {
        print('Gagal fetch data, status code: ${response.statusCode}');
        studentList = [];
      }
    } catch (e) {
      print('Error saat fetch data: $e');
      studentList = [];
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget _infoBox(String label, String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        '$label $value',
        style: TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }

Widget _buildStudentCard(dynamic student) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 6,
    shadowColor: Colors.grey.shade300,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar & Nama
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.blue.shade100,
                child: Icon(Icons.person, size: 34, color: Colors.blue.shade700),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  student['fullName'] ?? '-',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Info list
          _infoBox('NIK :', student['NIK'] ?? '-'),
          SizedBox(height: 12),
          _infoBox('Jurusan :', student['major'] ?? '-'),
          SizedBox(height: 12),
          _infoBox('Nama Ayah :', student['father']?['name'] ?? '-'),
          SizedBox(height: 12),
          _infoBox('Pekerjaan Ayah :', student['father']?['job'] ?? '-'),
          SizedBox(height: 12),
          _infoBox('Nama Ibu :', student['mother']?['name'] ?? '-'),
          SizedBox(height: 12),
          _infoBox('Pekerjaan Ibu :', student['mother']?['job'] ?? '-'),
        ],
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            context.go('/home');
          },
        ),
        title: Text(
          'Kartu Tanda Mahasiswa',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : studentList.isEmpty
              ? Center(child: Text('Data tidak ditemukan'))
              : ListView.builder(
                  itemCount: studentList.length,
                  itemBuilder: (context, index) {
                    return _buildStudentCard(studentList[index]);
                  },
                ),
    );
  }
}
