// models/transliteration.dart
class Transliteration {
  final String transliteration;

  Transliteration({required this.transliteration});

  factory Transliteration.fromJson(Map<String, dynamic> json) {
    return Transliteration(
      transliteration: json['transliteration'] as String,
    );
  }
}
