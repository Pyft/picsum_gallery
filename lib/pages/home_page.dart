import 'dart:convert'; // json_serializable вызывал ошибку "mirrors is not supported"
import 'dart:math';

import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollControllerToTop = ScrollController();
  Random randomValue = Random();
  int startIndex = 2021;
  bool buttonPushingFlag = false;

  Future<Map<String, dynamic>> imageInfo(
      {String imagePath = 'https://picsum.photos/seed/0/10/10',
      int index,
      BuildContext context}) async {
    /// Получение информации об изображении и вызов страницы с детальным отображением информации и увеличенным изображением.
    Map<String, dynamic> imageInfo = {
      'id': '134',
      'author': 'Charlie Foster',
      'width': '4928',
      'height': '3264',
      'url': 'https://unsplash.com/photos/Osl4I3IS9Cw',
      'download_url': 'https://picsum.photos/id/134/4928/3264'
    };
    await http.get(imagePath).then(
      (response) {
        imageInfo['id'] = response.headers['picsum-id'];
      },
    ).catchError(
      (error) {
        print("Error1: $error");
      },
    );
    await http.get('https://picsum.photos/id/${imageInfo['id']}/info').then(
      (response) {
        imageInfo = jsonDecode(response.body);
      },
    ).catchError(
      (error) {
        print("Error2: $error");
      },
    );
    if (imageInfo['height'] > imageInfo['width']) {
      imagePath =
          'https://picsum.photos/id/${imageInfo['id']}/${imageInfo['width']}/${imageInfo['width']}';
    } else {
      imagePath = imageInfo['download_url'];
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          imagePath: imagePath,
          index: index,
          id: imageInfo['id'],
          author: imageInfo['author'],
          resolution: '${imageInfo['width']} x ${imageInfo['height']}',
          url: imageInfo['url'],
          downloadUrl: imageInfo['download_url'],
        ),
      ),
    );
    buttonPushingFlag = false;
    return imageInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('Picsum gallery'),
          textTheme: Theme.of(context).textTheme,
          leading: Icon(Icons.image),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: GridView.builder(
              controller: scrollControllerToTop,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 25,
                mainAxisSpacing: 25,
              ),
              itemBuilder: (context, index) {
                return RawMaterialButton(
                  onPressed: () {
                    if (!buttonPushingFlag) {
                      buttonPushingFlag = true;
                      imageInfo(
                        imagePath:
                            'https://picsum.photos/seed/${startIndex + index}/10/10',
                        index: index,
                        context: context,
                      );
                    }
                  },
                  child: Hero(
                    tag: 'logo$index',
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: CacheImage(
                              'https://picsum.photos/seed/${startIndex + index}/150/150'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 12,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.cached),
          onPressed: () => setState(
            () {
              startIndex = randomValue.nextInt(10000);
              scrollControllerToTop.animateTo(
                0.0,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 10),
              );
            },
          ),
        ),
      ),
    );
  }
}
