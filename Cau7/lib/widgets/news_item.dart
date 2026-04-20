import 'package:flutter/material.dart';
import '../models/news_model.dart';

class NewsItem extends StatelessWidget {
  final NewsModel news;

  const NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề tin tức (In đậm, viết hoa chữ cái đầu)
            Text(
              news.title.toUpperCase(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            // Nội dung tóm tắt
            Text(
              news.body,
              style: TextStyle(color: Colors.grey[700], height: 1.5),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            // Thanh công cụ ảo (Like / Share)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Vừa xong', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                const Row(
                  children: [
                    Icon(Icons.thumb_up_alt_outlined, size: 18, color: Colors.grey),
                    SizedBox(width: 16),
                    Icon(Icons.share_outlined, size: 18, color: Colors.grey),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}