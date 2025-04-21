import 'package:flutter/material.dart';
import 'package:polines_app/features/home/data/repositories/news_repository_impl.dart';
import 'package:polines_app/features/home/domain/entities/news_entity.dart';
import 'package:polines_app/features/home/presentation/widgets/news_widget.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final NewsRepositoryImpl _newsRepository = NewsRepositoryImpl();
  List<News> _newsList = [];
  bool _isLoading = true;
  String? _errorMessage;

  // Colors based on Polines branding
  static const Color polinesBlue = Color(0xFF04428B);
  static const Color polinesYellow = Color(0xFFF6C31A);
  static const Color polinesLightBg = Color(0xFFF6F8FD);

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final news = await _newsRepository.getNews();
      
      if (!mounted) return;
      
      setState(() {
        _newsList = news;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        _isLoading = false;
        _errorMessage = "Failed to load news: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: polinesLightBg,
      appBar: AppBar(
        title: const Text('Semua Berita'),
        backgroundColor: polinesBlue,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text('Error: $_errorMessage'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadNews,
              style: ElevatedButton.styleFrom(
                backgroundColor: polinesYellow,
                foregroundColor: polinesBlue,
              ),
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (_newsList.isEmpty) {
      return const Center(
        child: Text('Tidak ada berita tersedia'),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            ...List.generate(
              _newsList.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: NewsWidget(news: _newsList[index]),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: polinesYellow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Berita Polines',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: polinesBlue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Dapatkan informasi terbaru mengenai kegiatan dan prestasi civitas akademika Politeknik Negeri Semarang.',
            style: TextStyle(
              fontSize: 14,
              color: polinesBlue.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}