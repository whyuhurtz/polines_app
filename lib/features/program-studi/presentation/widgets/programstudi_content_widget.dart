import 'package:flutter/material.dart';

class ProdiContentWidget extends StatelessWidget {
  const ProdiContentWidget({Key? key}) : super(key: key);

  // Colors based on Polines branding
  static const Color polinesBlue = Color(0xFF04428B);
  static const Color polinesYellow = Color(0xFFF6C31A);
  static const Color polinesWhite = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    // List data program studi
    final List<Map<String, dynamic>> prodiList = [
      {
        'name': 'D3 Administrasi Bisnis',
        'icon': Icons.business,
        'color': Colors.blue,
      },
      {
        'name': 'D3 Manajemen Pemasaran',
        'icon': Icons.shopping_cart,
        'color': Colors.orange,
      },
      {
        'name': 'D4 Manajemen Bisnis Internasional',
        'icon': Icons.language,
        'color': Colors.green,
      },
      {
        'name': 'D4 Administrasi Bisnis Terapan',
        'icon': Icons.work,
        'color': Colors.purple,
      },
      {
        'name': 'D4 Keuangan Publik',
        'icon': Icons.account_balance,
        'color': Colors.red,
      },
      {
        'name': 'D4 Akuntansi Perpajakan',
        'icon': Icons.account_balance_wallet,
        'color': Colors.teal,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daftar Program Studi',
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
            childAspectRatio: 1.1,
          ),
          itemCount: prodiList.length,
          itemBuilder: (context, index) {
            return _buildProdiItem(
              prodiList[index]['name'],
              prodiList[index]['icon'],
              prodiList[index]['color'],
            );
          },
        ),
      ],
    );
  }

  Widget _buildProdiItem(String name, IconData icon, Color color) {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 36,
              color: color,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: polinesBlue,
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