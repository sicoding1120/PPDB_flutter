import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Jadwaltest extends StatefulWidget {
  const Jadwaltest({super.key});
  


  @override
  State<Jadwaltest> createState() => _JadwaltestState();
}

  String? namaPeserta;

class _JadwaltestState extends State<Jadwaltest> {
  @override

  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      namaPeserta = user?.displayName ?? "Peserta";
    });
  }
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Baris logo & teks MYPPDB
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

                    // Teks isi
                    Text(
                      'Kepada Yth Walisantri Dari $namaPeserta , Berikut Informasi Untuk jadwal tes Seleksi Ananda:',
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
            ),
          ),
        ),
      ),
    );
  }
}
