import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../repositories/news_repository.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsRepository _repo = NewsRepository();

  List<Article> articles = [];
  bool isLoading = false;
  String? error;
  int page = 1;

  Future<void> loadNews(String category, {bool refresh = false}) async {
    try {
      if (refresh) {
        page = 1;
        articles.clear();
      }

      isLoading = true;
      notifyListeners();

      final newArticles = await _repo.fetchNews(category, page);
      articles.addAll(newArticles);
      page++;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
