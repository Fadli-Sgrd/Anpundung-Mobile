import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/report_cubit.dart';
import '../components/cards/report_card.dart';
import 'laporan_detail_screen.dart';
import 'buat_laporan_screen.dart';

class LaporanScreen extends StatefulWidget {
  const LaporanScreen({super.key});

  @override
  State<LaporanScreen> createState() => _LaporanScreenState();
}

class _LaporanScreenState extends State<LaporanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF1E56A0),
        onPressed: () {
          // Slide up from bottom
          Navigator.push(
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
          // Header Gradient dengan ROUNDED BOTTOM
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF163172), Color(0xFF1E56A0)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Laporan Saya",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          // Content
          Expanded(
            child: BlocBuilder<ReportCubit, ReportState>(
              builder: (context, state) {
                if (state is ReportLoaded && state.reports.isNotEmpty) {
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
                    itemCount: state.reports.length,
                    itemBuilder: (context, index) {
                      final report = state.reports[index];
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
                        onDelete: () =>
                            context.read<ReportCubit>().deleteReport(report.id),
                      );
                    },
                  );
                }

                // Empty State
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
                        "Belum ada laporan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Ayo bantu berantas pungli di Bandung!",
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
