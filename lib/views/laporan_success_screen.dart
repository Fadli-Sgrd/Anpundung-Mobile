import 'package:flutter/material.dart';

class LaporanSuccessScreen extends StatefulWidget {
  const LaporanSuccessScreen({super.key});

  @override
  State<LaporanSuccessScreen> createState() => _LaporanSuccessScreenState();
}

class _LaporanSuccessScreenState extends State<LaporanSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF163172), Color(0xFF1E56A0)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Animated Check Icon
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1E56A0),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              // Text
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    const Text(
                      "Terima kasih karena sudah\nmelaporkan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Laporanmu akan ditinjau oleh sistem AI Kami.\nTerimakasih sudah melaporkan!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Button
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E56A0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text(
                      "Kembali ke Beranda",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
