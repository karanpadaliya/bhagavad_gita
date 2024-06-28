import 'package:flutter/material.dart';
import 'package:bhagavad_gita/controller/apiService.dart';
import 'package:bhagavad_gita/model/ChapterDetailsModel.dart'; // Import ChapterDetails if you haven't

class DetailsPage extends StatelessWidget {
  final int chapterId;

  DetailsPage({required this.chapterId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${chapterId}'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<ChapterDetails>(
        key: UniqueKey()  ,
        future: ApiService.fetchDetailsChapter(chapterId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching chapter details'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data available'));
          } else {
            ChapterDetails chapterDetails = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chapterDetails.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Translation: ${chapterDetails.translation}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Transliteration: ${chapterDetails.transliteration}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Meaning (EN): ${chapterDetails.meaningEN}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Meaning (HI): ${chapterDetails.meaningHI}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Summary (EN): ${chapterDetails.summaryEN}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Summary (HI): ${chapterDetails.summaryHI}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
