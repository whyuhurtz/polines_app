import 'package:flutter/material.dart';
import 'package:polines_app/features/home/domain/entities/news_entity.dart';

class NewsDetailScreen extends StatelessWidget {
  final News news;

  // Colors based on Polines branding
  static const Color polinesBlue = Color(0xFF04428B);
  static const Color polinesYellow = Color(0xFFF6C31A);
  static const Color polinesLightBg = Color(0xFFF6F8FD);
  static const Color polinesWhite = Color(0xFFFFFFFF);

  const NewsDetailScreen({super.key, required this.news});

  // Get the appropriate image based on news content
  String _getNewsImage() {
    // Match news to the appropriate image based on title
    if (news.title?.contains('IMPLEMENTASI GKM') == true) {
      return 'assets/images/berita1.png';
    } else if (news.title?.contains('PENDAMPINGAN DELEGASI BAC') == true) {
      return 'assets/images/berita2.png';
    } else if (news.title?.contains('DOSEN AB BULAN NOVEMBER') == true) {
      return 'assets/images/berita3.png';
    } else if (news.title?.contains('PENYEMPURNAAN DOKUMEN') == true) {
      return 'assets/images/berita4.png';
    } else {
      // Default fallback image if no match
      return 'assets/images/berita1.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: polinesLightBg,
      appBar: AppBar(
        title: const Text('Berita'),
        backgroundColor: polinesBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News image at the top
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: DecorationImage(
                  image: AssetImage(_getNewsImage()),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Author, date and time in one line container with yellow background
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: polinesYellow,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Author
                  Row(
                    children: [
                      const Icon(Icons.person, 
                        size: 16, 
                        color: polinesBlue
                      ),
                      const SizedBox(width: 4),
                      Text(
                        news.author ?? 'Unknown author',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: polinesBlue,
                        ),
                      ),
                    ],
                  ),
                  
                  // Date & time
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, 
                        size: 14, 
                        color: polinesBlue
                      ),
                      const SizedBox(width: 4),
                      Text(
                        news.datePublished ?? 'Unknown date',
                        style: const TextStyle(
                          fontSize: 12,
                          color: polinesBlue,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.access_time, 
                        size: 14, 
                        color: polinesBlue
                      ),
                      const SizedBox(width: 4),
                      Text(
                        news.timePublished ?? 'Unknown time',
                        style: const TextStyle(
                          fontSize: 12,
                          color: polinesBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // News title and content in a white container
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: polinesWhite,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    news.title ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: polinesBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Content with paragraphs and justify alignment
                  ..._buildContentWithParagraphs(),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
  
  // Helper method to build content with paragraphs
  List<Widget> _buildContentWithParagraphs() {
    // Get content text and handle null case
    final String contentText = news.content ?? 'No content available';
    
    // Split the content into paragraphs based on \n
    final List<String> paragraphs = contentText.split('\n');
    
    // Return a list of widgets for each paragraph with spacing between them
    return paragraphs
        .where((paragraph) => paragraph.trim().isNotEmpty) // Filter out empty paragraphs
        .map((paragraph) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              paragraph.trim(),
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 12), // Add space between paragraphs
          ],
        )).toList();
  }
}