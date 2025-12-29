import 'package:flutter/material.dart';

/// Profile Card dengan gradient (dari profile_screen)
class ProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;
  final int totalLaporan;
  final int diproses;
  final int selesai;

  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl,
    this.totalLaporan = 0,
    this.diproses = 0,
    this.selesai = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF163172), Color(0xFF1E56A0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
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
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
              const SizedBox(width: 20),
              // Info User
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    email,
                    style: const TextStyle(
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
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatItemWhite(label: "Laporan", value: "$totalLaporan"),
                _StatItemWhite(label: "Diproses", value: "$diproses"),
                _StatItemWhite(label: "Selesai", value: "$selesai"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget Stat khusus warna putih (untuk di dalam kartu biru)
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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.white70),
        ),
      ],
    );
  }
}
