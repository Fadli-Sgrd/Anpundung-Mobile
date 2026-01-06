import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/news_cubit.dart';
import '../data/news_model.dart';
import '../../../components/cards/news_card.dart';
import '../../../data/saved_news_store.dart';
import 'berita_detail_screen.dart';

class BeritaScreen extends StatefulWidget {
  const BeritaScreen({super.key});

  @override
  State<BeritaScreen> createState() => _BeritaScreenState();
}

class _BeritaScreenState extends State<BeritaScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _categories = [
    "Semua",
    "Info",
    "Tips",
    "Peraturan",
    "Berita",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);

    // Load news data
    Future.microtask(() => context.read<NewsCubit>().loadNews());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool _isNewsSaved(String title) {
    return SavedNewsStore.saved.value.any((e) => e['title'] == title);
  }

  void _toggleSaveNews(NewsModel news) {
    final isSaved = _isNewsSaved(news.title);
    setState(() {
      if (isSaved) {
        SavedNewsStore.removeByTitle(news.title);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Berita dihapus dari tersimpan"),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        SavedNewsStore.add({
          'title': news.title,
          'date': _formatDate(news.createdAt),
          'image': news.image ?? '',
          'description': news.content,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Berita berhasil disimpan"),
            duration: Duration(seconds: 1),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          "Berita",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF163172), Color(0xFF1E56A0)],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            alignment: Alignment.center,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white60,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabAlignment: TabAlignment.center,
              tabs: _categories.map((cat) => Tab(text: cat)).toList(),
            ),
          ),
        ),
      ),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NewsLoaded && state.news.isNotEmpty) {
            return TabBarView(
              controller: _tabController,
              children: _categories.map((category) {
                // Filter news based on category (for now, show all)
                final filteredNews = state.news;
                return _buildNewsList(filteredNews);
              }).toList(),
            );
          }
          if (state is NewsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.grey),
                  const SizedBox(height: 15),
                  Text(state.message),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () => context.read<NewsCubit>().refreshNews(),
                    child: const Text("Coba Lagi"),
                  ),
                ],
              ),
            );
          }
          return _buildEmptyState();
        },
      ),
    );
  }

  Widget _buildNewsList(List<NewsModel> news) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<NewsCubit>().refreshNews();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: news.length,
        itemBuilder: (context, index) {
          final item = news[index];
          final isSaved = _isNewsSaved(item.title);
          return Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: NewsCard(
                title: item.title,
                date: _formatDate(item.publishedAt ?? item.createdAt),
                image: item.image ?? '',
                description: item.content,
                isSaved: isSaved,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => BeritaDetailScreen(
                        title: item.title,
                        date: _formatDate(item.publishedAt ?? item.createdAt),
                        image: item.image ?? '',
                        description: item.content,
                      ),
                    ),
                  );
                },
                onSave: () => _toggleSaveNews(item),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.article_outlined,
              size: 60,
              color: Color(0xFFD6E4F0),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Belum Ada Berita",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Berita terbaru akan muncul di sini",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return "${date.day} ${months[date.month - 1]} ${date.year}";
  }
}
