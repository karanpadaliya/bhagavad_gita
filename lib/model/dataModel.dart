// models/chapter.dart
class Chapter {
  final int id;
  final String name;
  final String meaning;
  final String summary;

  Chapter({
    required this.id,
    required this.name,
    required this.meaning,
    required this.summary,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'] as int,
      name: json['name'] as String,
      meaning: json['meaning'] as String,
      summary: json['summary'] as String,
    );
  }
}
