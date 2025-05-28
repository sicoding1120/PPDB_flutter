// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_project/router/app_router.dart';
import 'package:ppdb_project/service/uploadService.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Uploaddoc extends StatefulWidget {
  const Uploaddoc({super.key});

  @override
  State<Uploaddoc> createState() => _uploaddocState();
}

class _uploaddocState extends State<Uploaddoc> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dokumenController = TextEditingController();
  final TextEditingController akteController = TextEditingController();
  final TextEditingController kkController = TextEditingController();
  final TextEditingController ktpAyahController = TextEditingController();
  final TextEditingController ktpIbuController = TextEditingController();
  final TextEditingController ijazahController = TextEditingController();
  final TextEditingController fotoController = TextEditingController();

  Uint8List? akteBytes,
      kkBytes,
      ktpAyahBytes,
      ktpIbuBytes,
      ijazahBytes,
      fotoBytes;
  String? akteUrl, kkUrl, ktpAyahUrl, ktpIbuUrl, ijazahUrl, fotoUrl;

  Widget _buildUploadField({
    required String label,
    required TextEditingController controller,
    required bool isUploaded,
    required Function(Uint8List?, String?) onUpload,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        final file = await ImagePickerWeb.getImageAsBytes();
        if (file == null) return;
        final data = await UploadService().uploadImage(file);
        if (data != null) {
          onUpload(file, data['secure_url']);
          controller.text = '$label terupload';
        }
      },
      decoration: InputDecoration(
        labelText: isUploaded ? '$label terupload' : label,
        labelStyle: TextStyle(
          color: isUploaded ? Colors.green : Colors.grey,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: isUploaded ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.05),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isUploaded ? Colors.green : Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isUploaded ? Colors.green : Colors.blue,
            width: 2,
          ),
        ),
        suffixIcon: Icon(
          isUploaded ? Icons.check_circle : Icons.upload_file,
          color: isUploaded ? Colors.green : Colors.grey,
        ),
      ),
      validator: (value) => isUploaded ? null : 'Wajib upload dokumen',
    );
  }

  Widget _buildButtonKirim() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final payload = {
              'akte_url': akteUrl,
              'familyCard_url': kkUrl,
              'fatherKTP_url': ktpAyahUrl,
              'motherKTP_url': ktpIbuUrl,
              'ijazah_url': ijazahUrl,
              'studentPicture_url': fotoUrl,
            };
            // Setelah berhasil saveDocument
            await UploadService().saveDocument(payload);
          context.goNamed(myRouter.Pendaftaran);
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
          'Selanjutnya',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

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
          'Upload Dokumen',
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
              _buildUploadField(
                label: 'Upload Akte',
                controller: akteController,
                isUploaded: akteUrl != null,
                onUpload: (bytes, url) {
                  if (!mounted) return;
                  setState(() {
                    akteBytes = bytes;
                    akteUrl = url;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildUploadField(
                label: 'Upload KK',
                controller: kkController,
                isUploaded: kkUrl != null,
                onUpload: (bytes, url) {
                  if (!mounted) return;
                  setState(() {
                    kkBytes = bytes;
                    kkUrl = url;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildUploadField(
                label: 'Upload KTP Ayah',
                controller: ktpAyahController,
                isUploaded: ktpAyahBytes != null,
                onUpload: (bytes, url) {
                  if (!mounted) return;
                  setState(() {
                    ktpAyahBytes = bytes;
                    ktpAyahUrl = url;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildUploadField(
                label: 'Upload KTP Ibu',
                controller: ktpIbuController,
                isUploaded: ktpIbuBytes != null,
                onUpload: (bytes, url) {
                  if (!mounted) return;
                  setState(() {
                    ktpIbuBytes = bytes;
                    ktpIbuUrl = url;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildUploadField(
                label: 'Upload Ijazah SMP',
                controller: ijazahController,
                isUploaded: ijazahBytes != null,
                onUpload: (bytes, url) {
                  if (!mounted) return;
                  setState(() {
                    ijazahBytes = bytes;
                    ijazahUrl = url;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildUploadField(
                label: 'Upload Foto 3x4 / 4x6',
                controller: fotoController,
                isUploaded: fotoBytes != null,
                onUpload: (bytes, url) {
                  if (!mounted) return;
                  setState(() {
                    fotoBytes = bytes;
                    fotoUrl = url;
                  });
                },
              ),
              const SizedBox(height: 35),
              _buildButtonKirim(),
            ],
          ),
        ),
      ),
    );
  }
}
