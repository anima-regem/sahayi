import 'package:flutter/material.dart';
import 'package:sahayi_study/helper/open_pdf.dart';
import '../helper/data_variables.dart';

class ModulesPage extends StatelessWidget {
  final int dataIndex;
  const ModulesPage({Key? key, required this.dataIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var items = data[dataIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Viewer'),
      ),
      body: ListView.builder(
        itemCount: items['modules'].length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.bookmark_add_rounded),
            title: Text("Module ${items['modules'][index]}"),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => (OpenPDF(
                            moduleNo: index,
                            indexNo: dataIndex,
                          )))))
            },
          );
        },
      ),
    );
  }
}
