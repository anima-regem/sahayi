import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sahayi_study/pages/home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 2),
        () => {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()))
            });
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(75),
          child: Center(
              child: Image(
            image: AssetImage("assets/images/sahayiR.png"),
          )),
        ),
      ),
    );
  }
}
