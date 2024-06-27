// screens/chapter_detail_page.dart
import 'package:bhagavad_gita/controller/apiService.dart';
import 'package:bhagavad_gita/model/dataModel.dart';
import 'package:flutter/material.dart';


class ChapterDetailPage extends StatelessWidget {
  final int chapterId;
  final ApiService apiService = ApiService(baseUrl: 'https://bhagavadgitaapi.in');

  ChapterDetailPage({required this.chapterId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chapter Details'),
      ),
      body: FutureBuilder<Chapter>(
        future: apiService.getChapter(chapterId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No details available'));
          } else {
            final chapter = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chapter.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Meaning:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    chapter.meaning,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Summary:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    chapter.summary,
                    style: TextStyle(fontSize: 16),
                  ),
                  // Add more details here if available
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
