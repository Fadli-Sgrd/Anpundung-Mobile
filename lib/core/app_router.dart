/// ==========================================================
/// FILE: app_router.dart
/// DESKRIPSI: Daftar nama-nama route (halaman) di aplikasi
///
/// File ini berisi konstanta nama route supaya:
/// - Tidak typo saat navigasi
/// - Mudah diubah dari satu tempat
/// - Konsisten di seluruh aplikasi
/// ==========================================================

/// Kelas yang berisi semua nama route aplikasi
///
/// Contoh penggunaan:
/// ```dart
/// Navigator.pushNamed(context, AppRouter.login);
/// Navigator.pushReplacementNamed(context, AppRouter.main);
/// ```
class AppRouter {
  // ====================================
  // DAFTAR NAMA ROUTE
  // ====================================

  /// Halaman Login
  static const String login = '/login';

  /// Halaman Registrasi
  static const String register = '/register';

  /// Halaman Utama (berisi Home, Berita, Profile, dll)
  static const String main = '/';

  /// Halaman Home
  static const String home = '/home';

  /// Halaman Profile
  static const String profile = '/profile';

  /// Halaman Pengaturan
  static const String settings = '/settings';

  /// Halaman Edukasi
  static const String edukasi = '/edukasi';

  /// Halaman Daftar Laporan
  static const String laporan = '/laporan';

  // ====================================
  // ROUTE GENERATOR (Opsional)
  // Uncomment jika ingin pakai onGenerateRoute
  // ====================================
  // static Route<dynamic> onGenerateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case login:
  //       return MaterialPageRoute(builder: (_) => const LoginScreen());
  //     case main:
  //       return MaterialPageRoute(builder: (_) => const MainPage());
  //     default:
  //       return MaterialPageRoute(
  //         builder: (_) => const Scaffold(
  //           body: Center(child: Text('Halaman tidak ditemukan!')),
  //         ),
  //       );
  //   }
  // }
}
