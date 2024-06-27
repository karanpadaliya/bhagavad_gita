// models/text.dart
class TextModel {
  final String text;

  TextModel({required this.text});

  factory TextModel.fromJson(Map<String, dynamic> json) {
    return TextModel(
      text: json['text'] as String,
    );
  }
}
