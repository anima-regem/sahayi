import 'package:flutter/material.dart';
import '../helper/data_variables.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../helper/open_pdf.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<bool> checkExist(indexNo, moduleNo) async {
      String fileName = data[indexNo]['code'] +
          '/' +
          "M${data[indexNo]['modules'][moduleNo]}.pdf";
      Directory dirPath = await getApplicationDocumentsDirectory();
      File file = File('${dirPath.path}/$fileName');
      if (await file.exists()) {
        return true;
      } else {
        return false;
      }
    }

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
            "Downloads",
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.folder_open_sharp),
                            title: Text("${data[index]['name']}"),
                            trailing: const Icon(Icons.arrow_drop_down_sharp),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: ListView.builder(
                                itemCount: data[index]['modules'].length,
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder:
                                    (BuildContext context, int mindex) {
                                  return FutureBuilder<bool>(
                                      future: checkExist(index, mindex),
                                      builder: (context, snapshot) {
                                        if (snapshot.data == true) {
                                          return ListTile(
                                              leading: const Icon(Icons.book),
                                              title: Text(
                                                  "Module ${data[index]['modules'][mindex]}"),
                                              trailing: const Icon(
                                                  Icons.arrow_right_sharp),
                                              onTap: () {
                                                OpenPDF(
                                                  context: context,
                                                  moduleNo: mindex,
                                                  indexNo: index,
                                                );
                                              });
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      });
                                }),
                          ),
                        ],
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
