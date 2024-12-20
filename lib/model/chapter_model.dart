class Chapter {
  final int chapterNumber;
  final int versesCount;
  final String name;
  final String translation;
  final String transliteration;
  final String summaryEN;
  final String summaryHI;

  Chapter({
    required this.chapterNumber,
    required this.versesCount,
    required this.name,
    required this.translation,
    required this.transliteration,
    required this.summaryEN,
    required this.summaryHI,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      chapterNumber: json['chapter_number'],
      versesCount: json['verses_count'],
      name: json['name'],
      translation: json['translation'],
      transliteration: json['transliteration'],
      summaryEN: json['summary']['en'],
      summaryHI: json['summary']['hi'],
    );
  }
}
