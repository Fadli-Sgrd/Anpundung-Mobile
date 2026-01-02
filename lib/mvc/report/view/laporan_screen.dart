import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../report/bloc/report_cubit.dart'; // Import updated path
import '../data/report_model.dart'; // Import updated Data Model
import '../../../components/cards/report_card.dart'; // Path components
import 'laporan_detail_screen.dart'; // Relative path same folder
import 'buat_laporan_screen.dart'; // Relative path same folder
import '../../../components/dialogs/delete_dialog.dart'; // Import custom dialog

class LaporanScreen extends StatefulWidget {
  const LaporanScreen({super.key});

  @override
  State<LaporanScreen> createState() => _LaporanScreenState();
}

class _LaporanScreenState extends State<LaporanScreen> {
  String _selectedCategory = "Semua";
  final List<String> _categories = [
    "Semua",
    "Pungli",
    "Penipuan",
    "Pemerasan",
    "Korupsi",
    "Suap",
    "Lainnya",
  ];

  @override
  void initState() {
    super.initState();
    // Load Reports saat screen dibuka (Best Practice Modul 12)
    // context.read<ReportCubit>().loadReports();
    // Commented out krn mgkn udah di-load di Main? Atau load disini aja biar fresh.
    // Kita load disini aja:
    Future.microtask(() => context.read<ReportCubit>().loadReports());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text(
          "Laporan Saya",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list, color: Colors.white),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF1E56A0),
        onPressed: () async {
          // Slide up from bottom
          await Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const BuatLaporanScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
            ),
          );
          // Refresh data after returning
          if (context.mounted) {
            context.read<ReportCubit>().loadReports();
          }
        },
        elevation: 4,
        icon: const Icon(Icons.add_moderator, color: Colors.white),
        label: const Text(
          "Lapor Pungli",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          // Filter Bubbles
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF163172)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF163172)
                              : Colors.grey[300]!,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[700],
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<ReportCubit, ReportState>(
              builder: (context, state) {
                if (state is ReportLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ReportLoaded && state.reports.isNotEmpty) {
                  // Logic Filtering
                  final filteredReports = _selectedCategory == "Semua"
                      ? state.reports
                      : state.reports
                            .where(
                              (r) => r.category.contains(_selectedCategory),
                            )
                            .toList();

                  if (filteredReports.isEmpty) {
                    return _buildEmptyState(
                      "Tidak ada laporan di kategori ini",
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 80),
                    itemCount: filteredReports.length,
                    itemBuilder: (context, index) {
                      final report = filteredReports[index];
                      return ReportCard(
                        report: report,
                        onDetail: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  LaporanDetailScreen(report: report),
                            ),
                          );
                        },
                        onDelete: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => DeleteDialog(
                              onCancel: () => Navigator.pop(ctx),
                              onConfirm: () {
                                context.read<ReportCubit>().deleteReport(
                                  report.id,
                                );
                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Laporan berhasil dihapus"),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                }

                if (state is ReportError) {
                  return Center(child: Text(state.message));
                }

                // Empty State
                return _buildEmptyState("Belum ada laporan");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.folder_open_rounded,
              size: 60,
              color: Color(0xFFD6E4F0),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "Ayo bantu berantas pungli di Bandung!",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
