import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PembayaranBSI extends StatefulWidget {
  const PembayaranBSI({super.key});

  @override
  State<PembayaranBSI> createState() => _PembayaranBSIState();
}

class _PembayaranBSIState extends State<PembayaranBSI> {
  final TextEditingController _namaPengirimController = TextEditingController();
  final TextEditingController _namaSiswaController = TextEditingController();
  final TextEditingController _nominalController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Semua field default kosong, jadi tidak perlu assignment di sini
    // _namaPengirimController.text = 'Ibrahim';
    // _namaSiswaController.text = 'Ibrahim';
    // _nominalController.text = '300.000';
    // _keteranganController.text = 'Biaya Pendaftaran';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            context.go("/home");
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Pembayaran BSI',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                'https://res.cloudinary.com/dqbtkdora/image/upload/v1749020987/nvmwych8coywgzxjffrn.png',
                height: 64,
              ),
            ),
            const SizedBox(height: 32),
            _buildLabel("Nama Pengirim"),
            _buildTextField(_namaPengirimController, readOnly: false),
            const SizedBox(height: 18),
            _buildLabel("Nama Siswa"),
            _buildTextField(_namaSiswaController, readOnly: false),
            const SizedBox(height: 18),
            _buildLabel("Nominal Pembayaran"),
            _buildTextField(_nominalController, readOnly: false),
            const SizedBox(height: 18),
            _buildLabel("Keterangan"),
            _buildTextField(_keteranganController, readOnly: false),
            const SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF24D674),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                    context.go('/bsi2', extra: {
                      'namaPengirim': _namaPengirimController.text.trim(),
                      'namaSiswa': _namaSiswaController.text.trim(),
                      'nominal': _nominalController.text.trim(),
                      'keterangan': _keteranganController.text.trim(),
                    });
                },
                child: const Text(
                  'Transfer',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, {
    Color fillColor = Colors.white,
    bool readOnly = false,
  }) {
    final bool isFilled = controller.text.trim().isNotEmpty;
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onChanged: (_) => setState(() {}), // update tampilan saat diisi
      decoration: InputDecoration(
        filled: true,
        fillColor: isFilled ? const Color(0xFF24D674).withOpacity(0.15) : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF24D674)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }
}