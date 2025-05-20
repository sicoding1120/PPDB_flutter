import 'package:flutter/material.dart';

class KTM extends StatefulWidget {
  const KTM({super.key});

  @override
  State<KTM> createState() => _KTMState();
}

class _KTMState extends State<KTM> {
  // Contoh data siswa, bisa diganti dengan data dari backend/database
  final String nama = 'Ibrahim';
  final String nisn = '1234567890';
  final String kelas = 'XII IPA 1';
  final String alamat = 'Jl. Pendidikan No. 123, Bandung';
  final String sekolah = 'SMK MADINATUL QURAN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Kartu Tanda Siswa',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 340,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              border: Border.all(color: Colors.blue.shade100, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo sekolah
                Image.asset(
                  'assets/logo_sekolah.png',
                  height: 60,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.school, size: 60, color: Colors.blue),
                ),
                SizedBox(height: 12),
                Text(
                  sekolah,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue[900],
                  ),
                  textAlign: TextAlign.center,
                ),
                Divider(height: 28, thickness: 1.2),
                // Foto siswa
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 50, color: Colors.black),
                ),
                SizedBox(height: 18),
                _infoRow('Nama', nama),
                _infoRow('NISN', nisn),
                _infoRow('Kelas', kelas),
                _infoRow('Alamat', alamat),
                SizedBox(height: 18),
                Divider(thickness: 1),
                SizedBox(height: 8),
                Text(
                  'Kartu ini adalah identitas resmi siswa\nHarap dijaga dan dibawa saat di sekolah',
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              '$label',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          Text(
            ': ',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}