import 'package:flutter/material.dart';

class ListViewer extends StatelessWidget {
  final List<String> items;
  const ListViewer({Key? key, required this.items}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Viewer'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.book_online_rounded),
            title: Text(items[index]),
            onTap: () => {},
          );
        },
      ),
    );
  }
}
