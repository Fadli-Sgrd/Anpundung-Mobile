import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifikasiLaporan = true;
  bool notifikasiBerita = true;
  bool notifikasiUpdate = true;
  bool darkMode = false;
  String selectedLanguage = "Indonesia";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text("Pengaturan", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF163172),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Settings
            const Text(
              "Notifikasi",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF163172),
              ),
            ),
            const SizedBox(height: 15),
            _buildSettingsTile(
              icon: Icons.notifications_active,
              title: "Notifikasi Laporan",
              subtitle: "Dapatkan update status laporan Anda",
              value: notifikasiLaporan,
              onChanged: (val) => setState(() => notifikasiLaporan = val),
            ),
            _buildSettingsTile(
              icon: Icons.newspaper,
              title: "Notifikasi Berita",
              subtitle: "Notifikasi berita terbaru",
              value: notifikasiBerita,
              onChanged: (val) => setState(() => notifikasiBerita = val),
            ),
            _buildSettingsTile(
              icon: Icons.info,
              title: "Notifikasi Update",
              subtitle: "Update fitur dan perbaikan app",
              value: notifikasiUpdate,
              onChanged: (val) => setState(() => notifikasiUpdate = val),
            ),
            const SizedBox(height: 25),

            // Display Settings
            const Text(
              "Tampilan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF163172),
              ),
            ),
            const SizedBox(height: 15),
            _buildSettingsTile(
              icon: Icons.dark_mode,
              title: "Dark Mode",
              subtitle: "Aktifkan tema gelap",
              value: darkMode,
              onChanged: (val) => setState(() => darkMode = val),
            ),
            const SizedBox(height: 25),

            // Language Settings
            const Text(
              "Bahasa",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF163172),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E56A0).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.language, color: Color(0xFF1E56A0), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Pilih Bahasa",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF163172),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          selectedLanguage,
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedLanguage,
                    items: const [
                      DropdownMenuItem(value: "Indonesia", child: Text("Indonesia")),
                      DropdownMenuItem(value: "English", child: Text("English")),
                      DropdownMenuItem(value: "Sunda", child: Text("Sunda")),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => selectedLanguage = val);
                      }
                    },
                    underline: const SizedBox(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Account Settings
            const Text(
              "Akun",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF163172),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(16),
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
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.logout, color: Colors.red, size: 20),
                    ),
                    title: const Text(
                      "Keluar Akun",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                    onTap: () {
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Anda telah keluar")),
                                );
                              },
                              child: const Text("Keluar", style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1E56A0).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF1E56A0), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF163172),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: const Color(0xFF1E56A0),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
