import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String imagePath;
  final String id;
  final String author;
  final String resolution;
  final String url;
  final String downloadUrl;
  final int index;

  DetailsPage(
      {@required this.imagePath,
      this.id,
      this.author,
      this.resolution,
      this.url,
      this.downloadUrl,
      @required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          textTheme: Theme.of(context).textTheme,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Hero(
                  tag: 'logo$index',
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CacheImage(imagePath),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Id: $id',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Author: $author',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Resolution: $resolution',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Url: $url',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Download url: $downloadUrl',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
