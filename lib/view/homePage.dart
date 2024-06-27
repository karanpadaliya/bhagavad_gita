// screens/home_page.dart
import 'package:bhagavad_gita/view/DetailPages/ChapterPage.dart';
import 'package:bhagavad_gita/view/DetailPages/CommentaryPage.dart';
import 'package:bhagavad_gita/view/DetailPages/TextPage.dart';
import 'package:bhagavad_gita/view/DetailPages/TranslationPage.dart';
import 'package:bhagavad_gita/view/DetailPages/TransliterationPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bhagavad Gita'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Text by Chapter and Verse'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => TextPage()));
            },
          ),
          ListTile(
            title: Text('Text Translations by Chapter and Verse'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TranslationPage()));
            },
          ),
          ListTile(
            title: Text('Text Transliterations by Chapter and Verse'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TransliterationPage()));
            },
          ),
          ListTile(
            title: Text('Text Commentaries by Chapter and Verse'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CommentaryPage()));
            },
          ),
          ListTile(
            title: Text('Get Chapter'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ChapterPage()));
            },
          ),
        ],
      ),
    );
  }
}
