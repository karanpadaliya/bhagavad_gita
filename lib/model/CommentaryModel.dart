// models/commentary.dart
class Commentary {
  final String commentary;

  Commentary({required this.commentary});

  factory Commentary.fromJson(Map<String, dynamic> json) {
    return Commentary(
      commentary: json['commentary'] as String,
    );
  }
}
