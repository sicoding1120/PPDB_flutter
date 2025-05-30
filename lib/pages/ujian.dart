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
  List<dynamic> ujianList = [];
  bool isLoading = true;
  bool isSelectStudent = true;

  @override
  void initState() {
    super.initState();
    fetchStudentList();
    fetchUjianList();
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

  Future<void> fetchUjianList() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/tests'));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body['data'] is List) {
          setState(() {
            ujianList = body['data'];
          });
        }
      }
    } catch (e) {
      // Optional error handling
    }
  }

  Future<void> selectStudent(dynamic student) async {
    print('DEBUG: Anak yang dipilih untuk ujian: ${student['ID']}');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedStudent', student['ID']);
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

  Widget _buildUjianList() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 140,
          decoration: const BoxDecoration(
            color: Color(0xFF24D674),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                  ),
                  children: [
                    TextSpan(
                      text: 'MY',
                      style: TextStyle(color: Colors.orange),
                    ),
                    TextSpan(
                      text: 'PPDB',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Materi Soal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: ujianList.isEmpty
              ? const Center(child: Text('Belum ada data ujian.'))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: ujianList.length,
                  itemBuilder: (context, index) {
                    final soal = ujianList[index];
                    final accent = index % 2 == 0 ? Colors.green : Colors.orange;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 18),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        elevation: 3,
                        shadowColor: Colors.black12,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          splashColor: accent.withOpacity(0.1),
                          onTap: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Konfirmasi', style: TextStyle(fontSize: 20)),
                                content: const Text('Apakah Anda yakin ingin memulai ujian ini?', style: TextStyle(fontSize: 18)),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('Batal', style: TextStyle(color: Colors.red, fontSize: 16)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text('Mulai Ujian', style: TextStyle(color: Colors.green, fontSize: 16)),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              final prefs = await SharedPreferences.getInstance();
                              final selectedStudentID = prefs.getString('selectedStudent');
                              final response = await http.post(
                                Uri.parse('http://localhost:5000/student-tests/save'),
                                headers: {'Content-Type': 'application/json'},
                                body: json.encode({
                                  'studentID': selectedStudentID,
                                  'testID': soal['ID'],
                                }),
                              );
                              if (response.statusCode == 200 || response.statusCode == 201) {
                                context.go('/isiUjian', extra: {
                                  'student': selectedStudentID,
                                  'judul': soal['title'] ?? '-',
                                  'deskripsi': soal['category']?['name'] ?? '-',
                                  'waktu': '10 Mnt',
                                  'id': soal['ID'],
                                }
                                );
                                print('Ujian dimulai untuk student ID: $selectedStudentID, test ID: ${soal['ID']}');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Gagal memulai ujian. Silakan coba lagi.')),
                                );
                              }
                            }
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: accent,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          'https://res.cloudinary.com/dqbtkdora/image/upload/v1747543370/dps1vegobv4ewwwxxsdb.webp',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              soal['title'] ?? '-',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: accent,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              soal['category']?['name'] ?? '-',
                                              style: const TextStyle(fontSize: 13, color: Colors.black87),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                                const SizedBox(width: 4),
                                                const Text(
                                                  '10 Mnt',
                                                  style: TextStyle(fontSize: 13, color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
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
        title: Text(
          isSelectStudent ? "Pilih Anak" : "Pilih Ujian",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bug_report, color: Colors.white),
            onPressed: () {
              print('studentList: $studentList');
              print('ujianList: $ujianList');
              print('isSelectStudent: $isSelectStudent');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Debug info printed to console')),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : isSelectStudent
              ? ListView.builder(
                  itemCount: studentList.where((s) => s['status'] == 'PASSED').length,
                  itemBuilder: (context, index) {
                    final passedStudents = studentList.where((s) => s['status'] == 'PASSED' && s['testType'] == 'ONLINE').toList();
                    return _buildStudentCard(passedStudents[index]);
                  },
                )
              : _buildUjianList(),
    );
  }
}
