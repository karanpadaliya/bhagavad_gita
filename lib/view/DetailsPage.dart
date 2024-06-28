import 'package:flutter/material.dart';
import 'package:bhagavad_gita/controller/apiService.dart';
import 'package:bhagavad_gita/model/chapter_model.dart';

class DetailsPage extends StatefulWidget {
  final int chapterId;

  DetailsPage({required this.chapterId});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<Chapter> futureChapter;

  @override
  void initState() {
    super.initState();
    futureChapter = ApiService.fetchChapterDetails(widget.chapterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chapter Details'),
      ),
      body: FutureBuilder<Chapter>(
        future: futureChapter,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No chapter details available'));
          } else {
            Chapter chapter = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chapter.name??"chapter.name_404",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Chapter Number: ${chapter.chapterNumber}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Summary: ${chapter.summary}',
                    style: TextStyle(fontSize: 16),
                  ),
                  // Add other details you want to display
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
