import 'package:flutter/material.dart';

/// Bottom Navigation Bar standard style
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final int notificationCount;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.notificationCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF163172),
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        showUnselectedLabels: true,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Badge(
              isLabelVisible: notificationCount > 0,
              label: Text('$notificationCount'),
              child: const Icon(Icons.home_rounded),
            ),
            activeIcon: Badge(
              isLabelVisible: notificationCount > 0,
              label: Text('$notificationCount'),
              child: const Icon(Icons.home_rounded),
            ),
            label: 'Beranda',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_rounded),
            activeIcon: Icon(Icons.newspaper_rounded),
            label: 'Berita',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.assignment_rounded),
            activeIcon: Icon(Icons.assignment_rounded),
            label: 'Laporan',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
