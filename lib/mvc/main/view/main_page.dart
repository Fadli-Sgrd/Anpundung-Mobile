import 'package:flutter/material.dart';
import '../../../components/navbar/bottom_navbar.dart';
import '../../home/view/home_screen.dart';
import '../../news/view/berita_screen.dart';
import '../../report/view/laporan_screen.dart';
import '../../profile/view/profile_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  int notificationCount = 2;

  final List<Widget> _pages = [
    const HomeScreen(),
    const BeritaScreen(),
    const LaporanScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        notificationCount: notificationCount,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 0) {
              notificationCount = 0;
            }
          });
        },
      ),
    );
  }
}
