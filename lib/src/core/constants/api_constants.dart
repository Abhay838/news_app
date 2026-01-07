class ApiConstants {
  static const String baseUrl = "https://newsapi.org/v2";
  static const String apiKey = "f21e969318304db395690e2f698d0b80";

  static String categoryNews(String category, int page) =>
      "$baseUrl/top-headlines?country=us&category=$category&page=$page&apiKey=$apiKey";
}
