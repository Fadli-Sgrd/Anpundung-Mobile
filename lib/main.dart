import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controllers/report_cubit.dart';
import 'views/splash_screen.dart';
import 'views/login_screen.dart';
import 'views/register_screen.dart';
import 'views/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Anpundung',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF163172),
            brightness: Brightness.light,
          ),
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF163172),
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/main': (context) => const MainPage(),
        },
      ),
    );
  }
}