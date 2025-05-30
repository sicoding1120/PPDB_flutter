import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:ppdb_project/model/studentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Jadwaltest extends StatefulWidget {
  const Jadwaltest({super.key});

  @override
  State<Jadwaltest> createState() => _JadwaltestState();
}

bool isLoading = true;
DataStudent? dataStudent;
String? namaPeserta;
var StudentData = {};
List<dynamic> studentList = [];

class _JadwaltestState extends State<Jadwaltest> {
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

      // Fetch data student dari backend
      final studentRes = await http.get(
        Uri.parse('http://localhost:5000/student/user/$userId'),
      );
      if (studentRes.statusCode == 200) {
        final data = json.decode(studentRes.body)['data'];
        if (data is List) {
          studentList = data;
        } else if (data is Map) {
          studentList = [data];
        }
      }
    } catch (e) {
      // Handle error
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.go('/home'),
        ),
        title: const Text(
          'Jadwal Tes Seleksi PPDB',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : studentList.isEmpty
              ? Center(
                  child: Text(
                    'Belum ada data peserta.',
                    style: TextStyle(color: Colors.orange, fontSize: 16),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: studentList.map<Widget>((student) {
                        if (student['status'] == 'PASSED') {
                          // Card untuk siswa yang lolos
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 24,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.network(
                                        'https://res.cloudinary.com/dqbtkdora/image/upload/v1747621151/yxjmhkvfpu56xad3lz6c.png',
                                        width: screenWidth * 0.10,
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Arial',
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'MY',
                                              style: TextStyle(color: Colors.orange),
                                            ),
                                            TextSpan(
                                              text: 'PPDB',
                                              style: TextStyle(color: Colors.green),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Kepada Yth Walisantri Dari ${student['fullName']} , Berikut Informasi Untuk jadwal tes Seleksi Ananda:',
                                    style: const TextStyle(fontSize: 16, height: 1.5),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'waktu: 10.00 – 14.00',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Lokasi: SMK MADINATUL QURAN',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Diharapkan Agar ananda datang 30 menit Sebelum test dimulai',
                                    style: TextStyle(fontSize: 16, height: 1.5),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          // Card unik untuk siswa yang belum lolos
                          return Card(
                            color: Colors.orange[50],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 24,
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline, color: Colors.orange, size: 36),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      'Peserta atas nama ${student['fullName']} belum lolos seleksi. Status: ${student['status'] ?? '-'}',
                                      style: const TextStyle(
                                        color: Colors.orange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      }).toList(),
                    ),
                  ),
                ),
    );
  }
}
