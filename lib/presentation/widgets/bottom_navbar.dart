import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  // Colors based on Polines branding
  static const Color polinesBlue = Color(0xFF04428B);
  static const Color polinesYellow = Color(0xFFF6C31A);
  static const Color polinesLightBg = Color(0xFFF6F8FD);
  static const Color polinesWhite = Color(0xFFFFFFFF);

  const BottomNavbar({
    Key? key, 
    required this.selectedIndex, 
    required this.onTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: polinesYellow,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: GNav(
        backgroundColor: Colors.transparent,
        color: polinesBlue,
        activeColor: polinesBlue,
        tabBackgroundColor: Colors.white.withOpacity(0.3),
        gap: 8,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        tabMargin: const EdgeInsets.symmetric(vertical: 2),
        selectedIndex: selectedIndex,
        onTabChange: onTabChange,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Beranda',
            iconSize: 24,
            textStyle: const TextStyle(
              color: polinesBlue,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          GButton(
            icon: Icons.business,
            text: 'Jurusan',
            iconSize: 24,
            textStyle: const TextStyle(
              color: polinesBlue,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          GButton(
            icon: Icons.menu_book,
            text: 'Prodi',
            iconSize: 24,
            textStyle: const TextStyle(
              color: polinesBlue,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          GButton(
            icon: Icons.apps,
            text: 'Fasilitas',
            iconSize: 24,
            textStyle: const TextStyle(
              color: polinesBlue,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}