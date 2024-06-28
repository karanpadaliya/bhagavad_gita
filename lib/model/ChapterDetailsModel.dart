class ChapterDetails {
  final int chapterNumber;
  final int versesCount;
  final String name;
  final String translation;
  final String transliteration;
  final String meaningEN;
  final String meaningHI;
  final String summaryEN;
  final String summaryHI;

  ChapterDetails({
    required this.chapterNumber,
    required this.versesCount,
    required this.name,
    required this.translation,
    required this.transliteration,
    required this.meaningEN,
    required this.meaningHI,
    required this.summaryEN,
    required this.summaryHI,
  });

  factory ChapterDetails.fromJson(Map<String, dynamic> json) {
    return ChapterDetails(
      chapterNumber: json['chapter_number'],
      versesCount: json['verses_count'],
      name: json['name'],
      translation: json['translation'],
      transliteration: json['transliteration'],
      meaningEN: json['meaning']['en'],
      meaningHI: json['meaning']['hi'],
      summaryEN: json['summary']['en'],
      summaryHI: json['summary']['hi'],
    );
  }
}
