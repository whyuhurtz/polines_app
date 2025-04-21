import 'package:flutter/material.dart';

class KompetensiDetailScreen extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  // Colors based on Polines branding
  static const Color polinesBlue = Color(0xFF04428B);
  static const Color polinesYellow = Color(0xFFF6C31A);
  static const Color polinesLightBg = Color(0xFFF6F8FD);
  static const Color polinesWhite = Color(0xFFFFFFFF);

  const KompetensiDetailScreen({
    Key? key,
    required this.number,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: polinesLightBg,
      appBar: AppBar(
        title: const Text(
          'Detail Kompetensi',
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title card
              _buildTitleCard(),
              const SizedBox(height: 24),
              
              // Content card
              _buildContentCard(),
              const SizedBox(height: 24),
              
              // Related skills card
              _buildRelatedSkillsCard(),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildTitleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: polinesYellow,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Number circle
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: polinesWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: polinesBlue,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Title
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: polinesBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildContentCard() {
    // Split description into paragraphs for better readability
    List<String> paragraphs = description.split('\n\n');
    if (paragraphs.length == 1 && description.length > 100) {
      // If no paragraphs but text is long, create artificial paragraphs
      paragraphs = [];
      String temp = description;
      while (temp.length > 100) {
        int splitIndex = temp.substring(0, 100).lastIndexOf('. ') + 1;
        if (splitIndex <= 1) splitIndex = temp.indexOf('. ') + 1;
        if (splitIndex <= 1) splitIndex = temp.length;
        
        paragraphs.add(temp.substring(0, splitIndex));
        temp = temp.substring(splitIndex).trim();
      }
      if (temp.isNotEmpty) paragraphs.add(temp);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Deskripsi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: polinesBlue,
            ),
          ),
          const SizedBox(height: 12),
          ...paragraphs.map((paragraph) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              paragraph,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
          )).toList(),
        ],
      ),
    );
  }
  
  Widget _buildRelatedSkillsCard() {
    // Generate some related skills based on the title
    List<String> skills = [];
    if (title.toLowerCase().contains('administrasi')) {
      skills = ['Dokumentasi', 'Pengarsipan', 'Manajemen Data', 'Korespondensi'];
    } else if (title.toLowerCase().contains('komunikasi')) {
      skills = ['Presentasi', 'Negosiasi', 'Penulisan', 'Public Speaking'];
    } else if (title.toLowerCase().contains('manajerial')) {
      skills = ['Kepemimpinan', 'Pengambilan Keputusan', 'Koordinasi Tim', 'Perencanaan'];
    } else if (title.toLowerCase().contains('keuangan')) {
      skills = ['Pembukuan', 'Analisis Biaya', 'Perpajakan', 'Budgeting'];
    } else if (title.toLowerCase().contains('teknologi')) {
      skills = ['Software Office', 'Database', 'Digital Filing', 'Social Media'];
    } else {
      skills = ['Problem Solving', 'Adaptabilitas', 'Kerjasama Tim', 'Kreativitas'];
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Skills Terkait',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: polinesBlue,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) => Chip(
              label: Text(skill),
              backgroundColor: polinesYellow.withOpacity(0.2),
              labelStyle: const TextStyle(
                color: polinesBlue,
                fontWeight: FontWeight.w500,
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}