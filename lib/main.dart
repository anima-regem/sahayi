import 'package:flutter/material.dart';
import '/pages/downloads_page.dart';
import '/pages/home_page.dart';
import '/pages/landing_page.dart';

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
          fontFamily: 'Poppins',
          primarySwatch: Colors.red,
        ),
        // home: LadingPage(),
        home: LandingPage());
  }
}
