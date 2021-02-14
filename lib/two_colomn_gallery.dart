import 'package:flutter/material.dart';

import 'pages/home_page.dart';

class TwoColomnGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Picsum gallery',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(160, 190, 190, 1),
        textTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
        accentColor: Colors.amber,
      ),
      home: HomePage(),
    );
  }
}
