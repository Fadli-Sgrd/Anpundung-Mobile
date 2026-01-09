/// ==========================================================
/// FILE: splash_screen.dart
/// DESKRIPSI: Halaman Splash (pembuka) saat aplikasi dibuka
///
/// Halaman ini ditampilkan pertama kali selama 4 detik dengan:
/// - Logo aplikasi Anpundung
/// - Animasi fade in dan scale
/// - Loading indicator
///
/// Setelah 4 detik, otomatis pindah ke halaman Login
/// ==========================================================

import 'package:flutter/material.dart';

/// Widget Splash Screen - halaman pembuka aplikasi
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Controller untuk animasi
  late AnimationController _controller;
  late Animation<double> _fadeAnimation; // Animasi muncul perlahan
  late Animation<double> _scaleAnimation; // Animasi membesar

  @override
  void initState() {
    super.initState();

    // Setup animasi selama 2 detik
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Animasi fade dari transparan ke opaque
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // Animasi scale dari kecil ke normal (dengan efek bouncy)
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    // Mulai animasi
    _controller.forward();

    // Setelah 4 detik, pindah ke halaman login
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Jangan lupa dispose controller!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF163172), Color(0xFF1E56A0), Color(0xFFD6E4F0)],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            'assets/images/logo-anpundung.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.shield_outlined,
                                size: 60,
                                color: Color(0xFF163172),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Anpundung',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Anti Pungutan Liar Bandung',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 50),
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
