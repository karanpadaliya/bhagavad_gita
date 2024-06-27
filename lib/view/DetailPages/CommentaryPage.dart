// screens/commentary_page.dart
import 'package:bhagavad_gita/controller/apiService.dart';
import 'package:bhagavad_gita/model/CommentaryModel.dart';
import 'package:flutter/material.dart';


class CommentaryPage extends StatefulWidget {
  @override
  _CommentaryPageState createState() => _CommentaryPageState();
}

class _CommentaryPageState extends State<CommentaryPage> {
  final ApiService apiService = ApiService(baseUrl: 'https://bhagavadgita.theaum.org');
  Commentary? commentary;
  int chapter = 1;
  int verse = 1;
  bool loading = false;

  void fetchCommentary() async {
    setState(() {
      loading = true;
    });
    try {
      final fetchedCommentary = await apiService.getCommentary(chapter, verse);
      setState(() {
        commentary = fetchedCommentary;
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
        title: Text('Text Commentaries by Chapter and Verse'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Chapter'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                chapter = int.tryParse(value) ?? 1;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Verse'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                verse = int.tryParse(value) ?? 1;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchCommentary,
              child: Text('Fetch Commentary'),
            ),
            SizedBox(height: 20),
            if (loading) CircularProgressIndicator(),
            if (commentary != null) Text(commentary!.commentary),
          ],
        ),
      ),
    );
  }
}
