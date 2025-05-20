// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';
import 'router/app_router.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final GoRouter customRouter = GoRouter(
          initialLocation: '/login',
          routes: router,
          redirect: (context, state) {
            final user = FirebaseAuth.instance.currentUser;
            final loggingIn = state.uri.toString() == '/login' || state.uri.toString() == '/regis' || state.uri.toString() == '/forget';
            if (user == null && !loggingIn) return '/login';
            if (user != null && loggingIn) return '/home';
            return null;
          },
        );
        if (snapshot.connectionState == ConnectionState.active) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Simple App',
            routerConfig: customRouter,
          );
        } else {
          return MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }
      },
    );
  }
}