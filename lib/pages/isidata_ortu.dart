// ignore_for_file: unused_element

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_project/router/app_router.dart';
import 'package:ppdb_project/service/pendaftaranService.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ppdb_project/service/uploadService.dart';

class IsidataOrtu extends StatefulWidget {
  const IsidataOrtu({super.key});

  @override
  State<IsidataOrtu> createState() => _IsidataOrtuState();
}

class _IsidataOrtuState extends State<IsidataOrtu> {
  final _formKey = GlobalKey<FormState>();

  // Ayah
  final TextEditingController namaAyahController = TextEditingController();
  final TextEditingController pekerjaanAyahController = TextEditingController();
  final TextEditingController noTelpAyahController = TextEditingController();
  final TextEditingController alamatAyahController = TextEditingController();
  final TextEditingController agamaAyahController = TextEditingController();
  final TextEditingController tempatLahirAyahController = TextEditingController();
  final TextEditingController tanggalLahirAyahController = TextEditingController();
  final TextEditingController statusAyahController = TextEditingController();
  final TextEditingController pendidikanAyahController = TextEditingController();
  final TextEditingController gelarAyahController = TextEditingController();
  final TextEditingController kewarganegaraanAyahController = TextEditingController();

  // Ibu
  final TextEditingController namaIbuController = TextEditingController();
  final TextEditingController pekerjaanIbuController = TextEditingController();
  final TextEditingController noTelpIbuController = TextEditingController();
  final TextEditingController alamatIbuController = TextEditingController();
  final TextEditingController agamaIbuController = TextEditingController();
  final TextEditingController tempatLahirIbuController = TextEditingController();
  final TextEditingController tanggalLahirIbuController = TextEditingController();
  final TextEditingController statusIbuController = TextEditingController();
  final TextEditingController pendidikanIbuController = TextEditingController();
  final TextEditingController gelarIbuController = TextEditingController();
  final TextEditingController kewarganegaraanIbuController = TextEditingController();

  bool isAyah = true; // true = form ayah, false = form ibu

  Uint8List? imageData;
  String? uploadImage;

    Future pilihNupload() async {
    final image = await ImagePickerWeb.getImageAsBytes();
    if (image == null) return;
    setState(() {
      imageData = image;
    });
    final url = await UploadService().uploadImage(image);
    if (url != null) {
      setState(() {
        uploadImage = url['secure_url'] as String?;
      });
    }
  }

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
        title: Text(
          isAyah ? 'Data Ayah' : 'Data Ibu',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: isAyah ? _buildAyahForm() : _buildIbuForm(),
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

Widget _buildInput(TextEditingController controller, String hint, {bool isRequired = false}) {
  return TextFormField(
    controller: controller,
    decoration: _inputDecoration(hint),
    validator: (value) {
      if (isRequired && (value == null || value.isEmpty)) {
        return 'Wajib diisi';
      }
      return null; // Tidak ada error
    },
  );
}


  Widget _buildDateInput(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: _inputDecoration(hint),
      validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          setState(() {
            controller.text = "${picked.toLocal()}".split(' ')[0];
          });
        }
      },
    );
  }

  // Dropdown untuk enum Religion
  Widget _buildDropdownReligion(TextEditingController controller, String label) {
    return DropdownButtonFormField<String>(
      value: controller.text.isNotEmpty ? controller.text : null,
      decoration: _inputDecoration(label),
      items: const [
        DropdownMenuItem(value: 'ISLAM', child: Text('Islam')),
        DropdownMenuItem(value: 'CHRISTIAN', child: Text('Kristen')),
        DropdownMenuItem(value: 'HINDU', child: Text('Hindu')),
        DropdownMenuItem(value: 'BUDDHIST', child: Text('Buddha')),
        DropdownMenuItem(value: 'CONFUCIAN', child: Text('Konghucu')),
      ],
      onChanged: (value) {
        setState(() {
          controller.text = value ?? '';
        });
      },
      validator: (value) => value == null || value.isEmpty ? 'Wajib dipilih' : null,
    );
  }

  // Dropdown untuk enum ParentStatus
  Widget _buildDropdownStatus(TextEditingController controller, String label) {
    return DropdownButtonFormField<String>(
      value: controller.text.isNotEmpty ? controller.text : null,
      decoration: _inputDecoration(label),
      items: const [
        DropdownMenuItem(value: 'ALIVE', child: Text('Masih Hidup')),
        DropdownMenuItem(value: 'DEAD', child: Text('Meninggal')),
      ],
      onChanged: (value) {
        setState(() {
          controller.text = value ?? '';
        });
      },
      validator: (value) => value == null || value.isEmpty ? 'Wajib dipilih' : null,
    );
  }

  List<Widget> _buildAyahForm() {
    return [
      _buildInput(namaAyahController, 'Nama Ayah'),
      const SizedBox(height: 16),
      _buildInput(pekerjaanAyahController, 'Pekerjaan Ayah'),
      const SizedBox(height: 16),
      _buildInput(noTelpAyahController, 'No Telp Ayah'),
      const SizedBox(height: 16),
      _buildInput(alamatAyahController, 'Alamat Ayah'),
      const SizedBox(height: 16),
      _buildDropdownReligion(agamaAyahController, 'Agama Ayah'),
      const SizedBox(height: 16),
      _buildInput(tempatLahirAyahController, 'Tempat Lahir Ayah'),
      const SizedBox(height: 16),
      _buildDateInput(tanggalLahirAyahController, 'Tanggal Lahir Ayah'),
      const SizedBox(height: 16),
      _buildDropdownStatus(statusAyahController, 'Status Ayah'),
      const SizedBox(height: 16),
      _buildInput(pendidikanAyahController, 'Pendidikan Ayah'),
      const SizedBox(height: 16),
      _buildInput(gelarAyahController, 'Gelar Ayah'),
      const SizedBox(height: 16),
      _buildInput(kewarganegaraanAyahController, 'Kewarganegaraan Ayah'),
      const SizedBox(height: 35),
      _buildButtonAyah(),
    ];
  }

  List<Widget> _buildIbuForm() {
    return [
      _buildInput(namaIbuController, 'Nama Ibu'),
      const SizedBox(height: 16),
      _buildInput(pekerjaanIbuController, 'Pekerjaan Ibu'),
      const SizedBox(height: 16),
      _buildInput(noTelpIbuController, 'No Telp Ibu'),
      const SizedBox(height: 16),
      _buildInput(alamatIbuController, 'Alamat Ibu'),
      const SizedBox(height: 16),
      _buildDropdownReligion(agamaIbuController, 'Agama Ibu'),
      const SizedBox(height: 16),
      _buildInput(tempatLahirIbuController, 'Tempat Lahir Ibu'),
      const SizedBox(height: 16),
      _buildDateInput(tanggalLahirIbuController, 'Tanggal Lahir Ibu'),
      const SizedBox(height: 16),
      _buildDropdownStatus(statusIbuController, 'Status Ibu'),
      const SizedBox(height: 16),
      _buildInput(pendidikanIbuController, 'Pendidikan Ibu'),
      const SizedBox(height: 16),
      _buildInput(gelarIbuController, 'Gelar Ibu'),
      const SizedBox(height: 16),
      _buildInput(kewarganegaraanIbuController, 'Kewarganegaraan Ibu'),
      const SizedBox(height: 35),
      _buildButtonIbu(),
    ];
  }

  Widget _buildButtonAyah() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final dataAyah = {
              "name": namaAyahController.text,
              "job": pekerjaanAyahController.text,
              "phone": noTelpAyahController.text,
              "address": alamatAyahController.text,
              "religion": agamaAyahController.text,
              "placeOfBirth": tempatLahirAyahController.text,
              "dateOfBirth": tanggalLahirAyahController.text,
              "status": statusAyahController.text,
              "education": pendidikanAyahController.text,
              "title": gelarAyahController.text,
              "citizenship": kewarganegaraanAyahController.text,
            };
            final ayahSuccess = await SiswaService().createFather(dataAyah);
            if (ayahSuccess) {
              setState(() {
                isAyah = false; // Ganti ke form ibu
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gagal mengirim data ayah')),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00D084),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Selanjutnya (Isi Data Ibu)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildButtonIbu() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final dataIbu = {
              "name": namaIbuController.text,
              "job": pekerjaanIbuController.text,
              "phone": noTelpIbuController.text,
              "address": alamatIbuController.text,
              "religion": agamaIbuController.text,
              "placeOfBirth": tempatLahirIbuController.text,
              "dateOfBirth": tanggalLahirIbuController.text,
              "status": statusIbuController.text,
              "education": pendidikanIbuController.text,
              "title": gelarIbuController.text,
              "citizenship": kewarganegaraanIbuController.text,
            };
            final ibuSuccess = await SiswaService().createMother(dataIbu);
            if (ibuSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data berhasil dikirim')),
              );
              context.goNamed(myRouter.Uploaddoc);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gagal mengirim data ibu')),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00D084),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Selesai',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }


}
