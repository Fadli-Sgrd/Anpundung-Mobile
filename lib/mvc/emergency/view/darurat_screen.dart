import 'package:flutter/material.dart';

class DaruratScreen extends StatelessWidget {
  const DaruratScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> emergencyContacts = [
      {
        "name": "Polda Jawa Barat",
        "phone": "110",
        "desc": "Nomor darurat kepolisian",
        "icon": Icons.local_police,
        "color": Colors.blue,
      },
      {
        "name": "Ditreskrimsus Polda Jawa Barat",
        "phone": "(022) 520-8214",
        "desc": "Direktorat Tindak Pidana Khusus",
        "icon": Icons.shield_outlined,
        "color": Colors.indigo,
      },
      {
        "name": "Satgas Saber Pungli",
        "phone": "(022) 2030-0111",
        "desc": "Satuan Tugas Pemberantasan Pungli Bandung",
        "icon": Icons.groups,
        "color": Colors.red,
      },
      {
        "name": "LPSK (Lembaga Perlindungan Saksi)",
        "phone": "(021) 391-8181",
        "desc": "Melindungi kesaksian korban pungli",
        "icon": Icons.security,
        "color": Colors.orange,
      },
      {
        "name": "KPK (Komisi Pemberantasan Korupsi)",
        "phone": "157",
        "desc": "Melayani pengaduan korupsi & pungli",
        "icon": Icons.gavel,
        "color": Colors.purple,
      },
      {
        "name": "Dinas Pelayanan Terpadu Satu Pintu",
        "phone": "(022) 250-1212",
        "desc": "Pengaduan layanan publik berbelit",
        "icon": Icons.apartment,
        "color": Colors.teal,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text(
          "Nomor Darurat",
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD32F2F), Color(0xFFC62828)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Icon(Icons.emergency, color: Colors.white, size: 50),
                  SizedBox(height: 10),
                  Text(
                    "Nomor Darurat",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Hubungi nomor dibawah jika Anda dalam keadaan darurat atau berada dalam bahaya",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            ...emergencyContacts.map(
              (contact) => Container(
                margin: const EdgeInsets.only(bottom: 15),
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
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (contact["color"] as Color).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      contact["icon"] as IconData,
                      color: contact["color"] as Color,
                      size: 24,
                    ),
                  ),
                  title: Text(
                    contact["name"] as String,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF163172),
                    ),
                  ),
                  subtitle: Text(
                    contact["desc"] as String,
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(contact["name"] as String),
                          content: Text("Nomor: ${contact["phone"]}"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text("Tutup"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E56A0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        contact["phone"] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFFBBDEFB), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        color: Color(0xFF1976D2),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Tips Keselamatan",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "• Jangan memberikan uang lebih jika dipaksa\n• Ingat wajah/ciri-ciri pelaku\n• Catat waktu dan lokasi kejadian\n• Lapor ke petugas terdekat\n• Hubungi nomor darurat jika ada kekerasan",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[800],
                      height: 1.6,
                    ),
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
}
