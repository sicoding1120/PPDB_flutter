// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ppdb_project/pages/BSI_1.dart';
import 'package:ppdb_project/pages/BSI_2.dart';
import 'package:ppdb_project/pages/Forget_Screen.dart';
import 'package:ppdb_project/pages/Home_Screen.dart';
import 'package:ppdb_project/pages/Login_Screen.dart';
import 'package:ppdb_project/pages/QRIS_1.dart';
import 'package:ppdb_project/pages/QRIS_2.dart';
import 'package:ppdb_project/pages/Register_Screen.dart';
import 'package:ppdb_project/pages/Splash_Screen.dart';
import 'package:ppdb_project/pages/Test.dart';
import 'package:ppdb_project/pages/hasiltest.dart';
import 'package:ppdb_project/pages/isiUjian_agama.dart';
import 'package:ppdb_project/pages/isiUjian_bahasa.dart';
import 'package:ppdb_project/pages/isiUjian_psikotes.dart';
import 'package:ppdb_project/pages/isiUjian_umum.dart';
import 'package:ppdb_project/pages/isidata_ortu.dart';
import 'package:ppdb_project/pages/jadwaltest.dart';
import 'package:ppdb_project/pages/ktm.dart';
import 'package:ppdb_project/pages/payment.dart';
import 'package:ppdb_project/pages/pendaftaran.dart';
import 'package:ppdb_project/pages/popupHasil.dart';
import 'package:ppdb_project/pages/profile.dart';
import 'package:ppdb_project/pages/ujian.dart';
import 'package:ppdb_project/pages/uploadDoc.dart';
part 'route_name.dart';


final router = [
  GoRoute(
    path: "/splash",
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
    builder: (context, state) => MyPPDBHomePage(),
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

  GoRoute(path: "/isiujianAgama",
    name: myRouter.isiujianAgama,
    builder: (context, state) => isiujianAgama(),
  ),

  GoRoute(path: "/isiujianUmum",
    name: myRouter.isiujianUmum,
    builder: (context, state) => IsiujianUmum(),
  ),

  GoRoute(path: "/isiujianBahasa",
    name: myRouter.isiujianBahasa,
    builder: (context, state) => IsiujianBahasa(),
  ),

  GoRoute(path: "/isiujianPsikotes",
    name: myRouter.isiujianPsikotes,
    builder: (context, state) => isiujianPsikotes(),
  ),

  GoRoute(path: "/popupHasil",
    name: myRouter.popupHasil,
    builder: (context, state) => Popuphasil(),
  ),

  GoRoute(path: "/bsi1",
    name: myRouter.bsi1,
    builder: (context, state) => const PembayaranBSI(),
  ),

  GoRoute(path: "/bsi2",
    name: myRouter.bsi2,
    builder: (context, state) => const Bsi2(),
  ),

  GoRoute(path: "/QRIS1",
    name: myRouter.QRIS1,
    builder: (context, state) => const Qris1(),
  ),

  GoRoute(path: "/QRIS2",
    name: myRouter.QRIS2,
    builder: (context, state) => const PaymentSuccess(),
  ),

  
];