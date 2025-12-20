// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cubit/report_cubit.dart';
import 'screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider( // bungkus pakai BlocProvider biar Cubit bisa diakses di mana aja 
      create: (context) => ReportCubit(),
      child: MaterialApp(
        title: 'Anpundung',
        debugShowCheckedModeBanner: false,
        // color pellet, diset global biar gampang
        theme: ThemeData(
          useMaterial3: true, // Biar makin modern stylenya
          scaffoldBackgroundColor: const Color(0xFFF6F6F6), // Background utama
          primaryColor: const Color(0xFF163172), // Warna biru gelap
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF163172),
            secondary: const Color(0xFF1E56A0), // Biru sedang
            surface: const Color(0xFFD6E4F0), // Biru muda abu
            background: const Color(0xFFF6F6F6),
          ),
          textTheme: GoogleFonts.poppinsTextTheme(), // Font Poppins biar kekinian
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF163172),
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
          ),
        ),
        home: const MainPage(), // Halaman utamanya ini
      ),
    );
  }
}