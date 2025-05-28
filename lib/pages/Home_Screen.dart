// ignore_for_file: unused_import, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_project/model/userModel.dart';
import 'package:ppdb_project/router/app_router.dart';

class MyPPDBHomePage extends StatefulWidget {
  const MyPPDBHomePage({super.key});

  @override
  State<MyPPDBHomePage> createState() => _MyPPDBHomePageState();
}

String? imageUrl;

class _MyPPDBHomePageState extends State<MyPPDBHomePage> {
  int _currentCarousel = 0; // Untuk indikator carousel
  int _currentNav = 0; // Untuk menandai menu bottom bar yang aktif

  // Daftar gambar untuk carousel (bisa pakai link dari Cloudinary atau lainnya)
  final List<String> imageList = [
    'https://res.cloudinary.com/dqbtkdora/image/upload/v1748401414/slk5yoaa5waqxyg2rfc7.jpg',
    'https://res.cloudinary.com/dqbtkdora/image/upload/v1748401414/slk5yoaa5waqxyg2rfc7.jpg',
    'https://res.cloudinary.com/dqbtkdora/image/upload/v1748401414/slk5yoaa5waqxyg2rfc7.jpg',
  ];

  // Daftar menu kategori utama
  final List<Map<String, dynamic>> categories = [
    {
      'icon': Icons.school,
      'title': 'Pendaftaran',
      'color': Color(0xFFF50000),
      'route': '/isidataOrtu',
    },
    {
      'icon': Icons.schedule,
      'title': 'Jadwal Test',
      'color': Color(0xFFFCAA09),
      'route': '/jadwal',
    },
    {
      'icon': Icons.bar_chart,
      'title': 'Hasil Test',
      'color': Color(0xFF24D674),
      'route': '/popupHasil',
    },
    {
      'icon': Icons.payment,
      'title': 'Pembayaran',
      'color': Color(0xFF005FD7),
      'route': '/payment',
    },
    {
      'icon': Icons.edit_note,
      'title': 'Test PPDB',
      'color': Color(0xFFFCAA09),
      'route': '/ujian',
    },
    {
      'icon': Icons.upload_file,
      'title': 'Upload File',
      'color': Color(0xFFFF5353),
      'route': '/uploaddoc',
    },
 
  ];

  // Daftar menu bottom navigation bar
  final List<Map<String, dynamic>> bottomNav = [
    {'icon': Icons.home, 'label': 'Home', 'route': '/home'},
    {'icon': Icons.calendar_today, 'label': 'Jadwal', 'route': '/jadwal'},
    {'icon': Icons.support_agent, 'label': 'Customer', 'route': '/customer_service'},
    {'icon': Icons.card_membership, 'label': 'Kartu', 'route': '/KTM'},
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar kosong agar header custom
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: SizedBox.shrink(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(), // Header aplikasi
            const SizedBox(height: 30),
            _buildCarousel(), // Gambar carousel
            _buildCarouselIndicator(), // Indikator carousel
            const SizedBox(height: 20),
            _buildCategoryTitle(), // Judul kategori
            const SizedBox(height: 16),
            _buildCategoryGrid(), // Menu kategori
            const SizedBox(height: 20),
         
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(), // Bottom navigation bar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 4,
        onPressed: () {
          // Navigasi ke halaman profile
          context.go('/profile');
        },
        child: const Icon(Icons.person, color: Color(0xFF24D674), size: 24),
      ),
    );
  }

  // Header aplikasi
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 18),
      decoration: const BoxDecoration(
        color: Color(0xFF24D674),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Foto/logo sekolah
              const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage("https://res.cloudinary.com/dqbtkdora/image/upload/v1747621151/yxjmhkvfpu56xad3lz6c.png"),
              ),
              const SizedBox(width: 10),
              // Nama aplikasi
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'MY',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                    ),
                    TextSpan(
                      text: 'PPDB',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    TextSpan(
                      text: ' SMK',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Tombol notifikasi
          GestureDetector(
            onTap: () {
          
            },
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.notifications, color: Color(0xFF24D674), size: 22),
            ),
          ),
        ],
      ),
    );
  }

  // Carousel gambar
  Widget _buildCarousel() {
    return CarouselSlider(
      items: imageList
          .map((item) => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(item, fit: BoxFit.cover, width: double.infinity),
              ))
          .toList(),
      options: CarouselOptions(
        height: 160,
        autoPlay: true,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          setState(() {
            _currentCarousel = index;
          });
        },
      ),
    );
  }

  // Indikator carousel (titik-titik di bawah gambar)
  Widget _buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imageList.asMap().entries.map((entry) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentCarousel == entry.key ? Colors.green : Colors.grey,
          ),
        );
      }).toList(),
    );
  }

  // Judul kategori
  Widget _buildCategoryTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Text(
          'MyPPDB Category',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Grid menu kategori
  Widget _buildCategoryGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: categories
            .map((cat) => _buildCategory(
                  cat['icon'],
                  cat['title'],
                  cat['color'],
                  () => context.go(cat['route']),
                ))
            .toList(),
      ),
    );
  }

  // Widget untuk satu menu kategori
  Widget _buildCategory(IconData icon, String title, Color color, VoidCallback onTap) {
    // Hanya icon person yang bulat sempurna
    final bool isPerson = icon == Icons.person;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              shape: isPerson ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: isPerson ? null : BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white),
            alignment: Alignment.center,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Bottom navigation bar
  BottomAppBar _buildBottomBar() {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6,
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 2 menu kiri
              ...List.generate(
                2,
                (i) => _navBarItem(i, bottomNav[i]['icon'], bottomNav[i]['label'], bottomNav[i]['route']),
              ),
              const SizedBox(width: 40), // ruang untuk FAB di tengah
              // 2 menu kanan
              ...List.generate(
                2,
                (i) => _navBarItem(i + 2, bottomNav[i + 2]['icon'], bottomNav[i + 2]['label'], bottomNav[i + 2]['route']),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk satu item bottom bar
  Widget _navBarItem(int index, IconData icon, String label, String route) {
    final bool isActive = _currentNav == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentNav = index;
          });
          context.go(route);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFF24D674) : Colors.grey,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isActive ? const Color(0xFF24D674) : Colors.grey,
                fontSize: 11,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}