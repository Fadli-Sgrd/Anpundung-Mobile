import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'berita_screen.dart';
import 'laporan_screen.dart';
import 'profile_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // Buat nyimpen kita lagi di tab mana 

  // Daftar halaman yang bakal muncul
  final List<Widget> _pages = [
    const HomeScreen(),
    const BeritaScreen(),
    const LaporanScreen(), // Ini yang ada CRUD-nya
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Ganti body sesuai tab yang dipilih
      bottomNavigationBar: Container(
        // Kita kasih dekorasi dikit biar menu bawahnya ada bayangan 
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Update index pas diklik 
            });
          },
          type: BottomNavigationBarType.fixed, // Biar icon-nya gak goyang-goyang
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF1E56A0), // Warna pas aktif
          unselectedItemColor: Colors.grey, // Warna pas mati
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.newspaper_rounded), label: 'Berita'),
            BottomNavigationBarItem(icon: Icon(Icons.assignment_late_rounded), label: 'Laporan'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}