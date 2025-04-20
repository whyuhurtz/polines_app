import 'package:flutter/material.dart';

class SemuaJurusanScreen extends StatelessWidget {
  const SemuaJurusanScreen({super.key});

  // Colors based on Polines branding
  static const Color polinesBlue = Color(0xFF04428B);
  static const Color polinesYellow = Color(0xFFF6C31A);
  static const Color polinesLightBg = Color(0xFFF6F8FD);
  static const Color polinesWhite = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: polinesLightBg,
      appBar: AppBar(
        title: const Text('Jurusan'),
        backgroundColor: polinesBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildJurusanCard(
              'Administrasi Bisnis Terapan',
              'Jurusan ini memfokuskan pada pendidikan vokasi di bidang administrasi dan bisnis.',
              'assets/images/card_abt.jpg',
            ),
            _buildJurusanCard(
              'Akuntansi',
              'Program studi yang mempelajari tentang pembukuan, audit, dan sistem keuangan.',
              'assets/images/card_akutansi.jpg',
            ),
            _buildJurusanCard(
              'Teknik Elektro',
              'Program studi yang mempelajari tentang listrik, elektronika, dan sistem komputer.',
              'assets/images/card_elektro.jpg',
            ),
            _buildJurusanCard(
              'Teknik Sipil',
              'Program studi yang berfokus pada konstruksi, perencanaan, dan infrastruktur.',
              'assets/images/card_sipil.jpg',
            ),
            const SizedBox(height: 30),
          ],
        ),
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
            'Jurusan di Polines',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: polinesBlue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Politeknik Negeri Semarang memiliki berbagai jurusan unggulan dengan fokus pada pendidikan vokasi yang komprehensif.',
            style: TextStyle(
              fontSize: 14,
              color: polinesBlue.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJurusanCard(String title, String description, String imagePath) {
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
          // Navigate to detailed jurusan page
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image at top of card
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
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
    );
  }
}