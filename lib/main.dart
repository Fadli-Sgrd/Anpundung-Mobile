/// ==========================================================
/// FILE: main.dart
/// DESKRIPSI: Entry point (titik masuk) aplikasi Anpundung
///
/// File ini adalah file pertama yang dijalankan saat aplikasi
/// dibuka. Di sini kita setup:
/// - Repository (penghubung ke API)
/// - Bloc/Cubit (pengatur state/kondisi aplikasi)
/// - Tema dan navigasi aplikasi
/// ==========================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/app_router.dart';
import 'mvc/auth/bloc/login_cubit.dart';
import 'mvc/auth/bloc/register_cubit.dart';
import 'mvc/auth/bloc/logout_cubit.dart';
import 'mvc/auth/data/auth_repository.dart';
import 'mvc/report/bloc/report_cubit.dart';
import 'mvc/report/data/report_repository.dart';
import 'mvc/news/bloc/news_cubit.dart';
import 'mvc/news/data/news_repository.dart';
import 'mvc/profile/bloc/profile_cubit.dart';
import 'mvc/profile/data/profile_repository.dart';
import 'mvc/dashboard/bloc/dashboard_cubit.dart';
import 'mvc/dashboard/data/dashboard_repository.dart';
import 'mvc/auth/view/login_screen.dart';
import 'mvc/auth/view/register_screen.dart';
import 'mvc/report/view/laporan_screen.dart';
import 'mvc/splash/view/splash_screen.dart';
import 'mvc/main/view/main_page.dart';

/// Fungsi utama - dipanggil pertama kali saat app dibuka
void main() {
  runApp(const MyApp());
}

/// Widget utama aplikasi Anpundung
///
/// Di sini kita bungkus seluruh aplikasi dengan:
/// - MultiRepositoryProvider: Supaya repository bisa diakses dari mana saja
/// - MultiBlocProvider: Supaya state management tersedia di seluruh app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ====================================
    // LANGKAH 1: Bikin semua Repository
    // Repository = penghubung antara app dan API
    // ====================================
    final authRepository = AuthRepository(); // Untuk login/register
    final reportRepository = ReportRepository(); // Untuk laporan
    final newsRepository = NewsRepository(); // Untuk berita
    final profileRepository = ProfileRepository(); // Untuk profil user
    final dashboardRepository = DashboardRepository(); // Untuk dashboard

    return MultiRepositoryProvider(
      // Sediakan repository ke seluruh aplikasi
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: reportRepository),
        RepositoryProvider.value(value: newsRepository),
        RepositoryProvider.value(value: profileRepository),
        RepositoryProvider.value(value: dashboardRepository),
      ],
      child: MultiBlocProvider(
        // ====================================
        // LANGKAH 2: Bikin semua Cubit (State Manager)
        // Cubit = pengatur kondisi/state di aplikasi
        // ====================================
        providers: [
          BlocProvider(create: (context) => LoginCubit(authRepository)),
          BlocProvider(create: (context) => RegisterCubit(authRepository)),
          BlocProvider(create: (context) => LogoutCubit(authRepository)),
          BlocProvider(create: (context) => ReportCubit(reportRepository)),
          BlocProvider(create: (context) => NewsCubit(newsRepository)),
          BlocProvider(create: (context) => ProfileCubit(profileRepository)),
          BlocProvider(
            create: (context) => DashboardCubit(dashboardRepository),
          ),
        ],
        child: MaterialApp(
          title: 'Anpundung Mobile',

          // ====================================
          // LANGKAH 3: Setup Tema Aplikasi
          // ====================================
          theme: ThemeData(
            fontFamily: 'Poppins', // Font yang dipakai
            primarySwatch: Colors.blue,
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),

          // ====================================
          // LANGKAH 4: Setup Navigasi (Halaman)
          // ====================================
          initialRoute: AppRouter.login, // Halaman pertama = Login

          routes: {
            // Daftar semua halaman yang bisa diakses
            AppRouter.login: (context) => const LoginScreen(),
            AppRouter.register: (context) => const RegisterScreen(),
            AppRouter.main: (context) => const MainPage(),
            AppRouter.laporan: (context) => const LaporanScreen(),
            '/splash': (context) => const SplashScreen(),
          },
        ),
      ),
    );
  }
}
