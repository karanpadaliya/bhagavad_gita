// models/translation.dart
class Translation {
  final String translation;

  Translation({required this.translation});

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      translation: json['translation'] as String,
    );
  }
}
