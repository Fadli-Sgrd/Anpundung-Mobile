import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/cards/profile_card.dart';
import '../../../components/common/aesthetic_tile.dart';
import '../../auth/bloc/logout_cubit.dart';
import '../../auth/data/auth_repository.dart';
import '../../report/bloc/report_cubit.dart';
import 'edit_profile_screen.dart';
import '../../report/view/laporan_screen.dart';
import '../../news/view/berita_tersimpan_screen.dart';
import '../../settings/view/settings_screen.dart';
import '../../settings/view/feedback_screen.dart';
import '../../settings/view/about_screen.dart';
import '../../settings/view/bantuan_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = "Memuat...";
  String _email = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
    // Load reports to get fresh stats
    Future.microtask(() => context.read<ReportCubit>().loadReports());
  }

  Future<void> _loadUserData() async {
    final userData = await AuthRepository().getUserData();
    if (mounted) {
      setState(() {
        _name = userData['name'] ?? "Warga Bandung";
        _email = userData['email'] ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/login', (route) => false);
        } else if (state is LogoutFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error: ${state.error}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: _buildScaffold(context),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          "Profile",
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
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Profile Card with Dynamic Data
            BlocBuilder<ReportCubit, ReportState>(
              builder: (context, state) {
                int total = 0;
                int proses = 0;
                int selesai = 0;

                if (state is ReportLoaded) {
                  total = state.reports.length;
                  proses = state.reports
                      .where(
                        (r) =>
                            r.status.toLowerCase() == 'proses' ||
                            r.status.toLowerCase() == 'diproses',
                      )
                      .length;
                  selesai = state.reports
                      .where((r) => r.status.toLowerCase() == 'selesai')
                      .length;
                }

                return ProfileCard(
                  name: _name,
                  email: _email,
                  imageUrl:
                      "https://ui-avatars.com/api/?name=${Uri.encodeComponent(_name)}&background=random",
                  totalLaporan: total,
                  diproses: proses,
                  selesai: selesai,
                );
              },
            ),

            const SizedBox(height: 30),

            // MENU OPTIONS
            const Text(
              "Pengaturan Akun",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF163172),
              ),
            ),
            const SizedBox(height: 15),

            AestheticTile(
              icon: Icons.person_rounded,
              color: Colors.blueAccent,
              title: "Edit Profil",
              subtitle: "Ubah foto & data diri",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              },
            ),
            AestheticTile(
              icon: Icons.lock_rounded,
              color: Colors.orangeAccent,
              title: "Kata Sandi",
              subtitle: "Update keamanan akun",
              onTap: () {},
            ),
            AestheticTile(
              icon: Icons.history_rounded,
              color: Colors.purpleAccent,
              title: "Riwayat Aktivitas",
              subtitle: "Log laporan anda",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LaporanScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 25),
            const Text(
              "Lainnya",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF163172),
              ),
            ),
            const SizedBox(height: 15),

            AestheticTile(
              icon: Icons.bookmark_rounded,
              color: Colors.orange,
              title: "Berita Tersimpan",
              subtitle: "Koleksi berita favorit Anda",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BeritaTersimpanScreen(),
                  ),
                );
              },
            ),
            AestheticTile(
              icon: Icons.star_rounded,
              color: Colors.amber,
              title: "Rating & Feedback",
              subtitle: "Bagikan pendapat Anda",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FeedbackScreen(),
                  ),
                );
              },
            ),
            AestheticTile(
              icon: Icons.settings_rounded,
              color: Colors.blueGrey,
              title: "Pengaturan",
              subtitle: "Notifikasi, tema, bahasa",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
            AestheticTile(
              icon: Icons.help_outline_rounded,
              color: Colors.teal,
              title: "Bantuan & FAQ",
              subtitle: "FAQ & Kontak Admin",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BantuanScreen(),
                  ),
                );
              },
            ),
            AestheticTile(
              icon: Icons.info_outline_rounded,
              color: Colors.cyan,
              title: "Tentang Aplikasi",
              subtitle: "Versi dan informasi app",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),

            const SizedBox(height: 30),

            // LOGOUT BUTTON
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Konfirmasi Keluar"),
                    content: const Text("Anda yakin ingin keluar dari akun?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text("Batal"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          context.read<LogoutCubit>().logout();
                        },
                        child: const Text(
                          "Keluar",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red[400],
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.red[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout_rounded, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Keluar Aplikasi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
