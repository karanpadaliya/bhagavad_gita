import 'package:flutter/material.dart';
import 'package:bhagavad_gita/controller/apiService.dart';
import 'package:bhagavad_gita/model/ChapterDetailsModel.dart'; // Import ChapterDetails if you haven't

class DetailsPage extends StatefulWidget {
  final int chapterId;

  DetailsPage({required this.chapterId});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String _selectedLanguage = 'EN'; // Default language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Chapter ${widget.chapterId}'),
        backgroundColor: Colors.deepPurple,
        actions: [
          PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            icon: Icon(Icons.language), // Change the icon here
            onSelected: (String value) {
              setState(() {
                _selectedLanguage = value;
              });
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'EN',
                  child: Row(
                    children: [
                      _selectedLanguage == 'EN'
                          ? Text(
                              'English',
                              style: TextStyle(color: Colors.deepPurple),
                            )
                          : Text('English'),
                      Spacer(),
                      if (_selectedLanguage == 'EN')
                        Icon(Icons.check, color: Colors.deepPurple),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'HI',
                  child: Row(
                    children: [
                      _selectedLanguage == 'HI'
                          ? Text(
                              'Hindi',
                              style: TextStyle(color: Colors.deepPurple),
                            )
                          : Text("Hindi"),
                      Spacer(),
                      if (_selectedLanguage == 'HI')
                        Icon(Icons.check, color: Colors.deepPurple),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: FutureBuilder<ChapterDetails>(
        key: UniqueKey(),
        future: ApiService.fetchDetailsChapter(widget.chapterId),
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
                  _selectedLanguage == 'EN'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Meaning (EN): ${chapterDetails.meaningEN}',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Summary (EN): ${chapterDetails.summaryEN}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Meaning (HI): ${chapterDetails.meaningHI}',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Summary (HI): ${chapterDetails.summaryHI}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
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
