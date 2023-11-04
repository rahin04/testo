import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Photo> photos = [];
  bool isLoading = true;
  String error = '';

  Future<void> fetchPhotos() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        photos = jsonData.map((data) => Photo.fromJson(data)).toList();
      } else {
        error = response.body;
      }
    } catch (e) {
      error = e.toString();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (error.isNotEmpty) {
      return Center(child: Text(error));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Photos'),
      ),
      body: ListView.builder(
        itemCount: photos.length,
        itemBuilder: (context, index) {
          final photo = photos[index];
          return ListTile(
            title: Text(photo.title),
            leading: Container(
              width: 50,
                height: 50,
                child: Image.network(photo.thumbnailUrl)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PhotoDetailPage(photo)));
            },
          );
        },
      ),
    );
  }
}

class PhotoDetailPage extends StatelessWidget {
  final Photo photo;

  PhotoDetailPage(this.photo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(photo.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(photo.imageUrl),
            SizedBox(height: 20),
            Text(photo.title),
            SizedBox(height: 20),
            Text('ID: ${photo.id}')
          ],
        ),
      ),
    );
  }
}

class Photo {
  final int id;
  final String title;
  final String thumbnailUrl;
  final String imageUrl;

  Photo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        thumbnailUrl = json['thumbnailUrl'],
        imageUrl = json['url'];
}
//