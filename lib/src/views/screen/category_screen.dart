import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/src/views/screen/article_screen.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/news_view_model.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  const CategoryScreen(this.category, {super.key});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsViewModel>().loadNews(widget.category.toLowerCase());
    });
  }

  String formatPublishedDate(String publishedAt) {
    final dateTime = DateTime.parse(publishedAt);

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

    return '${months[dateTime.month - 1]} ${dateTime.day},${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NewsViewModel>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined, size: 22),
        ),
        title: Text(
          widget.category.toUpperCase(),
          style: GoogleFonts.aBeeZee(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => vm.loadNews(widget.category, refresh: true),
        child: vm.isLoading && vm.articles.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: vm.articles.length,
                itemBuilder: (_, i) {
                  final article = vm.articles[i];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ArticleScreen(article),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          article.imageUrl.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: article.imageUrl,
                                    width: 160,
                                    height: 120,
                                    fit: BoxFit.fitHeight,
                                    // placeholder: (_, __) => const Icon(
                                    //   Icons.broken_image,
                                    //   size: 80,
                                    // ),
                                    progressIndicatorBuilder:
                                        (context, url, progress) =>
                                            CircularProgressIndicator(),
                                  ),
                                )
                              : const Icon(Icons.image_not_supported, size: 80),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  children: [
                                    Expanded(
                                      child: Text(
                                        article.author.isNotEmpty
                                            ? article.author
                                            : "Unknown author",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.abel(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      formatPublishedDate(article.date),
                                      style: GoogleFonts.abel(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
