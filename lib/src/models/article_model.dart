import 'package:hive/hive.dart';

part 'article_model.g.dart';

@HiveType(typeId: 0)
class Article extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final String url;

  @HiveField(4)
  final String date;

  @HiveField(5)
  final String author;

  Article({
    required this.title,
    required this.author,
    required this.content,
    required this.imageUrl,
    required this.url,
    required this.date,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
      date: json['publishedAt'] ?? '',
      author: json['author'] ?? '',
    );
  }
}
