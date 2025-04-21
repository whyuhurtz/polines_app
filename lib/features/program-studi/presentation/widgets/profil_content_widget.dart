import 'package:flutter/material.dart';

class ProfilContentWidget extends StatelessWidget {
  const ProfilContentWidget({Key? key}) : super(key: key);

  // Colors based on Polines branding
  static const Color polinesBlue = Color(0xFF04428B);
  static const Color polinesYellow = Color(0xFFF6C31A);
  static const Color polinesWhite = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    // List of profil lulusan (static data)
    final List<Map<String, dynamic>> profilList = [
      {
        'title': 'Office Administrator',
        'image': 'assets/images/profil_lulusan1.jpeg',
      },
      {
        'title': 'Sekretaris',
        'image': 'assets/images/profil_lulusan2.jpeg',
      },
      {
        'title': 'Public Relation',
        'image': 'assets/images/profil_lulusan3.jpeg',
      },
      {
        'title': 'Freight Forwarder',
        'image': 'assets/images/profil_lulusan4.jpeg',
      },
      {
        'title': 'Arsiparis Tingkat Madya',
        'image': 'assets/images/profil_lulusan5.jpeg',
      },
      {
        'title': 'Professional Convention and Exhibition Organizer',
        'image': 'assets/images/profil_lulusan6.jpeg',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Profil Lulusan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: polinesBlue,
          ),
        ),
        const SizedBox(height: 16),
        
        // Grid dengan 2 item per baris (3x2 grid)
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.0,
          ),
          itemCount: profilList.length,
          itemBuilder: (context, index) {
            return _buildProfilItem(
              profilList[index]['title'],
              profilList[index]['image'],
            );
          },
        ),
      ],
    );
  }

  Widget _buildProfilItem(String title, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: polinesWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Image at top
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          
          // Title
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: polinesBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}