import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigasi ke halaman login setelah 3 detik
    Future.delayed(Duration(seconds: 3), () {
      context.go('/login'); // Menggunakan GoRouter untuk navigasi
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2), // Warna latar belakang
      body: Center(
        child: Icon(
          Icons.star, // Ikon bintang
          size: 100.0, // Ukuran ikon
          color: Colors.yellow, // Warna ikon
        ),
      ),
    );
  }
}