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
      decoration: BoxDecoration(
        color: polinesWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: GNav(
            backgroundColor: polinesWhite,
            color: Colors.grey[600],
            activeColor: polinesBlue,
            tabBackgroundColor: polinesYellow.withOpacity(0.2),
            gap: 8,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            selectedIndex: selectedIndex,
            onTabChange: onTabChange,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Beranda',
                iconSize: 24,
              ),
              GButton(
                icon: Icons.business,
                text: 'Jurusan',
                iconSize: 24,
              ),
              GButton(
                icon: Icons.menu_book,
                text: 'Prodi',
                iconSize: 24,
              ),
              GButton(
                icon: Icons.apps,
                text: 'Fasilitas',
                iconSize: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}