// To parse this JSON data, do
//
//     final chapter = chapterFromJson(jsonString);

import 'dart:convert';

List<Chapter> chapterFromJson(String str) => List<Chapter>.from(json.decode(str).map((x) => Chapter.fromJson(x)));

String chapterToJson(List<Chapter> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Chapter {
  int? chapterNumber;
  int? versesCount;
  String? name;
  String? translation;
  String? transliteration;
  Meaning? meaning;
  Meaning? summary;

  Chapter({
    this.chapterNumber,
    this.versesCount,
    this.name,
    this.translation,
    this.transliteration,
    this.meaning,
    this.summary,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    chapterNumber: json["chapter_number"],
    versesCount: json["verses_count"],
    name: json["name"],
    translation: json["translation"],
    transliteration: json["transliteration"],
    meaning: json["meaning"] == null ? null : Meaning.fromJson(json["meaning"]),
    summary: json["summary"] == null ? null : Meaning.fromJson(json["summary"]),
  );

  Map<String, dynamic> toJson() => {
    "chapter_number": chapterNumber,
    "verses_count": versesCount,
    "name": name,
    "translation": translation,
    "transliteration": transliteration,
    "meaning": meaning?.toJson(),
    "summary": summary?.toJson(),
  };
}

class Meaning {
  String? en;
  String? hi;

  Meaning({
    this.en,
    this.hi,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) => Meaning(
    en: json["en"],
    hi: json["hi"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "hi": hi,
  };
}
