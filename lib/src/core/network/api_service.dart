import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> get(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // log('API LOG ${response.body}');
      log('API LOG ${url}');
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }
}
