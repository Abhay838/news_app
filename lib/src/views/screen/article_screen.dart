import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/article_model.dart';
import '../../viewmodels/saved_news_view_model.dart';

class ArticleScreen extends StatelessWidget {
  final Article article;
  const ArticleScreen(this.article, {super.key});

  String formatDate(String date) {
    final dt = DateTime.parse(date);
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 IMAGE SECTION
            Stack(
              children: [
                // Image
                article.imageUrl.isNotEmpty
                    ? Image.network(
                        article.imageUrl,
                        height: 380,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const SizedBox(
                          height: 380,
                          child: Icon(Icons.broken_image, size: 100),
                        ),
                      )
                    : const SizedBox(
                        height: 380,
                        child: Icon(Icons.image_not_supported, size: 100),
                      ),

                // Dark overlay
                Container(height: 380, color: Colors.black.withOpacity(0.4)),

                // Back button
                Positioned(
                  top: 20,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //saved button
                Positioned(
                  top: 20,
                  right: 16,
                  child: Consumer<SavedNewsViewModel>(
                    builder: (_, savedVM, __) {
                      final isSaved = savedVM.isSaved(article.url);

                      return GestureDetector(
                        onTap: () {
                          savedVM.toggleSave(article);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isSaved
                                    ? Icons.bookmark
                                    : Icons.bookmark_border_outlined,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Title & Date
                Positioned(
                  bottom: 20,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        formatDate(article.date),
                        style: GoogleFonts.aBeeZee(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // 📰 CONTENT
            Padding(
              padding: const EdgeInsets.all(16),
              child: article.content.isNotEmpty
                  ? Text(
                      article.content.replaceAll(
                        RegExp(r'\[\+\d+ chars\]'),
                        '',
                      ),
                      style: const TextStyle(fontSize: 16, height: 1.6),
                    )
                  : const Text(
                      "No content available for this article.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
            ),

            // 🔗 READ FULL ARTICLE BUTTON
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.open_in_new),
                      label: const Text("Read Full Article"),
                      onPressed: () async {
                        try {
                          final uri = Uri.parse(article.url);
                          await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Could not open the article"),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
