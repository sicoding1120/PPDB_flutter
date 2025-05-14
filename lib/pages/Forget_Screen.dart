import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_project/router/app_router.dart';
import 'package:ppdb_project/service/auth_service.dart';

class ForgetScreen extends StatefulWidget {
  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final TextEditingController _emailController = TextEditingController();

  void _sendResetEmail() {
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email tidak boleh kosong!')),
      );
      return;
    }

    AuthService().ForgotPassword(context, email);

    // Logika untuk mengirim email reset password
    // Misalnya, menggunakan Firebase Auth
    // FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Email reset password telah dikirim!')),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3), // Latar belakang abu terang
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 360,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  'https://res.cloudinary.com/dlnfp5fej/image/upload/v1747108687/klhraf8kl4f82phoz7st.png',
                  width: 98,
                  height: 98,
                ),
                SizedBox(height: 24),
                Text(
                  'Lupa Password',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Masukkan Email anda untuk\nreset password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 24),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    _sendResetEmail(); // Panggil fungsi untuk mengirim email reset password
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF24D674),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  child: Text(

                    'Kirim',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(height: 24),
                Divider(),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    context.goNamed(myRouter.Login); // Navigasi ke halaman login
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.blueGrey[600],

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}