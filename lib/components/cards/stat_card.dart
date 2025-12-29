import 'package:flutter/material.dart';

/// Model untuk stat item
class StatItemData {
  final String label;
  final String count;
  final IconData icon;

  const StatItemData({
    required this.label,
    required this.count,
    required this.icon,
  });
}

/// Stat Card dengan glassmorphism effect (dari home_screen)
class StatCard extends StatelessWidget {
  final List<StatItemData> items;

  const StatCard({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _buildItems(),
      ),
    );
  }

  List<Widget> _buildItems() {
    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      widgets.add(_buildStatItem(items[i]));
      if (i < items.length - 1) {
        widgets.add(
          Container(width: 1, height: 40, color: Colors.white30),
        );
      }
    }
    return widgets;
  }

  Widget _buildStatItem(StatItemData item) {
    return Column(
      children: [
        Icon(item.icon, color: const Color(0xFFD6E4F0), size: 28),
        const SizedBox(height: 8),
        Text(
          item.count,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          item.label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
