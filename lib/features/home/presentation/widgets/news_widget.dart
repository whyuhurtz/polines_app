import 'package:flutter/material.dart';
import 'package:polines_app/features/home/domain/entities/news_entity.dart';

class NewsWidget extends StatelessWidget {
  final News news;
  
  // Colors based on Polines branding
  static const Color polinesBlue = Color(0xFF04428B);
  static const Color polinesYellow = Color(0xFFF6C31A);
  static const Color polinesLightBg = Color(0xFFF6F8FD);
  static const Color polinesWhite = Color(0xFFFFFFFF);

  const NewsWidget({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: polinesWhite,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              news.title ?? 'No Title',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: polinesBlue,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 8.0),
            
            // Author and Date Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Author with icon
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 14.0,
                      color: polinesBlue.withOpacity(0.7),
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      news.author ?? 'Unknown Author',
                      style: TextStyle(
                        color: polinesBlue.withOpacity(0.8),
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                
                // Date and time
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 12.0,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '${news.datePublished} ${news.timePublished}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const Divider(height: 16.0),
            
            // Content preview
            Text(
              news.content ?? 'No content available',
              style: const TextStyle(
                fontSize: 14.0,
                height: 1.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 12.0),
            
            // Read more button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Navigate to news detail
                },
                style: TextButton.styleFrom(
                  foregroundColor: polinesYellow,
                  padding: EdgeInsets.zero,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Read More',
                      style: TextStyle(
                        color: polinesBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    const Icon(
                      Icons.arrow_forward,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}