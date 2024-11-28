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
            icon: const Icon(Icons.language), // Change the icon here
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
                          ? const Text(
                              'English',
                              style: TextStyle(color: Colors.deepPurple),
                            )
                          : const Text('English'),
                      const Spacer(),
                      if (_selectedLanguage == 'EN')
                        const Icon(Icons.check, color: Colors.deepPurple),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'HI',
                  child: Row(
                    children: [
                      _selectedLanguage == 'HI'
                          ? const Text(
                              'Hindi',
                              style: TextStyle(color: Colors.deepPurple),
                            )
                          : const Text("Hindi"),
                      const Spacer(),
                      if (_selectedLanguage == 'HI')
                        const Icon(Icons.check, color: Colors.deepPurple),
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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching chapter details'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          } else {
            ChapterDetails chapterDetails = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chapterDetails.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Translation: ${chapterDetails.translation}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Transliteration: ${chapterDetails.transliteration}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16.0),
                  _selectedLanguage == 'EN'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Meaning (EN): ${chapterDetails.meaningEN}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'Summary (EN): ${chapterDetails.summaryEN}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Meaning (HI): ${chapterDetails.meaningHI}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'Summary (HI): ${chapterDetails.summaryHI}',
                              style: const TextStyle(fontSize: 18),
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
