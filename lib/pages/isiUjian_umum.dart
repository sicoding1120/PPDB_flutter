import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IsiujianUmum extends StatefulWidget {
  @override
  State<IsiujianUmum> createState() => _IsiujianUmumState();
}

class _IsiujianUmumState extends State<IsiujianUmum> {
  final Color greenColor = Color(0xFF24D674);

  // Contoh data soal dan opsi
  final List<Map<String, dynamic>> soalList = [
    {
      'pertanyaan': '1. 20 X 10 =?',
      'opsi': ['10', '200', '30', '20', '100'],
    },

      {
      'pertanyaan': '2. Apa Hukum Menyembah Berhala?',
      'opsi': ['Syirik', 'Halal', 'Mubah', 'Dianjurkan', 'Makruh'],
    },

      {
      'pertanyaan': 'Apa Hukum Menyembah Berhala?',
      'opsi': ['Syirik', 'Halal', 'Mubah', 'Dianjurkan', 'Makruh'],
    },

      {
      'pertanyaan': 'Apa Hukum Menyembah Berhala?',
      'opsi': ['Syirik', 'Halal', 'Mubah', 'Dianjurkan', 'Makruh'],
    },

      {
      'pertanyaan': 'Apa Hukum Menyembah Berhala?',
      'opsi': ['Syirik', 'Halal', 'Mubah', 'Dianjurkan', 'Makruh'],
    },
    
    // Tambahkan soal lain sesuai kebutuhan
  ];

  int selectedNumber = 0;
  List<String?> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    selectedOptions = List<String?>.filled(soalList.length, null);
  }

  @override
  Widget build(BuildContext context) {
    final soal = soalList[selectedNumber];
    return Scaffold(
      backgroundColor: greenColor,
      body: SafeArea(
        child: Column(
          children: [
            // Back button
            Padding(
              padding: const EdgeInsets.all(8.0),
             child: Align(
                
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    context.go('/ujian');
                  },
                ),
                
              ),
            ),
            // Rounded container
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo Text
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "MY",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.orange),
                            ),
                            TextSpan(
                              text: "PPDB",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: greenColor),
                            ),
                          ],
                        ),
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "isi Soal Umum",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 24),

                      // Nomor soal
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(soalList.length, (index) {
                          bool isActive = index == selectedNumber;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedNumber = index;
                                });
                              },
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor:
                                    isActive ? Colors.orange : Colors.grey[300],
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                    color: isActive ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 24),

                      // Pertanyaan
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          soal['pertanyaan'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Opsi jawaban
                      ...List.generate(soal['opsi'].length, (i) {
                        String label = String.fromCharCode(65 + i); // A, B, C, ...
                        return buildOption(
                          label,
                          soal['opsi'][i],
                          selectedOptions[selectedNumber] == label,
                          highlightColor: greenColor,
                          onTap: () {
                            setState(() {
                              selectedOptions[selectedNumber] = label;
                            });
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOption(String label, String text, bool selected,
      {Color highlightColor = Colors.grey, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? highlightColor.withOpacity(0.1) : Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
          border: selected ? Border.all(color: highlightColor, width: 2) : null,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: selected ? highlightColor : Colors.grey[400],
              child: Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
            ),
            SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: selected ? highlightColor : Colors.black,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
