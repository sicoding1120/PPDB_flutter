import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class Hasiltest extends StatefulWidget {
  const Hasiltest({super.key});

  @override
  State<Hasiltest> createState() => _HasiltestState();
}

class _HasiltestState extends State<Hasiltest> {
  bool? diterima;
  String? namaPeserta;

  @override
  void initState() {
    super.initState();
    // Simulasi fetch data, bisa diganti dengan fetch dari backend/database
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      diterima = true; // atau false, atau fetch dari database
      namaPeserta = user?.displayName ?? "Peserta";
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Tampilkan loading jika data masih null
    if (diterima == null || namaPeserta == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
          'Hasil Seleksi PPDB',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo dan judul
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

                    // Pesan hasil seleksi
                    Text(
                      diterima!
                          ? 'Selamat! Ananda $namaPeserta dinyatakan DITERIMA sebagai peserta didik baru di SMK MADINATUL QURAN.'
                          : 'Mohon maaf, Ananda $namaPeserta BELUM DITERIMA sebagai peserta didik baru di SMK MADINATUL QURAN.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: diterima! ? Colors.green : Colors.red,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      diterima!
                          ? 'Silakan melakukan daftar ulang sesuai jadwal yang telah ditentukan. Informasi lebih lanjut akan dikirimkan melalui email atau dapat menghubungi panitia PPDB.'
                          : 'Jangan berkecil hati, tetap semangat dan terus berusaha. Informasi lebih lanjut dapat menghubungi panitia PPDB.',
                      style: const TextStyle(fontSize: 16, height: 1.5),
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