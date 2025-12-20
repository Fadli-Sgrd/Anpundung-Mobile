import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE), // Background agak kebiruan dikit 
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Color(0xFF163172), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF163172)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            
            //ID CARD
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                // Gradasi Biru ke Ungu dikit biar modern
                gradient: const LinearGradient(
                  colors: [Color(0xFF163172), Color(0xFF1E56A0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
                // Bayangan Biru (Glowing Shadow)
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1E56A0).withOpacity(0.4),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Avatar dengan Border Putih Transparan
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage("https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cGVyc29ufGVufDB8fDB8fHww"),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Info User
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jajang Gunawan",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Jajang@gmail.com",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  // Statistik Kecil di dalam kartu
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1), // Glass effect
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _StatItemWhite(label: "Laporan", value: "12"),
                        _StatItemWhite(label: "Diproses", value: "5"),
                        _StatItemWhite(label: "Selesai", value: "7"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            //MENU OPTIONS
            const Text(
              "Pengaturan Akun",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF163172)),
            ),
            const SizedBox(height: 15),

            _buildAestheticTile(
              icon: Icons.person_rounded,
              color: Colors.blueAccent,
              title: "Edit Profil",
              subtitle: "Ubah foto & data diri",
              onTap: () {},
            ),
            _buildAestheticTile(
              icon: Icons.lock_rounded,
              color: Colors.orangeAccent,
              title: "Kata Sandi",
              subtitle: "Update keamanan akun",
              onTap: () {},
            ),
            _buildAestheticTile(
              icon: Icons.history_rounded,
              color: Colors.purpleAccent,
              title: "Riwayat Aktivitas",
              subtitle: "Log laporan anda",
              onTap: () {},
            ),

            const SizedBox(height: 25),
            const Text(
              "Lainnya",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF163172)),
            ),
            const SizedBox(height: 15),

            _buildAestheticTile(
              icon: Icons.help_outline_rounded,
              color: Colors.teal,
              title: "Bantuan",
              subtitle: "FAQ & Kontak Admin",
              onTap: () {},
            ),

            const SizedBox(height: 30),

            //LOGOUT BUTTON
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.red[400],
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.red[50],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout_rounded, size: 20),
                  SizedBox(width: 8),
                  Text("Keluar Aplikasi", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  //WIDGET HELPER

  // Tile Menu yang Aesthetic
  Widget _buildAestheticTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05), // Bayangan sangat tipis
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1), // Background icon pastel
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
        ),
      ),
    );
  }
}

// Widget Stat khusus warna putih (untuk di dalam kartu biru)
class _StatItemWhite extends StatelessWidget {
  final String label;
  final String value;
  const _StatItemWhite({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.white70),
        ),
      ],
    );
  }
}