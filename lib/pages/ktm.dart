// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class KTM extends StatefulWidget {
  @override
  _KTMState createState() => _KTMState();
}

class _KTMState extends State<KTM> {
  final Color greenColor = Color(0xFFFCAA09);

  final TextEditingController namaController = TextEditingController(text: 'Ibrahim');
  final TextEditingController nikController = TextEditingController(text: '1234567890123456');
  final TextEditingController prodiController = TextEditingController(text: 'RPL');
  final TextEditingController namaAyahController = TextEditingController(text: 'Budi');
  final TextEditingController namaIbuController = TextEditingController(text: 'Siti');
  final TextEditingController pekerjaanAyahController = TextEditingController(text: 'Guru');
  final TextEditingController pekerjaanIbuController = TextEditingController(text: 'Ibu Rumah Tangga');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Row (Back & Edit Icons)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.blue),
                      onPressed: () {
                        context.go('/home');
                      },
                    ),
          
                  
                    
                  ],
                ),
              ),
          
              // Green Profile Box
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      'Data diri Siswa',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 40, color: Colors.black),
                    ),
                    SizedBox(height: 8),
                    Text(
                      namaController.text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          
              // Form Fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama:"),
                    SizedBox(height: 5),
                    TextField(
                      controller: namaController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("NIK:"),
                    SizedBox(height: 5),
                    TextField(
                      controller: nikController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("Program Studi:"),
                    SizedBox(height: 5),
                    TextField(
                      controller: prodiController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("Nama Ayah:"),
                    SizedBox(height: 5),
                    TextField(
                      controller: namaAyahController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("Nama Ibu:"),
                    SizedBox(height: 5),
                    TextField(
                      controller: namaIbuController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("Pekerjaan Ayah:"),
                    SizedBox(height: 5),
                    TextField(
                      controller: pekerjaanAyahController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("Pekerjaan Ibu:"),
                    SizedBox(height: 5),
                    TextField(
                      controller: pekerjaanIbuController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    // Tambahkan jarak di bawah form
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






