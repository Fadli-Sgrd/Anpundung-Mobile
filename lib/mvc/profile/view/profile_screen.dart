import 'package:flutter/material.dart';
import '../../../components/cards/profile_card.dart';
import '../../../components/common/aesthetic_tile.dart';
import 'edit_profile_screen.dart';
import '../../report/view/laporan_screen.dart';
import '../../news/view/berita_tersimpan_screen.dart';
import '../../settings/view/settings_screen.dart';
import '../../settings/view/feedback_screen.dart';
import '../../settings/view/about_screen.dart';
import '../../settings/view/bantuan_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

            // Profile Card
            const ProfileCard(
              name: "Aubrey Karin",
              email: "AubreyKarin@gmail.com",
              imageUrl:
                  "https://images.unsplash.com/photo-1702482527875-e16d07f0d91b?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzB8fHBob3RvJTIwcHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
              totalLaporan: 12,
              diproses: 5,
              selesai: 7,
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
              onPressed: () {},
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
