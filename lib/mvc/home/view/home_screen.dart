import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../dashboard/bloc/dashboard_cubit.dart'; // Diganti pakai ReportCubit biar real-time sesuai list
import '../../news/bloc/news_cubit.dart';
import '../../report/bloc/report_cubit.dart';
import '../../auth/data/auth_repository.dart';
import '../../education/view/edukasi_screen.dart';
import '../../emergency/view/darurat_screen.dart';
import '../../report/view/buat_laporan_screen.dart';
import '../../settings/view/panduan_screen.dart';
import '../../../components/cards/stat_card.dart';
import '../../../components/cards/news_card.dart';
import '../../../components/buttons/menu_button.dart';
import '../../news/view/berita_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _firstName = "Warga";

  @override
  void initState() {
    super.initState();
    _loadUserData();
    // Load reports (for stats) and news
    Future.microtask(() {
      context.read<ReportCubit>().loadReports();
      context.read<NewsCubit>().loadNews();
    });
  }

  Future<void> _loadUserData() async {
    final userData = await AuthRepository().getUserData();
    if (mounted) {
      setState(() {
        // Ambil nama depan saja biar rapi
        final fullName = userData['name'] ?? "Warga";
        _firstName = fullName.split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ReportCubit>().loadReports();
          context.read<NewsCubit>().refreshNews();
        },
        child: CustomScrollView(
          slivers: [
            // Header Section with Gradient
            SliverToBoxAdapter(child: _buildHeader()),
            // Menu Buttons
            SliverToBoxAdapter(child: _buildMenuSection()),
            // Latest News Section
            SliverToBoxAdapter(child: _buildNewsSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF163172), Color(0xFF1E56A0)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row - Logo & Notification
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 30,
                          errorBuilder: (ctx, error, stackTrace) => const Icon(
                            Icons.shield,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "ANPUNDUNG",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              // Greeting
              Text(
                "Halo, $_firstName!",
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 5),
              const Text(
                "Laporkan Pungli di Sekitar Anda",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              // Stats Card (Dynamic Count from ReportCubit)
              BlocBuilder<ReportCubit, ReportState>(
                builder: (context, state) {
                  int total = 0;
                  int proses = 0;
                  int selesai = 0;

                  if (state is ReportLoaded) {
                    total = state.reports.length;
                    proses = state.reports
                        .where(
                          (r) =>
                              r.status.toLowerCase() == 'proses' ||
                              r.status.toLowerCase() == 'diproses',
                        )
                        .length;
                    selesai = state.reports
                        .where((r) => r.status.toLowerCase() == 'selesai')
                        .length;
                  }

                  return StatCard(
                    items: [
                      StatItemData(
                        label: "Total",
                        count: "$total",
                        icon: Icons.assignment,
                      ),
                      StatItemData(
                        label: "Proses",
                        count: "$proses",
                        icon: Icons.pending_actions,
                      ),
                      StatItemData(
                        label: "Selesai",
                        count: "$selesai",
                        icon: Icons.check_circle,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuSection() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Layanan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF163172),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MenuButton(
                title: "Lapor",
                icon: Icons.add_moderator,
                color: const Color(0xFF1E56A0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const BuatLaporanScreen(),
                    ),
                  );
                },
              ),
              MenuButton(
                title: "Edukasi",
                icon: Icons.school,
                color: Colors.orange,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => const EdukasiScreen()),
                  );
                },
              ),
              MenuButton(
                title: "Darurat",
                icon: Icons.emergency,
                color: Colors.red,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => const DaruratScreen()),
                  );
                },
              ),
              MenuButton(
                title: "Panduan",
                icon: Icons.menu_book,
                color: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => const PanduanScreen()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNewsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Berita Terbaru",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF163172),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Lihat Semua",
                  style: TextStyle(color: Color(0xFF1E56A0)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          BlocBuilder<NewsCubit, NewsState>(
            builder: (context, state) {
              if (state is NewsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is NewsLoaded && state.news.isNotEmpty) {
                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.news.length > 5 ? 5 : state.news.length,
                    itemBuilder: (context, index) {
                      final news = state.news[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  BeritaDetailScreen.fromNews(news: news),
                            ),
                          );
                        },
                        child: NewsCard(
                          title: news.title,
                          date: _formatDate(news.publishedAt ?? news.createdAt),
                          image: news.image ?? '',
                          description: news.content,
                          isHorizontal: true,
                        ),
                      );
                    },
                  ),
                );
              }
              if (state is NewsError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text("Tidak ada berita"));
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return "${date.day} ${months[date.month - 1]} ${date.year}";
  }
}
