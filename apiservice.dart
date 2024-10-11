import 'package:dio/dio.dart';

class NewsApiService {
  final Dio _dio = Dio();
  final String baseUrl =
      'https://my-json-server.typicode.com/Fallid/codelab-api/db';

  Future<List<dynamic>> fetchBitcoinNews() async {
    try {
      final response = await _dio.get(
        baseUrl,
      );

      if (response.statusCode == 200) {
        // Mengembalikan list artikel dari hasil API
        return response.data['articles'];
      } else {
        print('Failed to load news: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }
}
