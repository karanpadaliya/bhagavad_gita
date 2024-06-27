// screens/translation_page.dart
import 'package:bhagavad_gita/controller/apiService.dart';
import 'package:bhagavad_gita/model/TranslationModel.dart';
import 'package:flutter/material.dart';

class TranslationPage extends StatefulWidget {
  @override
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  final ApiService apiService = ApiService(baseUrl: 'https://bhagavadgita.theaum.org');
  Translation? translation;
  int chapter = 1;
  int verse = 1;
  bool loading = false;

  void fetchTranslation() async {
    setState(() {
      loading = true;
    });
    try {
      final fetchedTranslation = await apiService.getTranslation(chapter, verse);
      setState(() {
        translation = fetchedTranslation;
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
        title: Text('Text Translations by Chapter and Verse'),
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
              onPressed: fetchTranslation,
              child: Text('Fetch Translation'),
            ),
            SizedBox(height: 20),
            if (loading) CircularProgressIndicator(),
            if (translation != null) Text(translation!.translation),
          ],
        ),
      ),
    );
  }
}
