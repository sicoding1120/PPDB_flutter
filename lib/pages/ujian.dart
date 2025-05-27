import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Ujian extends StatefulWidget {
  const Ujian({super.key});

  @override
  State<Ujian> createState() => _UjianState();
}

class _UjianState extends State<Ujian> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> soalList = [
      {'judul': 'Diniyyah', 'deskripsi': 'Kerjakan dengan jujur dan...', 'waktu': '10 Mnt'},
      {'judul': 'Umum', 'deskripsi': 'Kerjakan dengan jujur dan...', 'waktu': '10 Mnt'},
      {'judul': 'B.Inggris', 'deskripsi': 'Kerjakan dengan jujur dan...', 'waktu': '10 Mnt'},
      {'judul': 'Psikotes', 'deskripsi': 'Kerjakan dengan jujur dan...', 'waktu': '10 Mnt'},
    ];

    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: Color(0xFF24D674),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.go('/home');
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 16, bottom: 24),
            decoration: const BoxDecoration(
              color: Color(0xFF24D674),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
            ),
            child: Column(
              children: const [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "MY",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      TextSpan(
                        text: "PPDB",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Materi Soal",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 242, 242),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
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
                    onTap: () {
                      // Tentukan route sesuai index atau judul materi
                      String route;
                      switch (soal['judul']) {
                        case 'Diniyyah':
                          route = '/isiujianAgama';
                          break;
                        case 'Umum':
                          route = '/isiujianUmum';
                          break;
                        case 'B.Inggris':
                          route = '/isiujianBahasa';
                          break;
                        case 'Psikotes':
                          route = '/isiujianPsikotes';
                          break;
                        default:
                          route = '/isiujianUmum'; // Default route if no match
                          break;
                      }
                      context.go(route, extra: {
                        'judul': soal['judul'],
                        'deskripsi': soal['deskripsi'],
                        'waktu': soal['waktu'],
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
