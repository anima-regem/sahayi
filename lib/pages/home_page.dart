import 'package:flutter/material.dart';
import 'package:sahayi_study/pages/modules_page.dart';
import '../helper/data_variables.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subjectData = data;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sahayi'),
        ),
        body: Container(
          child: ListView.separated(
              itemBuilder: ((context, index) {
                return ListTile(
                  title: Text("${subjectData[index]['name']}"),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              (ModulesPage(dataIndex: index)))),
                );
              }),
              separatorBuilder: (context, index) => (Divider()),
              itemCount: subjectData.length),
        ));
  }
}
