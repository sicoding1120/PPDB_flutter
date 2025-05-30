// auth_service.dart
// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ppdb_project/model/userModel.dart';
import 'package:ppdb_project/router/app_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fungsi untuk register (buat akun baru)
  Future<User?> registerWithEmailPassword(
    BuildContext context,
    String email,
    String password,
    String username,
    String phone,
  ) async {
    try {
      // 1. Register ke Firebase dulu
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user?.updateDisplayName(username);
      print('Firebase user created: ${userCredential.user?.uid}');
      // 2. Register ke backend (yang sekarang juga login & return token)
      Uri urlregister = Uri.parse('http://localhost:5000/auth/register');
      var response = await http.post(
        urlregister,
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'username': username,
          'phone': phone,
        }),
      );
      print('Backend response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        // Cek apakah ID dan token ada
        if (responseData['data']?['ID'] == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registrasi gagal: Data user tidak lengkap dari server!')),
          );
          return null;
        }

        DataUser loginData = DataUser.fromJson({
          'ID': responseData['data']['ID'],
          'username': responseData['data']['username'],
          'email': responseData['data']['email'],
          'password': password,
          'phone': responseData['data']['phone'],
        });

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('Login', jsonEncode(loginData.toJson()));
        await prefs.setString('UserId', responseData['data']['ID']);
        await prefs.setString('access_token', responseData['data']['access_token'] ?? '');
        await prefs.setString('refresh_token', responseData['data']['refresh_token'] ?? '');

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registrasi & login berhasil!')),
          );
          context.goNamed(myRouter.Home);
        }
        return userCredential.user;
      } else {
        // Backend gagal, rollback Firebase
        await _auth.currentUser?.delete();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Registrasi gagal di server.')));
        return null;
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registrasi gagal (Firebase): ${e.message}')),
      );
      print('Firebase error: ${e.code} - ${e.message}');
      return null;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Registrasi gagal: $e')));
      print('Other error: $e');
      return null;
    }
  }

  // Fungsi untuk login
  Future<User?> loginWithEmailPassword(
    BuildContext context,
    String email,
    String phone,
    String password,
  ) async {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    Uri urllogin = Uri.parse('http://localhost:5000/auth/login');

    // Validasi format email
    if (!emailRegex.hasMatch(email.trim())) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Format email tidak valid!')));
      return null;
    }

    // Validasi password tidak kosong
    if (password.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Password tidak boleh kosong!')));
      return null;
    }

    try {
      // 1. Login ke backend dulu
      var response = await http.post(
        urllogin,
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'phone': phone,
        }),
      );

      var responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // 2. Jika backend sukses, baru login ke Firebase
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email.trim(), password: password);

        DataUser loginData = DataUser.fromJson({
          'ID': responseData['data']['ID'],
          'username': responseData['data']['username'],
          'email': responseData['data']['email'],
          'password': responseData['data']['password'],
          'phone': responseData['data']['phone'],
        });

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('Login', jsonEncode(loginData.toJson()));
        await prefs.setString('UserId', responseData['data']['ID']);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login berhasil')),
        );
        context.goNamed(myRouter.Home);
        return userCredential.user;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login gagal di server: ${response.body}')),
        );
        return null;
      }
    } on FirebaseAuthException catch (e) {
      String errorMsg = 'Terjadi kesalahan saat login.';
      if (e.code == 'user-not-found') {
        errorMsg = 'Email tidak terdaftar.';
      } else if (e.code == 'wrong-password') {
        errorMsg = 'Password salah.';
      } else if (e.code == 'invalid-email') {
        errorMsg = 'Email tidak valid.';
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMsg)));
      return null;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login gagal: ${e.toString()}')));
      return null;
    }
  }

  // Fungsi untuk logout
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
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

  Future signinWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider.addScope(
          'https://www.googleapis.com/auth/contacts.readonly',
        );
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
        context.goNamed(myRouter.Home);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        await FirebaseAuth.instance.signInWithCredential(credential);
        context.goNamed(myRouter.Home);
      }
    } catch (e) {}
  }

  // Fungsi untuk mengambil user yang sedang login
  User? get currentUser => _auth.currentUser;
}
