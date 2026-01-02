import 'package:flutter/material.dart';
import '../../../components/cards/stat_card.dart';
import '../../../components/buttons/menu_button.dart';
import '../../../components/cards/news_card.dart';
import '../../../components/common/header_section.dart';
import '../../education/view/edukasi_screen.dart';
import '../../settings/view/panduan_screen.dart';
import '../../emergency/view/darurat_screen.dart';
import '../../news/view/berita_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER GANTENG ---
            HeaderSection(
              greeting: "Selamat Pagi,",
              userName: "Aubrey Karin",
              userImageUrl:
                  "https://images.unsplash.com/photo-1702482527875-e16d07f0d91b?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzB8fHBob3RvJTIwcHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
              bottomWidget: const StatCard(
                items: [
                  StatItemData(
                    label: "Total",
                    count: "12",
                    icon: Icons.folder_copy_outlined,
                  ),
                  StatItemData(label: "Proses", count: "5", icon: Icons.loop),
                  StatItemData(
                    label: "Selesai",
                    count: "7",
                    icon: Icons.check_circle_outline,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Layanan Utama",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF163172),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MenuButton(
                        title: "Edukasi",
                        icon: Icons.school_rounded,
                        color: const Color(0xFF1E56A0),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EdukasiScreen(),
                            ),
                          );
                        },
                      ),
                      MenuButton(
                        title: "Panduan",
                        icon: Icons.book_rounded,
                        color: Colors.orange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PanduanScreen(),
                            ),
                          );
                        },
                      ),
                      MenuButton(
                        title: "Darurat",
                        icon: Icons.phone_in_talk_rounded,
                        color: Colors.red,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DaruratScreen(),
                            ),
                          );
                        },
                      ),
                      MenuButton(
                        title: "Lainnya",
                        icon: Icons.grid_view_rounded,
                        color: Colors.grey,
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- KONTEN BAWAH ---
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Berita Pilihan",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF163172),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BeritaScreen(),
                            ),
                          );
                        },
                        child: const Text("Lihat Semua"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // List Berita Horizontal yang 'Clean'
                  SizedBox(
                    height: 260,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        return const NewsCard(
                          title:
                              "VIRALLL!!! Bupati Konoha melakukan Pungli kepada remaja Gen Z!!",
                          date: "20 Des 2025",
                          image:
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkCyl8EjhekDpx2-CiPDmPPQX_m2jjawdeag&s",
                          description: "",
                          isHorizontal: true,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
