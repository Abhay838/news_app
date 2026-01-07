import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/saved_news_view_model.dart';
import '../../models/article_model.dart';
import 'article_screen.dart';

class SavedNewsScreen extends StatelessWidget {
  const SavedNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SavedNewsViewModel>();
    final articles = vm.savedArticles;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saved News",
          style: GoogleFonts.aBeeZee(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: articles.isEmpty
          ? Center(
              child: Text(
                "No saved articles",
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            )
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (_, i) {
                final Article article = articles[i];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ArticleScreen(article)),
                    );
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            article.imageUrl.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      article.imageUrl,
                                      width: 150,
                                      height: 110,
                                      fit: BoxFit.fitHeight,
                                      errorBuilder: (_, __, ___) => const Icon(
                                        Icons.broken_image,
                                        size: 80,
                                      ),
                                    ),
                                  )
                                : const Icon(
                                    Icons.image_not_supported,
                                    size: 80,
                                  ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    article.title,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.abel(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      article.author != ''
                                          ? Text(
                                              article.author,
                                              style: GoogleFonts.abel(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          : Text(
                                              "unknown Author",
                                              style: GoogleFonts.abel(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () =>
                                            vm.deleteArticle(article.url),
                                      ),
                                      // Text(
                                      //   formatPublishedDate(article.date),
                                      //   style: GoogleFonts.abel(
                                      //     fontSize: 13,
                                      //     fontWeight: FontWeight.w600,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
