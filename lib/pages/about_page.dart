import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          toolbarHeight: MediaQuery.of(context).size.height * 0.13,
          backgroundColor: Theme.of(context).canvasColor,
          foregroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_left),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "About",
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Feel free to contribute to the project!"),
                const SelectableText("https://github.com/anima-regem/sahayi"),
                Icon(Icons.favorite)
              ]),
        ));
  }
}
