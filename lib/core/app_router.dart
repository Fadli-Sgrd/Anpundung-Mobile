import 'package:flutter/material.dart';
// Import screen-screen nanti di sini
// import '../mvc/auth/view/login_screen.dart';
// import '../mvc/home/view/home_screen.dart';

class AppRouter {
  // Static route names
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/'; // Main Page wrapper
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String edukasi = '/edukasi';
  static const String laporan = '/laporan';

  // Routing Logic
  // static Route<dynamic> onGenerateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case login:
  //       return MaterialPageRoute(builder: (_) => const LoginScreen());
  //     case main:
  //       return MaterialPageRoute(builder: (_) => const MainPage());
  //     // ... dst
  //     default:
  //       return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Route not found!'))));
  //   }
  // }
}
