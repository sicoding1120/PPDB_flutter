import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IsiUjianPage extends StatefulWidget {
  final Map<String, dynamic> extra;
  const IsiUjianPage({super.key, required this.extra});

  @override
  State<IsiUjianPage> createState() => _IsiUjianPageState();
}

class _IsiUjianPageState extends State<IsiUjianPage> {
  List<dynamic> questions = [];
  Map<String, String> jawaban = {};
  bool isSubmitting = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final testID = widget.extra['testID'] ?? widget.extra['id'];
    final response = await http.get(
      Uri.parse('http://localhost:5000/tests/detail/$testID'),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      setState(() {
        questions = body['data']['questions'] ?? [];
      });
    }
  }

  Future<void> submitJawaban() async {
    setState(() => isSubmitting = true);
    final studentID = widget.extra['student'];
    final testID = widget.extra['testID'] ?? widget.extra['id'];
    final answers =
        jawaban.entries
            .map((e) => {"questionID": e.key, "selectedOptionID": e.value})
            .toList();

    final response = await http.post(
      Uri.parse('http://localhost:5000/student-tests/submit'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "studentID": studentID,
        "testID": testID,
        "answers": answers,
      }),
    );

    setState(() => isSubmitting = false);

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Jawaban berhasil disimpan!')));
      // Navigasi ke halaman hasil atau kembali jika perlu
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan jawaban!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Color(0xFF21D07A),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: null,
      ),
      body: questions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  // Lengkungan hijau atas
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF21D07A),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  // Card putih isi soal
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Logo/Title di dalam card putih
                                Center(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'MY',
                                          style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'PPDB',
                                          style: TextStyle(
                                            color: Color(0xFF21D07A),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 18),
                                // Judul
                                Text(
                                  'isi Soal',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 18),
                                // Nomor soal: Wrap agar otomatis ke bawah jika penuh
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: List.generate(
                                    questions.length,
                                    (idx) {
                                      final isActive = idx == currentIndex;
                                      final alreadyAnswered = jawaban[questions[idx]['ID']] != null;
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            currentIndex = idx;
                                          });
                                        },
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: isActive
                                              ? Color(0xFFFFB800)
                                              : alreadyAnswered
                                                  ? Color(0xFF21D07A)
                                                  : Color(0xFFE0E0E0),
                                          child: Text(
                                            '${idx + 1}',
                                            style: TextStyle(
                                              color: isActive || alreadyAnswered
                                                  ? Colors.white
                                                  : Colors.black54,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 24),
                                // Soal
                                Text(
                                  questions[currentIndex]['text'] ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 28),
                                // Pilihan jawaban custom
                                ...List.generate(
                                  questions[currentIndex]['options'].length,
                                  (optIdx) {
                                    final opt = questions[currentIndex]['options'][optIdx];
                                    final isSelected = jawaban[questions[currentIndex]['ID']] == opt['ID'];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 14),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            jawaban[questions[currentIndex]['ID']] = opt['ID'];
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 0),
                                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? Color(0x3321D07A)
                                                : Color(0xFFF5F5F5),
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: isSelected
                                                  ? Color(0xFF21D07A)
                                                  : Colors.transparent,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 14,
                                                backgroundColor: isSelected
                                                    ? Color(0xFF21D07A)
                                                    : Color(0xFFE0E0E0),
                                                child: Text(
                                                  opt['label'],
                                                  style: TextStyle(
                                                    color: isSelected ? Colors.white : Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  opt['value'],
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: isSelected ? Color(0xFF21D07A) : Colors.black87,
                                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: questions.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: isSubmitting ? null : submitJawaban,
              backgroundColor: Color(0xFFE5D8FF),
              foregroundColor: Color(0xFF6F42C1),
              icon: Icon(Icons.save),
              label: Text("Simpan Jawaban"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
    );
  }
}
