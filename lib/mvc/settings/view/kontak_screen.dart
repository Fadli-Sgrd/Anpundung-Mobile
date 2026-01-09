import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/kontak_cubit.dart';

/// Screen Kontak Admin
///
/// Screen ini menampilkan form untuk mengirim pesan ke tim admin/support.
/// User bisa mengirim pertanyaan, keluhan, atau saran.
///
/// Integrasi API:
/// - POST /api/kontak untuk mengirim pesan
/// - Menggunakan KontakCubit untuk state management
class KontakScreen extends StatefulWidget {
  const KontakScreen({super.key});

  @override
  State<KontakScreen> createState() => _KontakScreenState();
}

class _KontakScreenState extends State<KontakScreen> {
  // Controllers untuk form input
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _pesanController = TextEditingController();

  // Form key untuk validasi
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose controllers untuk menghindari memory leak
    _namaController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _pesanController.dispose();
    super.dispose();
  }

  /// Clear semua form field setelah berhasil kirim
  void _clearForm() {
    _namaController.clear();
    _emailController.clear();
    _subjectController.clear();
    _pesanController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text(
          "Kontak Admin",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF163172),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E56A0), Color(0xFF163172)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Icon(Icons.contact_mail, color: Colors.white, size: 50),
                  SizedBox(height: 10),
                  Text(
                    "Hubungi Kami",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Kirim pertanyaan, saran, atau keluhan Anda",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Info Card
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue[700], size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Tim kami akan merespons pesan Anda dalam waktu 1x24 jam kerja.",
                      style: TextStyle(fontSize: 12, color: Colors.blue[800]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Form Section Title
            const Text(
              "Formulir Kontak",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF163172),
              ),
            ),
            const SizedBox(height: 15),

            // Form Container dengan BlocProvider
            BlocProvider(
              create: (_) => KontakCubit(),
              child: BlocConsumer<KontakCubit, KontakState>(
                listener: (context, state) {
                  if (state is KontakSuccess) {
                    // Tampilkan snackbar sukses
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.white),
                            const SizedBox(width: 8),
                            Expanded(child: Text(state.message)),
                          ],
                        ),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                    // Clear form setelah sukses
                    _clearForm();
                    // Reset state cubit
                    context.read<KontakCubit>().reset();
                  } else if (state is KontakError) {
                    // Tampilkan snackbar error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(Icons.error, color: Colors.white),
                            const SizedBox(width: 8),
                            Expanded(child: Text(state.error)),
                          ],
                        ),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state is KontakLoading;

                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Field Nama
                          TextFormField(
                            controller: _namaController,
                            enabled: !isLoading,
                            decoration: InputDecoration(
                              labelText: "Nama Lengkap",
                              hintText: "Masukkan nama Anda",
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Color(0xFF1E56A0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF6F6F6),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),

                          // Field Email
                          TextFormField(
                            controller: _emailController,
                            enabled: !isLoading,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "contoh@email.com",
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Color(0xFF1E56A0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF6F6F6),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email tidak boleh kosong';
                              }
                              if (!RegExp(
                                r'^[^@]+@[^@]+\.[^@]+',
                              ).hasMatch(value)) {
                                return 'Format email tidak valid';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),

                          // Field Subject
                          TextFormField(
                            controller: _subjectController,
                            enabled: !isLoading,
                            decoration: InputDecoration(
                              labelText: "Subjek",
                              hintText: "Topik pesan Anda",
                              prefixIcon: const Icon(
                                Icons.subject,
                                color: Color(0xFF1E56A0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF6F6F6),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Subjek tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),

                          // Field Pesan
                          TextFormField(
                            controller: _pesanController,
                            enabled: !isLoading,
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: "Pesan",
                              hintText: "Tulis pesan Anda di sini...",
                              alignLabelWithHint: true,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(bottom: 80),
                                child: Icon(
                                  Icons.message,
                                  color: Color(0xFF1E56A0),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF6F6F6),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Pesan tidak boleh kosong';
                              }
                              if (value.length < 10) {
                                return 'Pesan minimal 10 karakter';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Tombol Kirim
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E56A0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                disabledBackgroundColor: Colors.grey[400],
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<KontakCubit>().kirimPesan(
                                          nama: _namaController.text.trim(),
                                          email: _emailController.text.trim(),
                                          subject: _subjectController.text
                                              .trim(),
                                          message: _pesanController.text.trim(),
                                        );
                                      }
                                    },
                              child: isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    )
                                  : const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.send, color: Colors.white),
                                        SizedBox(width: 8),
                                        Text(
                                          "Kirim Pesan",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
