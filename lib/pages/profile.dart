// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_project/service/authService.dart';

class ProfilePage extends StatelessWidget {
  final String username = 'Ibrahim';
  final String email = 'Ibrahim@gmail.com';
  final String password = '1234567890';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            context.go('/home');
          }
        ),
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, size: 60, color: Colors.black),
            ),
            SizedBox(height: 30),
            _infoBox('Username :', username),
            SizedBox(height: 12),
            _infoBox('Email :', email),
            SizedBox(height: 12),
            _infoBox('Password :', password),
            Spacer(),
            // Icon Logout
            Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(Icons.logout, color: Colors.redAccent, size: 32),
               onPressed: () async {
  await AuthService().logout();
  print("Logout pressed");
  context.go('/login'); // GUNAKAN go_router, bukan Navigator
},
                
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(String label, String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
}
