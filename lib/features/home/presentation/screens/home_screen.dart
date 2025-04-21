import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:polines_app/features/home/data/repositories/news_repository_impl.dart';
import 'package:polines_app/features/home/domain/entities/news_entity.dart';
import 'package:polines_app/features/home/presentation/screens/news_list_screen.dart';
import 'package:polines_app/features/home/presentation/screens/semuajurusan_screen.dart';
import 'package:polines_app/features/home/presentation/widgets/news_widget.dart';
import 'package:polines_app/presentation/widgets/bottom_navbar.dart';
import 'package:url_launcher/url_launcher.dart';

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
    'assets/images/banner_home1.jpg',
    'assets/images/banner_home2.jpg',
    'assets/images/banner_home3.jpg',
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
      if (index == 1) {
        // Navigate to Tentang Jurusan screen
        Navigator.pushNamed(context, '/jurusan');
      } else if (index == 2) {
        // Navigate to Program Studi screen
        Navigator.pushNamed(context, '/prodi');
      } else if (index == 3) {
        // Navigate to Fasilitas screen
        Navigator.pushNamed(context, '/fasilitas');
      }
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
              'Comitted to Quality',
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
                  _buildCategoryButton(2, 'Akses Cepat'),
                ],
              ),
            ),
            
            // Content based on selected tab
            const SizedBox(height: 16), // Reduced from 24 to make spacing more compact
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
                  fontSize: 20,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: List.generate(
              _newsList.length,
              (index) => NewsWidget(news: _newsList[index]),
            ),
          ),
        ),
        
        const SizedBox(height: 30),
      ],
    );
  }
  
  Widget _buildJurusanContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _buildJurusanSection(),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
  
  Widget _buildJurusanSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Jurusan header with "see all" link
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Jurusan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: polinesBlue,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SemuaJurusanScreen(),
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
        
        // Jurusan cards - grid layout
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildJurusanCard(
              'Jurusan Administrasi Bisnis Terapan',
              'assets/images/card_abt.jpg',
            ),
            _buildJurusanCard(
              'Jurusan Akuntansi',
              'assets/images/card_akutansi.jpg',
            ),
            _buildJurusanCard(
              'Jurusan Teknik Elektro',
              'assets/images/card_elektro.jpg',
            ),
            _buildJurusanCard(
              'Jurusan Teknik Sipil',
              'assets/images/card_sipil.jpg',
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildJurusanCard(String title, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: polinesBlue,
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
        child: Column(
          children: [
            // Image at top of card - increased height
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 125, // Increased from 110 to 125 for more height
                fit: BoxFit.cover,
              ),
            ),
            // Text container with center alignment
            Expanded(
              child: Center( // Added Center widget to ensure perfect centering
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: polinesWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildQuickAccessContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Akses Cepat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: polinesBlue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10), // Gap between title and grid contents.
        
        // Grid of quick access items - 2x3 layout for better UI
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.4,
            children: [
              _buildQuickAccessItem(
                'Sistem Informasi Akademik', 
                Icons.school,
                'https://simadu.polines.ac.id/',
              ),
              _buildQuickAccessItem(
                'E-Learning', 
                Icons.menu_book,
                'https://elnino.polines.ac.id/',
              ),
              _buildQuickAccessItem(
                'Pendaftaran Mahasiswa Baru', 
                Icons.app_registration,
                'https://pmb.polines.ac.id/',
              ),
              _buildQuickAccessItem(
                'Sistem Keuangan', 
                Icons.account_balance_wallet,
                'https://bakpk.polines.ac.id/',
              ),
              _buildQuickAccessItem(
                'Kuisioner Alumni', 
                Icons.rate_review,
                'https://tracerstudy.polines.ac.id/',
              ),
              _buildQuickAccessItem(
                'Career Development', 
                Icons.group,
                'https://tik.polines.ac.id/index.php/id/',
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 30),
      ],
    );
  }
  
  Widget _buildQuickAccessItem(String title, IconData icon, String url) {
    return Container(
      decoration: BoxDecoration(
        color: polinesBlue,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchURL(url),
          borderRadius: BorderRadius.circular(10),
          splashColor: polinesYellow.withOpacity(0.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: polinesYellow,
                size: 32,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Simplified URL launcher method optimized for web links
  Future<void> _launchURL(String urlString) async {
    try {
      final Uri uri = Uri.parse(urlString);
      
      // Log the attempt
      developer.log('Attempting to launch URL: $urlString');
      
      // Use platformDefault for better cross-platform support
      await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
      );
      
    } catch (e) {
      developer.log('Error launching URL: $e', error: e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tidak dapat membuka link: $urlString'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
  
  // Helper function to launch URLs
  Future<void> launchUrlHelper(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      throw 'Could not launch $url: $e';
    }
  }
}