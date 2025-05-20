import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KTM extends StatelessWidget {
  final String nama = 'Ibrahim';
  final String nim = '1234567890';
  final String prodi = 'RPL';
  final String namabapak = 'agus';
  final String namaibu = 'mawar';
  final String pekerjaanayah = 'dosen';
  final String pekerjaanibu = 'ibu rumah tangga';



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
      body: Padding(
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
            _infoBox('Nama :', nama),
            SizedBox(height: 12),
            _infoBox('NIM :', nim),
            SizedBox(height: 12),
            _infoBox('Program Studi :', prodi),
           SizedBox(height: 12),
            _infoBox('Nama Ayah :', namabapak),
             SizedBox(height: 12),
            _infoBox('Nama Ibu :', namaibu),
             SizedBox(height: 12),
            _infoBox('Pekerjaan Ayah :', pekerjaanayah),
             SizedBox(height: 12),
            _infoBox('Pekerjaan Ibu :', pekerjaanibu),
            SizedBox(height: 20),
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