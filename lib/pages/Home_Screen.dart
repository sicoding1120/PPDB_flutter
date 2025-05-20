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
        context.go("/KTM");
        break;
      case 1:
        break;
      case 2:
        context.go("/profile");
        break;
      case 3:
        context.go("/");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName = FirebaseAuth.instance.currentUser?.displayName ?? 'calon siswa';

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(userName),
            const SizedBox(height: 20),
            _buildLogo(),
            const SizedBox(height: 30),
            _buildMenuGrid(),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader(String userName) {
    return Container(
      height: 220,
      decoration: const BoxDecoration(
        color: Color(0xFF24D674),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 60,
            left: 24,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.go("/profile"),
                  child: const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage("assets/profile.jpg"),
                  ),
                ),
                const SizedBox(width: 12),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: IconButton(
                icon: const Icon(Icons.notifications, color: Color(0xFF24D674)),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'MY',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
          ),
          TextSpan(
            text: 'PPDB',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF24D674)),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Daftar Kegiatan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 108, 108, 108)),
            ),
          ),
          const SizedBox(height: 25),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
            children: [
              _iconMenu("Pendaftaran", Icons.how_to_reg, () => context.go("/pendaftaran"),Colors.orange ),
              _iconMenu("Jadwal Test", Icons.event, () => context.go("/jadwal"), Colors.green),
              _iconMenu("Hasil Test", Icons.fact_check, () => context.go("/hasil", ), Colors.lightBlueAccent),
              _iconMenu("Pembayaran", Icons.payment, () => context.go("/pembayaran"), Colors.redAccent),
              _iconMenu("Test PPDB", Icons.task_alt, () => context.go("/ujian"), Colors.indigo),
              _iconMenu("Upload Dok.", Icons.upload_file, () => context.go("/uploaddoc"), Colors.lime),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconMenu(String label, IconData icon, VoidCallback onTap, Color iconColor) {
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
            child: Icon(icon, size: 28, color: iconColor),
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

  Widget _buildBottomNav() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFA726),
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _navBarItem(0, Icons.calendar_view_day, "Kartu tanda siswa"),
            _navBarItem(1, Icons.home, "Home"),
            _navBarItem(3, Icons.support_agent, "Bantuan"),
          ],
        ),
      ),
    );
  }

  Widget _navBarItem(int index, IconData icon, String label) {
    final isActive = currentIndex == index || hoveredIndex == index;
    return Expanded(
      child: MouseRegion(
        onEnter: (_) => setState(() => hoveredIndex = index),
        onExit: (_) => setState(() => hoveredIndex = null),
        child: GestureDetector(
          onTap: () => _onNavTap(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
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
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.white70,
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
