import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:polines_app/features/home/data/repositories/news_repository_impl.dart';
import 'package:polines_app/features/home/domain/entities/news_entity.dart';
import 'package:polines_app/features/home/presentation/screens/news_list_screen.dart';
import 'package:polines_app/features/home/presentation/widgets/news_widget.dart';
import 'package:polines_app/presentation/widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _selectedTabIndex = 0; // For content tabs (Berita, Jurusan, Akses Cepat)
  late final PageController _bannerController;
  int _currentBannerPage = 0;
  final NewsRepositoryImpl _newsRepository = NewsRepositoryImpl();
  List<News> _newsList = [];
  bool _isLoading = true;
  String? _errorMessage;

  // Colors based on Polines branding
  static const Color polinesBlue = Color(0xFF04428B);
  static const Color polinesYellow = Color(0xFFF6C31A);
  static const Color polinesLightBg = Color(0xFFF6F8FD);
  static const Color polinesWhite = Color(0xFFFFFFFF);
  
  // Banner image list
  final List<String> _bannerImages = [
    'assets/images/splash_design1.png',
    'assets/images/splash_design2.png',
    'assets/images/splash_design3.png',
  ];

  @override
  void initState() {
    super.initState();
    _bannerController = PageController(initialPage: 0, viewportFraction: 1.0);
    _loadNews();

    // Auto-scroll banner
    Future.delayed(const Duration(seconds: 1), () {
      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        if (_currentBannerPage < _bannerImages.length - 1) {
          _currentBannerPage++;
        } else {
          _currentBannerPage = 0;
        }
        _bannerController.animateToPage(
          _currentBannerPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _startAutoScroll();
      }
    });
  }
  
  Future<void> _loadNews() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      developer.log("Start loading news in home screen");
      final news = await _newsRepository.getNews();
      
      if (!mounted) return;
      
      setState(() {
        _newsList = news;
        _isLoading = false;
        developer.log("News loaded successfully, count: ${news.length}");
      });
    } catch (e) {
      developer.log("Error loading news: $e", error: e);
      
      if (!mounted) return;
      
      setState(() {
        _isLoading = false;
        _errorMessage = "Failed to load news: $e";
      });
    }
  }

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    // Handle navigation based on selected tab
    if (index != 0) {
      // Temporarily show a snackbar for tabs that don't have screens yet
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${index == 1 ? 'Jurusan' : index == 2 ? 'Prodi' : 'Fasilitas'} screen coming soon!'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: polinesLightBg,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/icons/ic_polines.png',
              height: 36,
              width: 36,
            ),
            const SizedBox(width: 8),
            const Text(
              'Polines App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: polinesBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Image Slider
            SizedBox(
              height: 180,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _bannerController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentBannerPage = index;
                      });
                    },
                    itemCount: _bannerImages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: polinesBlue.withOpacity(0.1),
                        ),
                        child: Image.asset(
                          _bannerImages[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  
                  // Banner Page Indicator
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _bannerImages.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentBannerPage == index
                                ? polinesYellow
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Category Tabs
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCategoryButton(0, 'Berita'),
                  _buildCategoryButton(1, 'Jurusan'),
                  _buildCategoryButton(2, 'Akses'),
                ],
              ),
            ),
            
            // Content based on selected tab
            const SizedBox(height: 16),
            _buildSelectedTabContent(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
      ),
    );
  }
  
  Widget _buildCategoryButton(int index, String title) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? polinesYellow : polinesWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            color: polinesBlue,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
  
  Widget _buildSelectedTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildNewsContent();
      case 1:
        return _buildJurusanContent();
      case 2:
        return _buildQuickAccessContent();
      default:
        return _buildNewsContent();
    }
  }
  
  Widget _buildNewsContent() {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text('Error: $_errorMessage'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadNews,
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }
    
    if (_newsList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('No news available'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadNews,
                child: const Text('Refresh'),
              ),
            ],
          ),
        ),
      );
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rilis Berita (${_newsList.length})',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: polinesBlue,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewsListScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      'see all',
                      style: TextStyle(
                        color: Colors.blue[300],
                        fontSize: 12,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 10,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // News List
        ...List.generate(
          _newsList.length,
          (index) => NewsWidget(news: _newsList[index]),
        ),
        
        const SizedBox(height: 30),
      ],
    );
  }
  
  Widget _buildJurusanContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildJurusanSection(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
  
  Widget _buildJurusanSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jurusan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: polinesBlue,
          ),
        ),
        const SizedBox(height: 16),
        
        // Jurusan cards - grid layout
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.0,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildJurusanCard(
              'Administrasi Bisnis Terapan',
              Icons.business_center,
            ),
            _buildJurusanCard(
              'Teknik Elektro',
              Icons.electrical_services,
            ),
            _buildJurusanCard(
              'Teknik Sipil',
              Icons.domain,
            ),
            _buildJurusanCard(
              'Akuntansi',
              Icons.account_balance,
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildJurusanCard(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: polinesWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: polinesYellow.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: polinesBlue,
                  size: 32,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildQuickAccessContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Akses Cepat',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: polinesBlue,
            ),
          ),
          const SizedBox(height: 16),
          
          // Grid of quick access items
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _buildQuickAccessItem('Sistem Informasi\nAkademik', Icons.school),
              _buildQuickAccessItem('Learning Without\nLimits', Icons.menu_book),
              _buildQuickAccessItem('Pendaftaran\nMahasiswa Baru', Icons.app_registration),
              _buildQuickAccessItem('Sistem Keuangan\nTerpadu Polines', Icons.account_balance_wallet),
              _buildQuickAccessItem('Kuisioner Alumni\nJurusan', Icons.rate_review),
              _buildQuickAccessItem('Career Development\nCenter', Icons.group),
            ],
          ),
          
          const SizedBox(height: 30),
        ],
      ),
    );
  }
  
  Widget _buildQuickAccessItem(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: polinesBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: polinesYellow,
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 10,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}