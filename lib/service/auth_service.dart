// auth_service.dart
// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_project/router/app_router.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fungsi untuk register (buat akun baru)
  Future<User?> registerWithEmailPassword(
    BuildContext context,
    String email,
    String password,
    String name,
  ) async {
    try {
     
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

     
      await userCredential.user?.updateDisplayName(name);

      print('Registrasi berhasil, redirect ke login...');
      context.go('/login'); 

      return userCredential.user;
    }
     catch (e) {
      print('Register gagal: $e');
      throw Exception('Register gagal: $e');
    }
  }

  // Fungsi untuk login
Future<User?> loginWithEmailPassword(
  BuildContext context,
  String email,
  String password,
) async {
  // Regex sederhana untuk validasi email
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  // Validasi format email
  if (!emailRegex.hasMatch(email.trim())) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Format email tidak valid!')),
    );
    return null;
  }

  // Validasi password tidak kosong
  if (password.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password tidak boleh kosong!')),
    );
    return null;
  }

  try {
    // Login dengan Firebase
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    context.goNamed(myRouter.Home); // Navigasi ke Home
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    String errorMsg = 'Terjadi kesalahan saat login.';
    if (e.code == 'user-not-found') {
      errorMsg = 'Email tidak terdaftar.';
    } else if (e.code == 'wrong-password') {
      errorMsg = 'Password salah.';
    } else if (e.code == 'invalid-email') {
      errorMsg = 'Email tidak valid.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMsg)),
    );
    return null;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login gagal: ${e.toString()}')),
    );
    return null;
  }
}


  // Fungsi untuk logout
  Future<void> logout() async {
    await _auth.signOut();
  }


  Future<void> ForgotPassword(BuildContext context, String emailAddress) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Link reset password telah dikirim ke $emailAddress'),
        ),
      );
      // Arahkan kembali ke halaman login
      context.go('/login');
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'invalid-email') {
        errorMessage = 'Email tidak valid.';
      } else if (e.code == 'user-not-found') {
        errorMessage = 'Tidak ada pengguna dengan email tersebut.';
      } else {
        errorMessage = 'Terjadi kesalahan. Silakan coba lagi.';
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan. Silakan coba lagi.')),
      );
    }
  }

  // Fungsi untuk mengambil user yang sedang login
  User? get currentUser => _auth.currentUser;
}
