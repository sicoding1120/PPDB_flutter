// ignore_for_file: unused_element

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_project/router/app_router.dart';
import 'package:ppdb_project/service/pendaftaranService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Pendaftaran extends StatefulWidget {
  const Pendaftaran({super.key});

  @override
  State<Pendaftaran> createState() => _PendaftaranState();
}

class _PendaftaranState extends State<Pendaftaran> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController tempatLahirController = TextEditingController();
  DateTime? selectedDate;
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController nisnController = TextEditingController();
  final TextEditingController dokumenController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController brothersController = TextEditingController();
  final TextEditingController childNumberController = TextEditingController();
  final TextEditingController citizenshipController = TextEditingController();
  final TextEditingController fromSchoolController = TextEditingController();
  final TextEditingController taController = TextEditingController();

  String? jenisKelamin;
  String? jenisTest;
  String? major;
  String? religion;
  String? orphanStatus;
  String? bloodType;
  Uint8List? akteBytes,
      kkBytes,
      ktpAyahBytes,
      ktpIbuBytes,
      ijazahBytes,
      fotoBytes;
  String? akteUrl, kkUrl, ktpAyahUrl, ktpIbuUrl, ijazahUrl, fotoUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF24D674)),
          onPressed: () {
            context.go("/home");
          },
        ),
        title: const Text(
          'Pendaftaran',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
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
              _buildInput(namaController, 'Nama Lengkap'),
              const SizedBox(height: 16),
              _buildInput(tempatLahirController, 'Tempat Lahir'),
              const SizedBox(height: 16),
              _buildDateInput(),
              const SizedBox(height: 16),
              _buildInput(nisnController, 'NISN'),
              const SizedBox(height: 16),
              _buildInput(nikController, 'NIK'),
              const SizedBox(height: 16),
              _buildInput(alamatController, 'Alamat'),
              const SizedBox(height: 16),
              _buildInput(phoneController, 'No. HP'),
              const SizedBox(height: 16),
              _buildDropdownJenisKelamin(),
              const SizedBox(height: 16),
              _buildDropdownJenisTest(),
              const SizedBox(height: 16),
              _buildDropdownMajor(),
              const SizedBox(height: 16),
              _buildDropdownReligion(),
              const SizedBox(height: 16),
              _buildDropdownOrphanStatus(),
              const SizedBox(height: 16),
              _buildInput(brothersController, 'Jumlah Saudara'),
              const SizedBox(height: 16),
              _buildDropdownBloodType(),
              const SizedBox(height: 16),
              _buildInput(childNumberController, 'Anak ke-berapa'),
              const SizedBox(height: 16),
              _buildInput(citizenshipController, 'Kewarganegaraan'),
              const SizedBox(height: 16),
              _buildInput(fromSchoolController, 'Asal Sekolah'),
              const SizedBox(height: 16),
              _buildInput(taController, 'Tahun Ajaran'),
              const SizedBox(height: 16),
              // Tambahkan widget untuk upload foto jika perlu
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
      validator:
          (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
    );
  }

  Widget _buildDateInput() {
    return TextFormField(
      controller: tanggalLahirController,
      readOnly: true,
      decoration: _inputDecoration('Tanggal Lahir'),
      validator:
          (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1990),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          setState(() {
            selectedDate = picked;
            tanggalLahirController.text =
                "${picked.toLocal()}".split(' ')[0]; // yyyy-MM-dd
          });
        }
      },
    );
  }

  Widget _buildDropdownJenisKelamin() {
    return DropdownButtonFormField<String>(
      value: jenisKelamin,
      decoration: _inputDecoration('Jenis Kelamin'),
      items: const [
        DropdownMenuItem(value: 'LK', child: Text('Laki-laki')),
        DropdownMenuItem(value: 'PR', child: Text('Perempuan')),
      ],
      onChanged: (value) {
        setState(() {
          jenisKelamin = value;
        });
      },
      validator:
          (value) => value == null || value.isEmpty ? 'Wajib dipilih' : null,
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
      validator:
          (value) => value == null || value.isEmpty ? 'Wajib dipilih' : null,
    );
  }

  Widget _buildDropdownMajor() {
    return DropdownButtonFormField<String>(
      value: major,
      decoration: _inputDecoration('Jurusan'),
      items: const [
        DropdownMenuItem(value: 'TKJ', child: Text('TKJ')),
        DropdownMenuItem(value: 'RPL', child: Text('RPL')),
      ],
      onChanged: (value) {
        setState(() {
          major = value;
        });
      },
      validator:
          (value) => value == null || value.isEmpty ? 'Wajib dipilih' : null,
    );
  }

  Widget _buildDropdownReligion() {
    return DropdownButtonFormField<String>(
      value: religion,
      decoration: _inputDecoration('Agama'),
      items: const [
        DropdownMenuItem(value: 'ISLAM', child: Text('Islam')),
        DropdownMenuItem(value: 'CHRISTIAN', child: Text('Kristen')),
        DropdownMenuItem(value: 'HINDU', child: Text('Hindu')),
        DropdownMenuItem(value: 'BUDDHIST', child: Text('Buddha')),
        DropdownMenuItem(value: 'CONFUCIAN', child: Text('Konghucu')),
      ],
      onChanged: (value) {
        setState(() {
          religion = value;
        });
      },
      validator:
          (value) => value == null || value.isEmpty ? 'Wajib dipilih' : null,
    );
  }

  Widget _buildDropdownOrphanStatus() {
    return DropdownButtonFormField<String>(
      value: orphanStatus,
      decoration: _inputDecoration('Status Yatim Piatu'),
      items: const [
        DropdownMenuItem(value: 'YATIM', child: Text('Yatim')),
        DropdownMenuItem(value: 'PIATU', child: Text('Piatu')),
        DropdownMenuItem(value: 'YATIMPIATU', child: Text('Yatim Piatu')),
        DropdownMenuItem(value: 'NONE', child: Text('Tidak')),
      ],
      onChanged: (value) {
        setState(() {
          orphanStatus = value;
        });
      },
      validator:
          (value) => value == null || value.isEmpty ? 'Wajib dipilih' : null,
    );
  }

  Widget _buildDropdownBloodType() {
    return DropdownButtonFormField<String>(
      value: bloodType,
      decoration: _inputDecoration('Golongan Darah'),
      items: const [
        DropdownMenuItem(value: 'A', child: Text('A')),
        DropdownMenuItem(value: 'B', child: Text('B')),
        DropdownMenuItem(value: 'AB', child: Text('AB')),
        DropdownMenuItem(value: 'O', child: Text('O')),
      ],
      onChanged: (value) {
        setState(() {
          bloodType = value;
        });
      },
      validator:
          (value) => value == null || value.isEmpty ? 'Wajib dipilih' : null,
    );
  }

  Widget _buildButtonKirim() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        // ...existing code...
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          final documentID = prefs.getString('documentID');
          if (documentID == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Silakan login terlebih dahulu!')),
            );
            return;
          }
          if (_formKey.currentState!.validate()) {
            DateTime birthDate = DateTime.parse(tanggalLahirController.text);
            DateTime now = DateTime.now();
            int age = now.year - birthDate.year;
            if (now.month < birthDate.month ||
                (now.month == birthDate.month && now.day < birthDate.day)) {
              age--;
            }
            if (age < 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tanggal lahir tidak valid!')),
              );
              return;
            }

            final data = {
              "fullName": namaController.text,
              "placeOfBirth": tempatLahirController.text,
              "dateOfBirth": tanggalLahirController.text,
              "NISN": nisnController.text,
              "NIK": nikController.text,
              "address": alamatController.text,
              "phone": phoneController.text,
              "gender": jenisKelamin,
              "major": major,
              "religion": religion,
              "orphanStatus": orphanStatus,
              "Brothers": int.tryParse(brothersController.text) ?? 0,
              "blood_type": bloodType,
              "child_number": int.tryParse(childNumberController.text) ?? 0,
              "citizenship": citizenshipController.text,
              "from_school": fromSchoolController.text,
              "documentID": documentID,
              "age": age,
            };
            print('Data yang dikirim: $data');
            try {
              await SiswaService().createStudent(data);
              print('Selesai kirim');
              context.goNamed(myRouter.Home);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Gagal mengirim data: $e')),
              );
            }
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
