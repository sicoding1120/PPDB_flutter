import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_project/router/app_router.dart';

class Qris1 extends StatefulWidget {
  const Qris1({super.key});

  @override
  State<Qris1> createState() => _Qris1State();
}

class _Qris1State extends State<Qris1> {
  final Color greenColor = const Color(0xFF24D674);

  final String backgroundImageUrl =
      'https://res.cloudinary.com/dqbtkdora/image/upload/v1749024329/qisvobyfss4vrsednwrz.png';

  final String qrisLogo =
      'https://res.cloudinary.com/dqbtkdora/image/upload/v1749021321/plsldxz8iuya9ci2epmr.png';

  final String sekolahLogo =
      'https://res.cloudinary.com/dqbtkdora/image/upload/v1747621151/yxjmhkvfpu56xad3lz6c.png';

  final String qrImage =
      'https://api.qrserver.com/v1/create-qr-code/?data=PPDB&size=200x200';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          "Pembayaran QRIS",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image dengan overlay agar tidak terlalu terang
          Positioned.fill(
            child: Stack(
              children: [
                Image.network(
                  backgroundImageUrl,
                  fit: BoxFit.cover,
                  width: size.width,
                  height: size.height,
                  alignment: Alignment.center,
                  errorBuilder: (c, e, s) => Container(color: Colors.grey[200]),
                ),
                Container(
                  color: Colors.white.withOpacity(0.7), // overlay agar konten tetap jelas
                ),
              ],
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo dan judul
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(qrisLogo, height: 40),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              "QR Code Standar\nPembayaran Nasional",
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Image.network(sekolahLogo, height: 40),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'PPDB',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 20),
                      // QR Code
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Image.network(
                          qrImage,
                          height: size.width * 0.55,
                          width: size.width * 0.55,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Petunjuk
                      Text(
                        "Tunjukkan QRIS ini ke kasir atau scan dengan aplikasi pembayaran Anda.",
                        style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      // Tombol kembali
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: greenColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            context.goNamed(myRouter.QRIS2); // Ganti dengan rute yang sesuai
                          },
                          icon: const Icon(Icons.arrow_forward_rounded),
                          label: const Text("selanjutnya"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
