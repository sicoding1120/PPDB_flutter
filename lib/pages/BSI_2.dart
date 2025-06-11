import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Jika pakai go_router, import juga:
// import 'package:go_router/go_router.dart';

class Bsi2 extends StatelessWidget {
  const Bsi2({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil data dari GoRouter
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>? ?? {};
    final namaPengirim = extra['namaPengirim'] ?? '';
    final namaSiswa = extra['namaSiswa'] ?? '';
    final nominal = extra['nominal'] ?? '';
    final keterangan = extra['keterangan'] ?? '';

    final Color greenColor = const Color(0xFF24D674);

    final String qrImageUrl =
        'https://api.qrserver.com/v1/create-qr-code/?data=PPDB&size=200x200'; // ganti sesuai URL Cloudinary QR Code

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: greenColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.go("/home");
          },
        ),
        title: const Text(
          'hasil pembayaran via BSI',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Nama Pengirim :'),
                      Text(namaPengirim, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Nama Siswa :'),
                      Text(namaSiswa, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Nominal :'),
                      Text(nominal, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Keterangan :'),
                      Text(keterangan, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'transfer pembayaran anda sebelum:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            const Text(
              '1 Juni 2025 14:93:20',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Jumlah yang harus dibayar:',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Rp 900.000',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Mohon transfer sesuai jumlah yang tertera\n(termasuk 3 digit terakhir)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Detail Tagihan'),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
           
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
