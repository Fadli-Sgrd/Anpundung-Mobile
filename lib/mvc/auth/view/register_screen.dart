import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          // ✅ Register sukses - navigasi ke main
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registrasi berhasil! Selamat datang.'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.of(context).pushReplacementNamed('/main');
        } else if (state is RegisterFailure) {
          // ❌ Register gagal - tampilkan error
          String errorMsg = state.message;
          
          // Jika ada errors per field, tampilkan field error
          if (state.errors.isNotEmpty) {
            final errorList = state.errors.entries.toList();
            if (errorList.isNotEmpty) {
              final firstError = errorList.first.value;
              if (firstError is List && firstError.isNotEmpty) {
                errorMsg = '${errorList.first.key}: ${firstError.first}';
              }
            }
          }
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF163172), Color(0xFF1E56A0), Color(0xFFD6E4F0)],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 30),
                      // Logo
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/logo-anpundung.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.shield_outlined,
                                  size: 40,
                                  color: Color(0xFF163172),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        'Buat Akun Baru',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Bergabunglah dengan kami',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      // Form Container
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildTextField(
                              _nameController,
                              'Nama Lengkap',
                              Icons.person,
                              false,
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              _emailController,
                              'Email',
                              Icons.email,
                              false,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              _passwordController,
                              'Password',
                              Icons.lock,
                              true,
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              _confirmPasswordController,
                              'Konfirmasi Password',
                              Icons.lock_outline,
                              true,
                            ),
                            const SizedBox(height: 25),
                            // 🔘 TOMBOL DAFTAR - UPDATED
                            BlocBuilder<RegisterCubit, RegisterState>(
                              builder: (context, state) {
                                final isLoading = state is RegisterLoading;
                                
                                return ElevatedButton(
                                  onPressed: isLoading ? null : () {
                                    // Validasi lokal
                                    if (_nameController.text.isEmpty) {
                                      _showError(context, 'Nama tidak boleh kosong');
                                      return;
                                    }
                                    if (_emailController.text.isEmpty) {
                                      _showError(context, 'Email tidak boleh kosong');
                                      return;
                                    }
                                    if (!_isValidEmail(_emailController.text)) {
                                      _showError(context, 'Format email tidak valid');
                                      return;
                                    }
                                    if (_passwordController.text.isEmpty) {
                                      _showError(context, 'Password tidak boleh kosong');
                                      return;
                                    }
                                    if (_passwordController.text.length < 8) {
                                      _showError(context, 'Password minimal 8 karakter');
                                      return;
                                    }
                                    if (_passwordController.text != _confirmPasswordController.text) {
                                      _showError(context, 'Password tidak cocok');
                                      return;
                                    }
                                    
                                    // Panggil register
                                    context.read<RegisterCubit>().register(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    backgroundColor: const Color(0xFF163172),
                                    foregroundColor: Colors.white,
                                    elevation: 5,
                                    disabledBackgroundColor: Colors.grey,
                                  ),
                                  child: isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          'Daftar',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                'Sudah punya akun? Masuk',
                                style: TextStyle(
                                  color: Color(0xFF163172),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method untuk tampil error snackbar (BARU)
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Helper method untuk validasi email format
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
    bool obscure, {
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF163172)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF163172)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF1E56A0), width: 2),
        ),
        prefixIcon: Icon(icon, color: const Color(0xFF163172)),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
      ),
    );
  }
}
