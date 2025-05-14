import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Uploaddoc extends StatefulWidget {
  const Uploaddoc({super.key});

  @override
  State<Uploaddoc> createState() => _uploaddocState();
}

class _uploaddocState extends State<Uploaddoc> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController tempatLahirController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController nisnController = TextEditingController();
  final TextEditingController dokumenController = TextEditingController();

  String? jenisKelamin;
  String? jenisTest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            context.go("/home");
          },
        ),
        title: const Text(
          'isi data dokumen',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               _buildUploadField(),
                 const SizedBox(height: 35),
              _buildButtonKirim(),
             
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFDADADA)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF00D084), width: 2),
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(hint),
      validator: (value) =>
          value == null || value.isEmpty ? 'Wajib diisi' : null,
    );
  }

  Widget _buildDropdownJenisKelamin() {
    return DropdownButtonFormField<String>(
      value: jenisKelamin,
      decoration: _inputDecoration('Jenis Kelamin'),
      items: const [
        DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
        DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
      ],
      onChanged: (value) {
        setState(() {
          jenisKelamin = value;
        });
      },
      validator: (value) =>
          value == null || value.isEmpty ? 'Wajib dipilih' : null,
    );
  }

  Widget _buildDropdownJenisTest() {
    return DropdownButtonFormField<String>(
      value: jenisTest,
      decoration: _inputDecoration('Test OFFLINE / ONLINE'),
      items: const [
        DropdownMenuItem(value: 'Offline', child: Text('Offline')),
        DropdownMenuItem(value: 'Online', child: Text('Online')),
      ],
      onChanged: (value) {
        setState(() {
          jenisTest = value;
        });
      },
      validator: (value) =>
          value == null || value.isEmpty ? 'Wajib dipilih' : null,
    );
  }

  Widget _buildUploadField() {
    return TextFormField(
      controller: dokumenController,
      readOnly: true,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fitur upload belum tersedia')),
        );
      },
      decoration: _inputDecoration('Upload Dokumen').copyWith(
        suffixIcon: const Icon(Icons.upload_file),
      ),
    );
  }

  Widget _buildButtonKirim() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Data berhasil dikirim')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          
          backgroundColor: const Color(0xFF00D084), // hijau
          foregroundColor: Colors.white, // teks putih
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(

          'Selanjutnya',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
