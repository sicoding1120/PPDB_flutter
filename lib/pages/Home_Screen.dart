// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;
  int? hoveredIndex;

  void _onNavTap(int index) {
    setState(() => currentIndex = index);
    switch (index) {
      case 0:
        context.go("/pendaftaran");
        break;
      case 1:
        break; // Home
      case 2:
        context.go("/profile");
        break;
      case 3:
        context.go("/KTM");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName =
        FirebaseAuth.instance.currentUser?.displayName ?? 'calon siswa';

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: const Color(0xFF24D674),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 60,
                    left: 24,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage("assets/profile.jpg"),
                        ),
                        const SizedBox(width: 12),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            children: [
                              const TextSpan(text: "Hai "),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Text("👋", style: TextStyle(fontSize: 18)),
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
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.notifications,
                          color: Color(0xFF24D674),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Logo
            RichText(
              text: const TextSpan(
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

            const SizedBox(height: 30),

            // Daftar Kegiatan Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                  child:  Text(
                    'Daftar Kegiatan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 108, 108, 108),
                    ),
                  ),

                  ),
                  const SizedBox(height: 25),
                  // Grid 2 baris, 3 kolom
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1,
                    children: [
                      _iconMenu("Pendaftaran", Icons.how_to_reg, () => context.go("/pendaftaran")),
                      _iconMenu("Jadwal Test", Icons.event, () => context.go("/jadwal")),
                      _iconMenu("Hasil Test", Icons.fact_check, () => context.go("/hasil")),
                      _iconMenu("Pembayaran", Icons.payment, () => context.go("/pembayaran")),
                      _iconMenu("Test PPDB", Icons.task_alt, () => context.go("/ujian")),
                      _iconMenu("Upload Dok.", Icons.upload_file, () => context.go("/upload")),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFA726),
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [
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
              _navIcon(0, Icons.sd_card_sharp),
              _navIcon(1, Icons.home),
              _navIcon(2, Icons.person),
              _navIcon(3, Icons.support_agent),
            ],
          ),
        ),
      ),
    );
  }

  // Icon Menu Grid Item
  Widget _iconMenu(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Icon(icon, size: 28, color: const Color(0xFF24D674)),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Bottom Nav Icon Widget
  Widget _navIcon(int index, IconData icon) {
    final isActive = currentIndex == index || hoveredIndex == index;
    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = null),
      child: GestureDetector(
        onTap: () => _onNavTap(index),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.white : Colors.transparent,
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: isActive ? const Color(0xFF24D674) : Colors.white,
          ),
        ),
      ),
    );
  }
}
