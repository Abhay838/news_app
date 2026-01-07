import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/article_model.dart';

class SavedNewsViewModel extends ChangeNotifier {
  static const String boxName = 'saved_articles';

  late Box<Article> _box;

  List<Article> get savedArticles => _box.values.toList();

  Future<void> init() async {
    _box = await Hive.openBox<Article>(boxName);
    notifyListeners();
  }

  bool isSaved(String url) {
    return _box.containsKey(url);
  }

  Future<void> toggleSave(Article article) async {
    if (isSaved(article.url)) {
      await _box.delete(article.url);
    } else {
      await _box.put(article.url, article);
    }
    notifyListeners();
  }

  Future<void> deleteArticle(String url) async {
    await _box.delete(url);
    notifyListeners();
  }
}
