import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bhagavad_gita/model/chapter_model.dart';

class ApiService {
  static const String baseUrl = 'https://bhagavadgitaapi.in';

  static Future<List<Chapter>> fetchChapters() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/chapters'));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((chapter) => Chapter.fromJson(chapter)).toList();
      } else {
        throw Exception('Failed to load chapters: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching chapters: $e');
      throw Exception('Error fetching chapters');
    }
  }

  static Future<Chapter> fetchChapterDetails(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/chapter/$id'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Chapter.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load chapter detail: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching chapter details: $e');
      throw Exception('Error fetching chapter details');
    }
  }
}
