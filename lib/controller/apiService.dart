// services/api_service.dart
import 'dart:convert';
import 'package:bhagavad_gita/model/CommentaryModel.dart';
import 'package:bhagavad_gita/model/TextModel.dart';
import 'package:bhagavad_gita/model/TranslationModel.dart';
import 'package:bhagavad_gita/model/TransliterationModel.dart';
import 'package:bhagavad_gita/model/dataModel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Chapter> getChapter(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/chapter/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Chapter.fromJson(data['chapter']);
    } else {
      throw Exception('Failed to load chapter');
    }
  }

  Future<Commentary> getCommentary(int chapter, int verse) async {
    final response = await http.get(Uri.parse('$baseUrl/text/commentaries/$chapter/$verse'));

    if (response.statusCode == 200) {
      return Commentary.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load commentary');
    }
  }

  Future<TextModel> getText(int chapter, int verse) async {
    final response = await http.get(Uri.parse('$baseUrl/text/$chapter/$verse'));

    if (response.statusCode == 200) {
      return TextModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load text');
    }
  }

  Future<Translation> getTranslation(int chapter, int verse) async {
    final response = await http.get(Uri.parse('$baseUrl/text/translations/$chapter/$verse'));

    if (response.statusCode == 200) {
      return Translation.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load translation');
    }
  }

  Future<Transliteration> getTransliteration(int chapter, int verse) async {
    final response = await http.get(Uri.parse('$baseUrl/text/transliterations/$chapter/$verse'));

    if (response.statusCode == 200) {
      return Transliteration.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load transliteration');
    }
  }
}
