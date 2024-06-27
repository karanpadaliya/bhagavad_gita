// screens/transliteration_page.dart
import 'package:bhagavad_gita/controller/apiService.dart';
import 'package:bhagavad_gita/model/TransliterationModel.dart';
import 'package:flutter/material.dart';

class TransliterationPage extends StatefulWidget {
  @override
  _TransliterationPageState createState() => _TransliterationPageState();
}

class _TransliterationPageState extends State<TransliterationPage> {
  final ApiService apiService = ApiService(baseUrl: 'https://bhagavadgita.theaum.org');
  Transliteration? transliteration;
  int chapter = 1;
  int verse = 1;
  bool loading = false;

  void fetchTransliteration() async {
    setState(() {
      loading = true;
    });
    try {
      final fetchedTransliteration = await apiService.getTransliteration(chapter, verse);
      setState(() {
        transliteration = fetchedTransliteration;
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
        title: Text('Text Transliterations by Chapter and Verse'),
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
              onPressed: fetchTransliteration,
              child: Text('Fetch Transliteration'),
            ),
            SizedBox(height: 20),
            if (loading) CircularProgressIndicator(),
            if (transliteration != null) Text(transliteration!.transliteration),
          ],
        ),
      ),
    );
  }
}
