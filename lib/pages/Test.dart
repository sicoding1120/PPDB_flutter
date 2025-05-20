import 'package:flutter/material.dart';
import 'package:ppdb_project/model/studentModel.dart';
import '../service/pendaftaranService.dart';

class TestGetPage extends StatelessWidget {
  final siswaService = SiswaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Siswa')),
      body: FutureBuilder<List<DataStudent>>(
        future: siswaService.getSiswa(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada data siswa'));
          } else {
            final siswaList = snapshot.data!;
            return Wrap(
              spacing: 10,
              children: List.generate(
                siswaList.length,
                (index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Text(siswaList[index].fullName),
                        Text(siswaList[index].fromSchool),
                        Text(siswaList[index].phone),
                        Text(siswaList[index].address),
                        Divider(),
                    ]),
                  );
                },

              ),
            );
          }
        },
      ),
    );
  }
}