import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_project/model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color greenColor = Color(0xFF24D674);
  DataUser? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('Login');
    if (userJson != null) {
      setState(() {
        userData = DataUser.fromJson(jsonDecode(userJson));
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // Top Row (Back & Logout Icons)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.blue),
                            onPressed: () {
                              context.go('/home');
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.logout, color: Colors.red),
                            onPressed: () async {
                              final confirm = await showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text("Keluar?"),
                                  content: Text("Apakah Anda yakin ingin logout?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: Text("Batal"),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: Text("Ya"),
                                    ),
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                await FirebaseAuth.instance.signOut();
                                final prefs = await SharedPreferences.getInstance();
                                await prefs.remove('Login'); // <-- Hapus data user di local
                                context.go("/login");
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    // Green Profile Box
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, size: 40, color: Colors.black),
                          ),
                          SizedBox(height: 8),
                          Text(
                            userData?.username ?? '-',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Profile Info (TextField disabled)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Username:"),
                          SizedBox(height: 5),
                          TextField(
                            enabled: false,
                            controller: TextEditingController(text: userData?.username ?? '-'),
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text("Email:"),
                          SizedBox(height: 5),
                          TextField(
                            enabled: false,
                            controller: TextEditingController(text: userData?.email ?? '-'),
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text("Password:"),
                          SizedBox(height: 5),
                          TextField(
                            enabled: false,
                            controller: TextEditingController(text:  '********'),
                            style: TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}






