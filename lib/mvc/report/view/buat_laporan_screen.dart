import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../report/bloc/report_cubit.dart';
import '../../report/bloc/kategori_cubit.dart';
import 'laporan_success_screen.dart';

class BuatLaporanScreen extends StatefulWidget {
  const BuatLaporanScreen({super.key});

  @override
  State<BuatLaporanScreen> createState() => _BuatLaporanScreenState();
}

class _BuatLaporanScreenState extends State<BuatLaporanScreen>
    with SingleTickerProviderStateMixin {
  final _lokasiController = TextEditingController();
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  String? selectedDate;
  String? selectedTime;
  List<String> selectedCategories = [];
  List<String> uploadedPhotos = [];

  late AnimationController _animController;
  final KategoriCubit _kategoriCubit = KategoriCubit();

  // Icon mapping berdasarkan nama kategori
  IconData _getCategoryIcon(String nama) {
    final lowerName = nama.toLowerCase();
    if (lowerName.contains('begal') || lowerName.contains('perampokan')) {
      return Icons.warning_amber_rounded;
    } else if (lowerName.contains('jalan') || lowerName.contains('sepi')) {
      return Icons.streetview_rounded;
    } else if (lowerName.contains('kebakaran') || lowerName.contains('api')) {
      return Icons.local_fire_department_rounded;
    } else if (lowerName.contains('tawuran') ||
        lowerName.contains('kerusuhan')) {
      return Icons.nights_stay_rounded;
    } else if (lowerName.contains('kecelakaan') || lowerName.contains('laka')) {
      return Icons.car_crash_rounded;
    } else if (lowerName.contains('banjir') || lowerName.contains('air')) {
      return Icons.water_rounded;
    } else if (lowerName.contains('pungli') || lowerName.contains('pungutan')) {
      return Icons.money_off_rounded;
    } else if (lowerName.contains('korupsi')) {
      return Icons.gavel_rounded;
    } else if (lowerName.contains('pencurian') || lowerName.contains('curi')) {
      return Icons.security_rounded;
    } else if (lowerName.contains('narkoba') || lowerName.contains('obat')) {
      return Icons.medication_rounded;
    } else if (lowerName.contains('sampah') || lowerName.contains('limbah')) {
      return Icons.delete_rounded;
    } else if (lowerName.contains('lampu') || lowerName.contains('listrik')) {
      return Icons.lightbulb_outline_rounded;
    } else if (lowerName.contains('judi') || lowerName.contains('gambling')) {
      return Icons.casino_rounded;
    } else {
      return Icons.report_problem_outlined;
    }
  }

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    // Load kategori dari API
    _kategoriCubit.loadKategori();
  }

  @override
  void dispose() {
    _lokasiController.dispose();
    _judulController.dispose();
    _deskripsiController.dispose();
    _animController.dispose();
    _kategoriCubit.close();
    super.dispose();
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime =
            "${picked.hour}:${picked.minute.toString().padLeft(2, '0')} WIB";
      });
    }
  }

  void _submitReport() async {
    if (selectedCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pilih minimal satu kategori!")),
      );
      return;
    }
    if (_judulController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Judul laporan wajib diisi!")),
      );
      return;
    }

    // Format Date from DD/MM/YYYY to YYYY-MM-DD
    String dateToSend;
    if (selectedDate == null) {
      dateToSend = DateTime.now().toIso8601String().split('T')[0];
    } else {
      final parts = selectedDate!.split('/');
      if (parts.length == 3) {
        dateToSend = "${parts[2]}-${parts[1]}-${parts[0]}";
      } else {
        dateToSend = DateTime.now().toIso8601String().split('T')[0];
      }
    }

    final mainCategory = selectedCategories.first;
    final location = _lokasiController.text.isNotEmpty
        ? _lokasiController.text
        : "Bandung";

    await context.read<ReportCubit>().addReport(
      _judulController.text, // Use User Input Title
      _deskripsiController.text,
      location,
      mainCategory,
      dateToSend,
    );

    // Navigate to success screen with animation
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LaporanSuccessScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF163172), Color(0xFF1E56A0)],
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Buat Laporan",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lokasi Section - Modern Card Style
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.location_on_rounded,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Lokasi Kejadian",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF2D3436),
                                  ),
                                ),
                                Text(
                                  "Masukkan alamat lokasi kejadian",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _lokasiController,
                          decoration: InputDecoration(
                            hintText: "Contoh: Jl. Asia Afrika No. 1, Bandung",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Colors.grey[400],
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF5F7FA),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFF11998e),
                                width: 1.5,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tanggal & Waktu - Modern Style
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.schedule_rounded,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Waktu Kejadian",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF2D3436),
                                  ),
                                ),
                                Text(
                                  "Kapan kejadian ini terjadi?",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            // Tanggal
                            Expanded(
                              child: GestureDetector(
                                onTap: _selectDate,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5F7FA),
                                    borderRadius: BorderRadius.circular(12),
                                    border: selectedDate != null
                                        ? Border.all(
                                            color: const Color(0xFFf5576c),
                                            width: 1.5,
                                          )
                                        : null,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_rounded,
                                        size: 18,
                                        color: selectedDate != null
                                            ? const Color(0xFFf5576c)
                                            : Colors.grey[400],
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          selectedDate ?? "Pilih tanggal",
                                          style: TextStyle(
                                            color: selectedDate != null
                                                ? const Color(0xFF2D3436)
                                                : Colors.grey[400],
                                            fontWeight: selectedDate != null
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Waktu
                            Expanded(
                              child: GestureDetector(
                                onTap: _selectTime,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5F7FA),
                                    borderRadius: BorderRadius.circular(12),
                                    border: selectedTime != null
                                        ? Border.all(
                                            color: const Color(0xFFf5576c),
                                            width: 1.5,
                                          )
                                        : null,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_rounded,
                                        size: 18,
                                        color: selectedTime != null
                                            ? const Color(0xFFf5576c)
                                            : Colors.grey[400],
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          selectedTime ?? "Pilih waktu",
                                          style: TextStyle(
                                            color: selectedTime != null
                                                ? const Color(0xFF2D3436)
                                                : Colors.grey[400],
                                            fontWeight: selectedTime != null
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Kategori Keluhan - dari API
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        const Text(
                          "Apa Keluhanmu dijalan ini?",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Color(0xFF2D3436),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Kategori dari API
                        BlocBuilder<KategoriCubit, KategoriState>(
                          bloc: _kategoriCubit,
                          builder: (context, state) {
                            if (state is KategoriLoading) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            if (state is KategoriError) {
                              return Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.grey[400],
                                      size: 40,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      state.message,
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          _kategoriCubit.loadKategori(),
                                      child: const Text("Coba Lagi"),
                                    ),
                                  ],
                                ),
                              );
                            }

                            if (state is KategoriLoaded) {
                              final kategoris = state.kategoris;
                              final unselectedKategoris = kategoris
                                  .where(
                                    (k) => !selectedCategories.contains(k.nama),
                                  )
                                  .toList();

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Baris kategori yang BELUM dipilih (icon + text vertikal)
                                  if (unselectedKategoris.isNotEmpty)
                                    Wrap(
                                      spacing: 16,
                                      runSpacing: 12,
                                      children: unselectedKategoris.map((
                                        kategori,
                                      ) {
                                        final icon = _getCategoryIcon(
                                          kategori.nama,
                                        );
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedCategories.add(
                                                kategori.nama,
                                              );
                                            });
                                          },
                                          child: SizedBox(
                                            width: 70,
                                            child: Column(
                                              children: [
                                                Icon(
                                                  icon,
                                                  size: 24,
                                                  color: Colors.grey[600],
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  kategori.nama,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[700],
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),

                                  // Box untuk kategori yang SUDAH dipilih + deskripsi
                                  if (selectedCategories.isNotEmpty) ...[
                                    const SizedBox(height: 16),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Chips kategori terpilih
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: selectedCategories.asMap().entries.map((
                                              entry,
                                            ) {
                                              final index = entry.key;
                                              final nama = entry.value;
                                              final icon = _getCategoryIcon(
                                                nama,
                                              );

                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectedCategories.remove(
                                                      nama,
                                                    );
                                                  });
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 6,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                    border: Border.all(
                                                      color: const Color(
                                                        0xFF0D7377,
                                                      ),
                                                      width: 1.5,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      // Icon dengan badge nomor
                                                      Stack(
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          Icon(
                                                            icon,
                                                            size: 18,
                                                            color: const Color(
                                                              0xFF0D7377,
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: -6,
                                                            right: -6,
                                                            child: Container(
                                                              width: 14,
                                                              height: 14,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                    color: Color(
                                                                      0xFF0D7377,
                                                                    ),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                              child: Center(
                                                                child: Text(
                                                                  '${index + 1}',
                                                                  style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: 9,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        nama,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color(
                                                            0xFF0D7377,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          const SizedBox(height: 12),
                                          // Text field deskripsi
                                          Text(
                                            "Deskripsikan secara detail!",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              );
                            }

                            return const SizedBox();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Detail Laporan Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.edit_note_rounded,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Detail Laporan",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF2D3436),
                                  ),
                                ),
                                Text(
                                  "Jelaskan dengan lengkap dan jelas",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Judul Field
                        TextField(
                          controller: _judulController,
                          decoration: InputDecoration(
                            labelText: "Judul Laporan",
                            hintText: "Contoh: Ada Pungli di Jalan ABC",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            labelStyle: const TextStyle(
                              color: Color(0xFF4facfe),
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: const Icon(
                              Icons.title_rounded,
                              color: Color(0xFF4facfe),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF5F7FA),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFF4facfe),
                                width: 1.5,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        // Deskripsi Field
                        TextField(
                          controller: _deskripsiController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: "Deskripsi Lengkap",
                            hintText:
                                "Ceritakan kronologi kejadian secara detail...",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            labelStyle: const TextStyle(
                              color: Color(0xFF4facfe),
                              fontWeight: FontWeight.w500,
                            ),
                            alignLabelWithHint: true,
                            filled: true,
                            fillColor: const Color(0xFFF5F7FA),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFF4facfe),
                                width: 1.5,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Upload Bukti Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.photo_camera_rounded,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bukti Pendukung",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF2D3436),
                                  ),
                                ),
                                Text(
                                  "Foto/video max 50MB (opsional)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Upload Button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              uploadedPhotos.add(
                                "https://picsum.photos/200?random=${DateTime.now().millisecondsSinceEpoch}",
                              );
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFFfa709a).withOpacity(0.1),
                                  const Color(0xFFfee140).withOpacity(0.1),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFfa709a).withOpacity(0.3),
                                width: 1.5,
                                strokeAlign: BorderSide.strokeAlignInside,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFFfa709a,
                                        ).withOpacity(0.3),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.add_photo_alternate_rounded,
                                    size: 28,
                                    color: Color(0xFFfa709a),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Tap untuk upload foto/video",
                                  style: TextStyle(
                                    color: Color(0xFFfa709a),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "JPG, PNG, MP4 • Max 50MB",
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Photo Preview
                        if (uploadedPhotos.isNotEmpty) ...[
                          const SizedBox(height: 14),
                          SizedBox(
                            height: 90,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: uploadedPhotos.length,
                              itemBuilder: (ctx, idx) => Stack(
                                children: [
                                  Container(
                                    width: 90,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          uploadedPhotos[idx],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 14,
                                    child: GestureDetector(
                                      onTap: () => setState(
                                        () => uploadedPhotos.removeAt(idx),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red[400],
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.2,
                                              ),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.close_rounded,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Submit Button - Modern Style
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _submitReport,
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF163172), Color(0xFF1E56A0)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send_rounded, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            "Kirim Laporan",
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
