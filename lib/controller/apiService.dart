import 'dart:convert';
import 'package:bhagavad_gita/model/ChapterDetailsModel.dart';
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

  static Future<ChapterDetails> fetchDetailsChapter(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/chapters/?:ch=$id'));
      if (response.statusCode == 200) {
        // Check if response body is a list
        dynamic jsonResponse = json.decode(response.body);
        if (jsonResponse is List) {
          // Handle list response (for example, take the first item)
          if (jsonResponse.isNotEmpty) {
            return ChapterDetails.fromJson(jsonResponse[0]);
          } else {
            throw Exception('Empty list returned');
          }
        } else if (jsonResponse is Map<String, dynamic>) {
          // Handle map response
          return ChapterDetails.fromJson(jsonResponse);
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        print('Failed to load chapter details: ${response.statusCode}');
        throw Exception('Failed to load chapter details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching chapter details: $e');
      throw Exception('Error fetching chapter details');
    }
  }


}
