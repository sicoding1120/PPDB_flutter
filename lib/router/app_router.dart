import 'package:go_router/go_router.dart';
import 'package:ppdb_project/pages/Forget_Screen.dart';
import 'package:ppdb_project/pages/Home_Screen.dart';
import 'package:ppdb_project/pages/Login_Screen.dart';
import 'package:ppdb_project/pages/Register_Screen.dart';
import 'package:ppdb_project/pages/Splash_Screen.dart';
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
];