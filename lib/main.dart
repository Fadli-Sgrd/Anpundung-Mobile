import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/app_router.dart';
import 'mvc/auth/bloc/login_cubit.dart';
import 'mvc/auth/data/auth_repository.dart';
import 'mvc/report/bloc/report_cubit.dart';
import 'mvc/report/data/report_repository.dart';
import 'mvc/auth/view/login_screen.dart';
import 'mvc/auth/view/register_screen.dart';
import 'mvc/report/view/laporan_screen.dart';
import 'mvc/splash/view/splash_screen.dart';
import 'mvc/main/view/main_page.dart';
import 'mvc/settings/view/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Dependency Injection Repository
    final authRepository = AuthRepository();
    final reportRepository = ReportRepository();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: reportRepository),
      ],
      child: MultiBlocProvider(
        // 2. Global Blocs
        providers: [
          BlocProvider(create: (context) => LoginCubit(authRepository)),
          BlocProvider(create: (context) => ReportCubit(reportRepository)),
        ],
        child: MaterialApp(
          title: 'Anpundung Mobile',
          theme: ThemeData(
            fontFamily: 'Poppins', // Sesuai design original
            primarySwatch: Colors.blue,
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          // 3. Navigation Setup
          initialRoute: AppRouter.login,

          routes: {
            // Mapping Routes dari AppRouter
            AppRouter.login: (context) => const LoginScreen(),
            AppRouter.register: (context) => const RegisterScreen(),
            AppRouter.main: (context) => const MainPage(),
            AppRouter.laporan: (context) => const LaporanScreen(),
            // Tambahkan route splash screen jika perlu
            '/splash': (context) => const SplashScreen(),
          },
        ),
      ),
    );
  }
}
