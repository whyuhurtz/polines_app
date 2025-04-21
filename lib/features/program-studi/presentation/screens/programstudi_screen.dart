import 'package:flutter/material.dart';
import 'package:polines_app/features/tentang-jurusan/presentation/widgets/header_carousel_widget.dart';
import 'package:polines_app/features/program-studi/presentation/widgets/content_tab_button.dart';
import 'package:polines_app/features/program-studi/presentation/widgets/programstudi_content_widget.dart';
import 'package:polines_app/features/program-studi/presentation/widgets/profil_content_widget.dart';
import 'package:polines_app/features/program-studi/presentation/widgets/kompetensi_content_widget.dart';
import 'package:polines_app/presentation/widgets/bottom_navbar.dart';

enum ContentType { prodi, profil, kompetensi }

class ProgramStudiScreen extends StatefulWidget {
  const ProgramStudiScreen({super.key});

  @override
  State<ProgramStudiScreen> createState() => _ProgramStudiScreenState();
}

class _ProgramStudiScreenState extends State<ProgramStudiScreen> {
  // Colors based on Polines branding
  static const Color polinesBlue = Color(0xFF04428B);
  // static const Color polinesYellow = Color(0xFFF6C31A); // Used in the tab buttons
  static const Color polinesLightBg = Color(0xFFF6F8FD);
  
  int _selectedIndex = 2; // For bottom navbar, set to Prodi tab
  ContentType _selectedContentType = ContentType.prodi; // Default tab
  
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
                'assets/images/banner_prodi3.jpg',
              ],
              height: 200,
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tab Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ContentTabButton(
                        text: 'Prodi',
                        isSelected: _selectedContentType == ContentType.prodi,
                        onPressed: () {
                          setState(() {
                            _selectedContentType = ContentType.prodi;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      ContentTabButton(
                        text: 'Profil',
                        isSelected: _selectedContentType == ContentType.profil,
                        onPressed: () {
                          setState(() {
                            _selectedContentType = ContentType.profil;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      ContentTabButton(
                        text: 'Kompetensi',
                        isSelected: _selectedContentType == ContentType.kompetensi,
                        onPressed: () {
                          setState(() {
                            _selectedContentType = ContentType.kompetensi;
                          });
                        },
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Dynamic content based on selected tab
                  _buildSelectedContent(),
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
  
  Widget _buildSelectedContent() {
    switch (_selectedContentType) {
      case ContentType.prodi:
        return const ProdiContentWidget();
      case ContentType.profil:
        return const ProfilContentWidget();
      case ContentType.kompetensi:
        return const KompetensiContentWidget();
    }
  }
}