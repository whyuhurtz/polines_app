import 'package:flutter/material.dart';
import 'package:polines_app/features/tentang-jurusan/presentation/widgets/header_carousel_widget.dart';
import 'package:polines_app/presentation/widgets/bottom_navbar.dart';

class FasilitasScreen extends StatefulWidget {
  const FasilitasScreen({super.key});

  @override
  State<FasilitasScreen> createState() => _FasilitasScreenState();
}

class _FasilitasScreenState extends State<FasilitasScreen> {
  // Colors based on Polines branding
  static const Color polinesBlue = Color(0xFF04428B);
  static const Color polinesYellow = Color(0xFFF6C31A);
  static const Color polinesLightBg = Color(0xFFF6F8FD);
  static const Color polinesWhite = Color(0xFFFFFFFF);
  
  int _selectedIndex = 3; // For bottom navbar, set to Fasilitas tab
  
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
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, '/prodi');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: polinesLightBg,
      appBar: AppBar(
        title: const Text(
          'Fasilitas',
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
                'assets/images/banner_fasilitas1.jpg',
                'assets/images/banner_fasilitas2.jpg',
                'assets/images/banner_fasilitas3.jpg',
              ],
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fasilitas Kampus',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: polinesBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Politeknik Negeri Semarang menyediakan berbagai fasilitas modern untuk menunjang kegiatan akademik dan non-akademik mahasiswa.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildFasilitasItem(
                    'Perpustakaan',
                    'Perpustakaan modern dengan koleksi buku teknis dan non-teknis yang lengkap.',
                    Icons.menu_book,
                  ),
                  _buildFasilitasItem(
                    'Laboratorium',
                    'Lab komputer, elektronika, dan workshop teknik yang dilengkapi peralatan mutakhir.',
                    Icons.science,
                  ),
                  _buildFasilitasItem(
                    'Fasilitas Olahraga',
                    'Lapangan basket, futsal, dan berbagai sarana olahraga lainnya.',
                    Icons.sports_basketball,
                  ),
                  _buildFasilitasItem(
                    'Kantin',
                    'Area food court dengan berbagai pilihan makanan yang terjangkau.',
                    Icons.restaurant,
                  ),
                  _buildFasilitasItem(
                    'Ruang Kelas',
                    'Ruang kuliah yang nyaman dengan AC dan peralatan audiovisual.',
                    Icons.chair,
                  ),
                  _buildFasilitasItem(
                    'Auditorium',
                    'Aula besar untuk pertemuan, seminar, dan kegiatan kemahasiswaan.',
                    Icons.event_seat,
                  ),
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

  Widget _buildFasilitasItem(String title, String description, IconData icon) {
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: polinesYellow.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: polinesYellow,
                size: 32,
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
                  const SizedBox(height: 4),
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
    );
  }
}