import 'dart:developer';

import '../core/network/api_service.dart';
import '../core/constants/api_constants.dart';
import '../models/article_model.dart';

class NewsRepository {
  final ApiService _apiService = ApiService();

  Future<List<Article>> fetchNews(String category, int page) async {
    final data = await _apiService.get(
      ApiConstants.categoryNews(category, page),
    );
    // log('NEWSREPO ${data['articles'] as List}');
    // log('NEWSREPO ${data['articles'] as List}');
    return (data['articles'] as List).map((e) => Article.fromJson(e)).toList();
  }
}
