// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_project/model/userModel.dart';
import 'package:ppdb_project/router/app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String? imageUrl;

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1; // 0: Daftar, 1: Home, 2: Notif/Profile
  int? hoveredIndex;
  DataUser? userData;

  void _onNavTap(int index) {
    setState(() {
      currentIndex = index;
    });
    if (index == 0) {
      context.go("/pendaftaran");
    } else if (index == 1) {
      // Sudah di Home
    } else if (index == 2) {
      context.go("/profile"); // Pastikan route /profile sudah ada
    } else if (index == 3) {
      context.go("/cs"); // Pastikan route /cs sudah ada
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName =
        FirebaseAuth.instance.currentUser?.displayName ?? userData?.username ?? 'calon siswa';

    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: Column(
        children: [
          // Header hijau
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: Color(0xFF24D674),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 60,
                  left: 24,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage("assets/profile.jpg"),
                      ),
                      SizedBox(width: 12),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(text: "Hai "),
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Text(
                                  "👋",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            TextSpan(text: userName),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 24,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.notifications, color: Color(0xFF24D674)),
                      onPressed: () {
                        context.go("/profile");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Logo MYPPDB
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'MY',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                TextSpan(
                  text: 'PPDB',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF24D674),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Card menu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildCard(
                    image:
                        'https://res.cloudinary.com/dqbtkdora/image/upload/v1747543378/gj4ltfo9iqlrgr3robgu.png',
                    title: 'Pendaftaran Peserta Didik Baru',
                    buttonText: 'Mulai',
                    onTap: () {
                      context.go("/pendaftaran");
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildCard(
                    image:
                        'https://res.cloudinary.com/dqbtkdora/image/upload/v1747543378/your_image_2.png',
                    title: 'Jadwal Test Peserta Didik Baru',
                    buttonText: 'Lihat',
                    onTap: () {
                      context.go("/jadwal");
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildCard(
                    image:
                        'https://res.cloudinary.com/dqbtkdora/image/upload/v1747543378/your_image_3.png',
                    title: 'Hasil Seleksi',
                    buttonText: 'Cek',
                    onTap: () {
                      context.go("/hasil");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Color(0xFFFFA726),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Daftar
              MouseRegion(
                onEnter: (_) => setState(() => hoveredIndex = 0),
                onExit: (_) => setState(() => hoveredIndex = null),
                child: GestureDetector(
                  onTap: () => _onNavTap(0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          (currentIndex == 0 || hoveredIndex == 0)
                              ? Colors.white
                              : Colors.transparent,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.sd_card_sharp,
                      color:
                          (currentIndex == 0 || hoveredIndex == 0)
                              ? Color(0xFF24D674)
                              : Colors.white,
                    ),
                  ),
                ),
              ),
              // Home
              MouseRegion(
                onEnter: (_) => setState(() => hoveredIndex = 1),
                onExit: (_) => setState(() => hoveredIndex = null),
                child: GestureDetector(
                  onTap: () => _onNavTap(1),
                  child: Container(
                    decoration:
                        hoveredIndex == 1
                            ? BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            )
                            : null,
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.home,
                      color:
                          hoveredIndex == 1
                              ? Color(0xFF24D674) // Hijau saat hover
                              : Colors.white, // Putih saat tidak hover
                    ),
                  ),
                ),
              ),
              // Notif/Profile
              MouseRegion(
                onEnter: (_) => setState(() => hoveredIndex = 2),
                onExit: (_) => setState(() => hoveredIndex = null),
                child: GestureDetector(
                  onTap: () => _onNavTap(2),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          (currentIndex == 2 || hoveredIndex == 2)
                              ? Colors.white
                              : Colors.transparent,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.person,
                      color:
                          (currentIndex == 2 || hoveredIndex == 2)
                              ? Color(0xFF24D674)
                              : Colors.white,
                    ),
                  ),
                ),
              ),
              // Customer Service
              MouseRegion(
                onEnter: (_) => setState(() => hoveredIndex = 3),
                onExit: (_) => setState(() => hoveredIndex = null),
                child: GestureDetector(
                  onTap: () => _onNavTap(3),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          (currentIndex == 3 || hoveredIndex == 3)
                              ? Colors.white
                              : Colors.transparent,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.support_agent,
                      color:
                          (currentIndex == 3 || hoveredIndex == 3)
                              ? Color(0xFF24D674)
                              : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String image,
    required String title,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child:
                image.isNotEmpty &&
                            image.startsWith(
                              'https://res.cloudinary.com/dqbtkdora/image/upload/v1747543378/gj4ltfo9iqlrgr3robgu.png',
                            ) ||
                        image.startsWith(
                          'https://res.cloudinary.com/dqbtkdora/image/upload/v1747543378/gj4ltfo9iqlrgr3robgu.png',
                        )
                    ? Image.network(
                      image,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                    : Image.asset(
                      image.isNotEmpty
                          ? image
                          : '', // fallback asset jika kosong
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
          ),

          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF24D674),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: onTap,
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}
