import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ppdb_project/model/fatherModel.dart';
import 'package:ppdb_project/model/motherModel.dart';
import 'package:ppdb_project/model/studentModel.dart';
import 'package:ppdb_project/model/userModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class KTM extends StatefulWidget {
  const KTM({super.key});

  @override
  State<KTM> createState() => _KTMState();
}

class _KTMState extends State<KTM> {
  DataUser? dataUser;
  DataFather? dataFather;
  DataMother? dataMother;
  DataStudent? dataStudent;
  bool isLoading = true;
  var StudentData = {};

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
      final studentId = prefs.getString('ID');
      print('DEBUG userId dari SharedPreferences: $userId');
      print('DEBUG studentId dari SharedPreferences: $studentId');

      // Fetch data student dari backend
      final studentRes = await http.get(Uri.parse('http://localhost:5000/student/user/$userId'));
      if (studentRes.statusCode == 200) {
        print('ok');
        print('body dari BE : ${studentRes.body}');
        StudentData = json.decode(studentRes.body)['data'];
        print(dataStudent);
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
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, size: 60, color: Colors.black),
                  ),
                  SizedBox(height: 30),
                  _infoBox('Nama :', StudentData['fullName'] ?? 'Nama Siswa'),
                  SizedBox(height: 12),
                  _infoBox('NIK :', StudentData['NIK'] ?? 'NIK Siswa'),
                  SizedBox(height: 12),
                  _infoBox('Jurusan :', StudentData['major'] ?? 'Jurusan Siswa'),
                  SizedBox(height: 12),
                  _infoBox('Nama Ayah :', StudentData['father']['name'] ?? 'Nama Ayah'),
                  SizedBox(height: 12),
                  _infoBox('Nama Ibu :', StudentData['mother']['name'] ?? 'Nama Ibu'),
                  SizedBox(height: 12),
                  _infoBox('Pekerjaan Ayah :', StudentData['father']['job'] ?? 'Pekerjaan Ayah'),
                  SizedBox(height: 12),
                  _infoBox('Pekerjaan Ibu :', StudentData['mother']['job'] ?? 'Pekerjaan Ibu'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final userId = prefs.getString('UserId');
                      final studentId = prefs.getString('StudentID');
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('SharedPreferences'),
                          content: Text('UserId: $userId\nStudentID: $studentId\nEee... : $prefs\n dataStudent: $StudentData'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text('Lihat Isi UserId & StudentID'),
                  ),
                ],
              ),
            ),
    );
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
}