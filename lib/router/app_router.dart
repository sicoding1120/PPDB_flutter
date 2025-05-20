// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ppdb_project/pages/Forget_Screen.dart';
import 'package:ppdb_project/pages/Home_Screen.dart';
import 'package:ppdb_project/pages/Login_Screen.dart';
import 'package:ppdb_project/pages/Register_Screen.dart';
import 'package:ppdb_project/pages/Splash_Screen.dart';
import 'package:ppdb_project/pages/Test.dart';
import 'package:ppdb_project/pages/hasiltest.dart';
import 'package:ppdb_project/pages/isidata_ortu.dart';
import 'package:ppdb_project/pages/jadwaltest.dart';
import 'package:ppdb_project/pages/ktm.dart';
import 'package:ppdb_project/pages/payment.dart';
import 'package:ppdb_project/pages/pendaftaran.dart';
import 'package:ppdb_project/pages/profile.dart';
import 'package:ppdb_project/pages/ujian.dart';
import 'package:ppdb_project/pages/uploadDoc.dart';
part 'route_name.dart';


final router = [
  GoRoute(
    path: "/",
    name: myRouter.Splash,
    builder: (context, state) => SplashScreen(),
  ),
  GoRoute(
    path: "/login",
    name: myRouter.Login,
    builder: (context, state) => LoginScreen(),
  ),
  GoRoute(
    path: "/regis",
    name: myRouter.Regis,
    builder: (context, state) => RegisterScreen(),
  ),
  GoRoute(
    path: "/forget",
    name: myRouter.Forget,
    builder: (context, state) => ForgetScreen(),
  ),
  GoRoute(
    path: "/home",
    name: myRouter.Home,
    builder: (context, state) => HomeScreen(),
  ),

  GoRoute(path: "/pendaftaran",
    name: myRouter.Pendaftaran,
    builder: (context, state) => Pendaftaran(),
  ),  

   GoRoute(path: "/isidataOrtu",
    name: myRouter.isidataOrtu,
    builder: (context, state) => IsidataOrtu(),
  ),  

  GoRoute(path: "/uploaddoc",
    name: myRouter.Uploaddoc,
    builder: (context, state) => Uploaddoc(),
  ),  

   GoRoute(path: "/profile",
    name: myRouter.profile,
    builder: (context, state) => ProfilePage(),
  ),  

  GoRoute(path: "/KTM",
    name: myRouter.KTM,
    builder: (context, state) => KTM(),
  ),  

  GoRoute(path: "/jadwal",
    name: myRouter.jadwal,
    builder: (context, state) => Jadwaltest(),
  ),

   GoRoute(path: "/ujian",
    name: myRouter.ujian,
    builder: (context, state) => Ujian(),
  ),
 

  GoRoute(path: "/hasil",
    name: myRouter.hasil,
    builder: (context, state) => Hasiltest(),
  ),

  GoRoute(path: "/payment",
    name: myRouter.payment,
    builder: (context, state) => Payment(),
  ),
];