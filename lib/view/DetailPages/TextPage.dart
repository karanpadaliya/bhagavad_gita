// screens/text_page.dart
import 'package:bhagavad_gita/controller/apiService.dart';
import 'package:bhagavad_gita/model/TextModel.dart';
import 'package:flutter/material.dart';


class TextPage extends StatefulWidget {
  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  final ApiService apiService = ApiService(baseUrl: 'https://bhagavadgita.theaum.org');
  TextModel? textModel;
  int chapter = 1;
  int verse = 1;
  bool loading = false;

  void fetchText() async {
    setState(() {
      loading = true;
    });
    try {
      final fetchedText = await apiService.getText(chapter, verse);
      setState(() {
        textModel = fetchedText;
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
        title: Text('Text by Chapter and Verse'),
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
              onPressed: fetchText,
              child: Text('Fetch Text'),
            ),
            SizedBox(height: 20),
            if (loading) CircularProgressIndicator(),
            if (textModel != null) Text(textModel!.text),
          ],
        ),
      ),
    );
  }
}
