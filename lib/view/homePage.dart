import 'dart:async';
import 'dart:io';

import 'package:bhagavad_gita/controller/apiService.dart';
import 'package:bhagavad_gita/model/chapter_model.dart';
import 'package:bhagavad_gita/view/DetailsPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import cached_network_image
import 'package:flutter/material.dart';

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
        title: Text('Bhagavad Gita Chapters'),
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
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                      ),
                      child: item.startsWith('http')
                          ? CachedNetworkImage(
                              imageUrl: item,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
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
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error fetching chapters'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No chapters available'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Chapter chapter = snapshot.data![index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10.0),
                          leading: Icon(Icons.book, color: Colors.deepPurple),
                          title: Text(
                            chapter.name??"chapter.name_404",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(Icons.arrow_forward,
                              color: Colors.deepPurple),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsPage(chapterId: chapter.chapterNumber??404),
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
