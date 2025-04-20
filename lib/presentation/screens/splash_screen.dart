import 'package:flutter/material.dart';
import 'package:polines_app/features/home/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Track which splash screen we are showing
  int _currentSplashIndex = 0;
  
  // List of splash contents
  final List<Map<String, dynamic>> _splashData = [
    {
      'title': 'Lulusan Berkualitas',
      'description': 'Menghasilkan lulusan yang siap kerja dengan kompetensi unggul di bidangnya.',
      'image': 'assets/images/splash_design1.png',
      'buttonText': 'Lanjutkan'
    },
    {
      'title': 'Jurusan Unggulan',
      'description': 'Memiliki 4 jurusan unggulan, yaitu Administrasi Bisnis Terapan, Akutansi, Teknik Elektro, dan Teknik Sipil.',
      'image': 'assets/images/splash_design2.png',
      'buttonText': 'Lanjutkan'
    },
    {
      'title': 'Fasilitas dan Koneksi',
      'description': 'Dilengkapi dengan lab praktikum modern, studi bisnis, dan kerjasama dengan berbagai industri untuk pengembangan karir mahasiswa.',
      'image': 'assets/images/splash_design3.png',
      'buttonText': 'Buka Aplikasi'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF102843), // RGB(16,40,67)
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Stack(
                  children: [
                    // Back button (show only when not on first page)
                    if (_currentSplashIndex > 0)
                      Positioned(
                        top: 16.0,
                        left: 0.0,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _currentSplashIndex--;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ),
                    
                    // Main content centered
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image
                        Image.asset(
                          _splashData[_currentSplashIndex]['image'],
                          width: 240,
                          height: 240,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 32),
                        
                        // Title
                        Text(
                          _splashData[_currentSplashIndex]['title'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        
                        // Description
                        Text(
                          _splashData[_currentSplashIndex]['description'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Bottom navigation: dots and button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
              child: Column(
                children: [
                  // Indicator dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _splashData.length,
                      (index) => buildDot(index),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Button
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentSplashIndex < _splashData.length - 1) {
                          setState(() {
                            _currentSplashIndex++;
                          });
                        } else {
                          // Navigate to Home when reaching the last splash screen
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF6C31A), // Polines yellow
                        foregroundColor: const Color(0xFF04428B), // Polines blue
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        _splashData[_currentSplashIndex]['buttonText'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Custom dot indicator
  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: _currentSplashIndex == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentSplashIndex == index 
            ? const Color(0xFFF6C31A) // Polines yellow for active dot
            : Colors.white38, // Transparent white for inactive dots
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}