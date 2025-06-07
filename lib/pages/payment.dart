import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_project/router/app_router.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final TextEditingController _namaPengirimController = TextEditingController();
  final TextEditingController _namaSiswaController = TextEditingController();
  final TextEditingController _nominalController = TextEditingController();

  int _selectedMetode = 0; // 0 = BSI, 1 = QRIS

  final Color primaryColor = const Color(0xFF24D674);

  @override
  void dispose() {
    _namaPengirimController.dispose();
    _namaSiswaController.dispose();
    _nominalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.goNamed(myRouter.Home);
          },
        ),
        title: const Text('Pembayaran'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Nama Pengirim:"),
            _buildTextField(_namaPengirimController, borderColor: primaryColor),

            const SizedBox(height: 12),
            _buildLabel("Nama Siswa:"),
            _buildTextField(_namaSiswaController),

            const SizedBox(height: 12),
            _buildLabel("Nominal Pembayaran:"),
            _buildTextField(_nominalController),

            const SizedBox(height: 24),
            const Center(
              child: Text(
                "Pilih Metode Bayar",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),

            // Metode Pembayaran
            _buildMetodePembayaran(),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Aksi lanjutkan
                  if (_selectedMetode == 0) {
                    print("Metode BSI dipilih");
                    context.goNamed(myRouter.bsi1);
                  } else if (_selectedMetode == 1) {
                    print("Metode QRIS dipilih");
                    context.goNamed(myRouter.QRIS1);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("lanjutkan", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.bold));
  }

  Widget _buildTextField(
    TextEditingController controller, {
    Color borderColor = Colors.grey,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }

  Widget _buildMetodePembayaran() {
    return Column(
      children: [
        _buildMetodeItem(
          imageNetwork:
              'https://res.cloudinary.com/dqbtkdora/image/upload/v1749020987/nvmwych8coywgzxjffrn.png', // Ganti dengan URL Cloudinary
          index: 0,
        ),
        const SizedBox(height: 12),
        _buildMetodeItem(
          imageNetwork:
              'https://res.cloudinary.com/dqbtkdora/image/upload/v1749021321/plsldxz8iuya9ci2epmr.png', // Ganti dengan URL Cloudinary lain jika ada
          index: 1,
        ),
      ],
    );
  }

  Widget _buildMetodeItem({required String imageNetwork, required int index}) {
    final bool isSelected = _selectedMetode == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMetode = index;
          print("Selected Metode: $index");
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.15) : Colors.grey[100],
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.network(
              imageNetwork,
              height: 60,
              width: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 16),
            Expanded(child: Container()),
            Radio<int>(
              value: index,
              groupValue: _selectedMetode,
              activeColor: primaryColor,
              onChanged: (value) {
                setState(() {
                  _selectedMetode = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
