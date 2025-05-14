// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3), // Latar belakang abu terang
      body: Column(
        children: [
          // Bagian atas dengan warna hijau
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            decoration: BoxDecoration(
              color: Color(0xFF24D674), // Warna hijau
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(32.0), // Lengkungan bawah
              ),
            ),
            child: Stack(
              children: [
                // Teks "Hai calon siswa 👋"
                Positioned(
                  top: 66.0, // Jarak 66 dari atas
                  left: 24.0, // Jarak dari kiri
                  child: Text(
                    'Hai ${FirebaseAuth.instance.currentUser?.displayName ?? 'calon siswa'} 👋',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Ikon notifikasi
                Positioned(
                  top: 66.0, // Jarak 66 dari atas
                  right: 24.0, // Jarak dari kanan
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Tambahkan logika untuk notifikasi
                      },
                      icon: Icon(
                        Icons.history,
                        color: Color(0xFF24D674), // Warna hijau
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            height: 320, // Tinggi header
          ),
          SizedBox(height: 24),
          // Tombol-tombol menu
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              children: [
                _buildMenuItem(
                  icon: Icons.person_outline,
                  title: 'Pendaftaran Peserta Didik Baru',
                  onTap: () {
                    // Tambahkan logika untuk navigasi
                  },
                ),
                SizedBox(height: 16),
                _buildMenuItem(
                  icon: Icons.schedule,
                  title: 'Jadwal Test',
                  onTap: () {
                    // Tambahkan logika untuk navigasi
                  },
                ),
                SizedBox(height: 16),
                _buildMenuItem(
                  icon: Icons.assignment_outlined,
                  title: 'Hasil Test',
                  onTap: () {
                    // Tambahkan logika untuk navigasi
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF24D674), // Warna hijau
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.account_box), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }

  // Widget untuk item menu
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: Color(0xFF24D674), // Warna hijau
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
