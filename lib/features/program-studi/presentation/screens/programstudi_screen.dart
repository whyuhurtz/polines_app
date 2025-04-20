import 'package:flutter/material.dart';
import 'package:polines_app/features/tentang-jurusan/presentation/widgets/header_carousel_widget.dart';
import 'package:polines_app/presentation/widgets/bottom_navbar.dart';

class ProgramStudiScreen extends StatefulWidget {
  const ProgramStudiScreen({super.key});

  @override
  State<ProgramStudiScreen> createState() => _ProgramStudiScreenState();
}

class _ProgramStudiScreenState extends State<ProgramStudiScreen> {
  // Colors based on Polines branding
  static const Color polinesBlue = Color(0xFF04428B);
  static const Color polinesYellow = Color(0xFFF6C31A);
  static const Color polinesLightBg = Color(0xFFF6F8FD);
  static const Color polinesWhite = Color(0xFFFFFFFF);
  
  int _selectedIndex = 2; // For bottom navbar, set to Prodi tab
  
  // Handle navigation when bottom navbar tab is changed
  void _onTabChange(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/jurusan');
      } else if (index == 3) {
        Navigator.pushReplacementNamed(context, '/fasilitas');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: polinesLightBg,
      appBar: AppBar(
        title: const Text(
          'Program Studi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: polinesBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Using the HeaderCarouselWidget for image slider
            const HeaderCarouselWidget(
              imagePaths: [
                'assets/images/banner_prodi1.jpg',
                'assets/images/banner_prodi2.jpg',
                'assets/images/banner_home3.jpg',
              ],
              height: 200,
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildProdiCard(
                    'Teknik Informatika',
                    'Program studi yang mempelajari tentang pemrograman, jaringan, dan sistem informasi.',
                    Icons.computer,
                  ),
                  _buildProdiCard(
                    'Teknik Elektronika',
                    'Program studi yang berfokus pada rangkaian elektronik dan sistem digital.',
                    Icons.memory,
                  ),
                  _buildProdiCard(
                    'Akuntansi Perpajakan',
                    'Program studi yang mempelajari tentang perpajakan dan keuangan.',
                    Icons.calculate,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
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
            'Program Studi di Polines',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: polinesBlue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Politeknik Negeri Semarang menawarkan berbagai program studi unggulan dengan fokus pada pendidikan vokasi yang siap kerja.',
            style: TextStyle(
              fontSize: 14,
              color: polinesBlue.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProdiCard(String title, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
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
        onTap: () {
          // Navigate to detailed prodi page
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: polinesBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: polinesBlue,
                  size: 36,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: polinesBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}