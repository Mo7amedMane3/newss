import 'package:flutter/material.dart';
import 'package:newss/models/news_response.dart';

class ArticleItem extends StatelessWidget {
  final Articles article;

  const ArticleItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ صورة المقال
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: article.urlToImage != null
                ? Image.network(
              article.urlToImage!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 60,
                    color: Colors.grey,
                  ),
                );
              },
            )
                : Container(
              height: 200,
              color: Colors.grey[300],
              child: const Icon(
                Icons.image_not_supported,
                size: 60,
                color: Colors.grey,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Source + Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (article.source?.name != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          article.source!.name!,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    if (article.publishedAt != null)
                      Text(
                        _formatDate(article.publishedAt!),
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 8),

                // ✅ Title
                Text(
                  article.title ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 6),

                // ✅ Description
                if (article.description != null)
                  Text(
                    article.description!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),

                const SizedBox(height: 8),

                // ✅ Author
                if (article.author != null)
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          article.author!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String date) {
    try {
      DateTime dateTime = DateTime.parse(date);
      return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    } catch (e) {
      return date;
    }
  }
}