// import 'package:flutter/material.dart';
// import 'package:ppdb_project/model/studentModel.dart';
// import '../service/pendaftaranService.dart';

// class TestGetPage extends StatelessWidget {
//   final siswaService = SiswaService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Daftar Siswa')),
//       body: FutureBuilder<List<DataStudent>>(
//         future: siswaService.getSiswa(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('Tidak ada data siswa'));
//           } else {
//             final siswaList = snapshot.data!;
//             return Wrap(
//               spacing: 10,
//               children: List.generate(
//                 siswaList.length,
//                 (index) {
//                   return Container(
//                     width: MediaQuery.of(context).size.width,
//                     child: Column(
//                       children: [
//                         Text(siswaList[index].fullName),
//                         Text(siswaList[index].fromSchool),
//                         Text(siswaList[index].phone),
//                         Text(siswaList[index].address),
//                         Divider(),
//                     ]),
//                   );
//                 },

//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestGetPage extends StatefulWidget {
  const TestGetPage({super.key});

  @override
  State<TestGetPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<TestGetPage> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? loginData = prefs.getString('Login');

    if (loginData != null) {
      final decoded = jsonDecode(loginData);
      setState(() {
        userData = decoded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengguna'),
      ),
      body: userData == null
          ? Center(child: Text('Tidak ada data login.'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama: ${userData!['nama'] ?? '-'}'),
                  Text('Email: ${userData!['email'] ?? '-'}'),
                  Text('Phone: ${userData!['phone'] ?? '-'}'),
                  // Tambahkan field lain sesuai isi `DataUser`
                ],
              ),
            ),
    );
  }
}
