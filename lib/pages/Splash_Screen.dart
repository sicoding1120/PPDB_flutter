import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: Colors.white, // Warna latar belakang putih
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.network(
              'https://res.cloudinary.com/dlnfp5fej/image/upload/v1747108687/klhraf8kl4f82phoz7st.png',
              width: 183,
              height: 183,
            ),
            // SizedBox(height: ), // Jarak antara logo dan teks
            // Teks MYPPDB
            RichText(
              text: TextSpan(
                text: 'MY',
                style: GoogleFonts.monomaniacOne(
                  fontSize: 40,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFFFCAA09), // Warna oranye
                ),
                children: [
                  TextSpan(
                    text: 'PPDB',
                    style: TextStyle(
                      color: Color(0xFF3FA76E), // Warna hijau
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}