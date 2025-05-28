import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Ujian extends StatefulWidget {
  const Ujian({super.key});

  @override
  State<Ujian> createState() => _UjianState();
}

class _UjianState extends State<Ujian> {
  List<dynamic> studentList = [];
  bool isLoading = true;
  bool isSelectStudent = true; // true: pilih anak, false: pilih ujian

  @override
  void initState() {
    super.initState();
    fetchStudentList();
  }

  Future<void> fetchStudentList() async {
    setState(() {
      isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('UserId');
      final response = await http.get(Uri.parse('http://localhost:5000/student/user/$userId'));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body['data'] is List) {
          studentList = body['data'];
        } else if (body['data'] != null) {
          studentList = [body['data']];
        } else {
          studentList = [];
        }
      } else {
        studentList = [];
      }
    } catch (e) {
      studentList = [];
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> selectStudent(dynamic student) async {
    print('DEBUG: Anak yang dipilih untuk ujian: $student'); // Tambahkan ini
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedStudent', json.encode(student));
    setState(() {
      isSelectStudent = false;
    });
  }

  Widget _infoBox(String label, String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        '$label $value',
        style: TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }

  Widget _buildStudentCard(dynamic student) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      shadowColor: Colors.grey.shade300,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => selectStudent(student),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar & Nama
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.blue.shade100,
                    child: Icon(Icons.person, size: 34, color: Colors.blue.shade700),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      student['fullName'] ?? '-',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _infoBox('NIK :', student['NIK'] ?? '-'),
              SizedBox(height: 12),
              _infoBox('Jurusan :', student['major'] ?? '-'),
              SizedBox(height: 12),
              _infoBox('Nama Ayah :', student['father']?['name'] ?? '-'),
              SizedBox(height: 12),
              _infoBox('Pekerjaan Ayah :', student['father']?['job'] ?? '-'),
              SizedBox(height: 12),
              _infoBox('Nama Ibu :', student['mother']?['name'] ?? '-'),
              SizedBox(height: 12),
              _infoBox('Pekerjaan Ibu :', student['mother']?['job'] ?? '-'),
            ],
          ),
        ),
      ),
    );
  }

  // Widget ujian yang sudah ada
  Widget _buildUjianList() {
    final List<Map<String, String>> soalList = [
      {'judul': 'Diniyyah', 'deskripsi': 'Kerjakan dengan jujur dan...', 'waktu': '10 Mnt'},
      {'judul': 'Umum', 'deskripsi': 'Kerjakan dengan jujur dan...', 'waktu': '10 Mnt'},
      {'judul': 'B.Inggris', 'deskripsi': 'Kerjakan dengan jujur dan...', 'waktu': '10 Mnt'},
      {'judul': 'Psikotes', 'deskripsi': 'Kerjakan dengan jujur dan...', 'waktu': '10 Mnt'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: soalList.length,
      itemBuilder: (context, index) {
        final soal = soalList[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://res.cloudinary.com/dqbtkdora/image/upload/v1747543370/dps1vegobv4ewwwxxsdb.webp',
                width: 100,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              soal['judul']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.orange
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  soal['deskripsi']!,
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      soal['waktu']!,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () async {
              // Ambil data anak dari SharedPreferences
              final prefs = await SharedPreferences.getInstance();
              final selectedStudent = prefs.getString('selectedStudent');
              // Kirim data anak + soal ke halaman berikutnya
              context.go('/isiujian', extra: {
                'student': selectedStudent,
                'judul': soal['judul'],
                'deskripsi': soal['deskripsi'],
                'waktu': soal['waktu'],
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: Color(0xFF24D674),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (!isSelectStudent) {
              setState(() {
                isSelectStudent = true;
              });
            } else {
              context.go('/home');
            }
          },
        ),
        title: Text(isSelectStudent ? "Pilih Anak" : "Pilih Ujian"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : isSelectStudent
              ? ListView.builder(
                  itemCount: studentList.length,
                  itemBuilder: (context, index) {
                    return _buildStudentCard(studentList[index]);
                  },
                )
              : _buildUjianList(),
    );
  }
}
