// screens/chapter_page.dart
import 'package:bhagavad_gita/controller/apiService.dart';
import 'package:flutter/material.dart';

import '../../model/dataModel.dart';

class ChapterPage extends StatefulWidget {
  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  final ApiService apiService = ApiService(baseUrl: 'https://bhagavadgita.theaum.org');
  Chapter? chapter;
  int chapterId = 1;
  bool loading = false;

  void fetchChapter() async {
    setState(() {
      loading = true;
    });
    try {
      final fetchedChapter = await apiService.getChapter(chapterId);
      setState(() {
        chapter = fetchedChapter;
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Chapter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Chapter ID'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                chapterId = int.tryParse(value) ?? 1;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchChapter,
              child: Text('Fetch Chapter'),
            ),
            SizedBox(height: 20),
            if (loading) CircularProgressIndicator(),
            if (chapter != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${chapter!.name}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Meaning: ${chapter!.meaning}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('Summary: ${chapter!.summary}', style: TextStyle(fontSize: 16)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
