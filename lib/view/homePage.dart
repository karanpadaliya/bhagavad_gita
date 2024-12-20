import 'package:flutter/material.dart';
import 'package:bhagavad_gita/controller/apiService.dart';
import 'package:bhagavad_gita/view/DetailsPage.dart';
import 'package:bhagavad_gita/model/chapter_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Chapter>> futureChapters;
  final List<String> imgList = [
    'assets/images/splash_image.jpg',
    'https://www.shutterstock.com/image-photo/beautifully-colored-sculpture-showing-shri-600nw-2341729481.jpg',
    'https://static.langimg.com/photo/imgsize-198273,msid-91257575/navbharat-times.jpg',
  ];

  @override
  void initState() {
    super.initState();
    futureChapters = ApiService.fetchChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Bhagavad Gita Chapters'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: imgList.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                      ),
                      child: item.startsWith('http')
                          ? CachedNetworkImage(
                              imageUrl: item,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : Image.asset(item, fit: BoxFit.cover),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Chapter>>(
              future: futureChapters,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching chapters'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No chapters available'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Chapter chapter = snapshot.data![index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10.0),
                          leading:
                              const Icon(Icons.book, color: Colors.deepPurple),
                          title: Text(
                            chapter.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(Icons.arrow_forward,
                              color: Colors.deepPurple),
                          onTap: () {
                            print(
                                "chapter.chapterNumber ====> ${chapter.chapterNumber}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                  chapterId: chapter.chapterNumber,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
