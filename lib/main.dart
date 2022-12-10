import 'package:flutter/material.dart';
import '/pages/home_page.dart';
import 'pages/landing_page.dart';

void main() {
  runApp(const Sahayi());
}

class Sahayi extends StatelessWidget {
  const Sahayi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sahayi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: LadingPage(),
      home: HomePage(),
    );
  }
}
