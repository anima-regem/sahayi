import 'package:flutter/material.dart';
import 'package:sahayi_study/helper/open_pdf.dart';
import 'package:sahayi_study/pages/downloads_page.dart';
import '../helper/data_variables.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ModulesPage extends StatelessWidget {
  final int dataIndex;
  const ModulesPage({Key? key, required this.dataIndex}) : super(key: key);
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

    var items = data[dataIndex];
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 0),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_left),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${items['name']}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${items['modules'].length} Contents",
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: IconButton(
                          icon: const Icon(
                            Icons.folder_outlined,
                            color: Color.fromRGBO(89, 00, 00, 1),
                          ),
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        (const DownloadPage())))
                          },
                        )),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),
              ListView(),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: items['modules'].length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<bool>(
                        future: checkExist(dataIndex, index),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListTile(
                                leading: snapshot.data == true
                                    ? const Icon(
                                        Icons.book,
                                      )
                                    : const Icon(Icons.book_outlined),
                                title:
                                    Text("Module ${items['modules'][index]}"),
                                trailing: const Icon(Icons.arrow_right_sharp),
                                onTap: () {
                                  showAlertDialog(
                                      context, snapshot.data == true);
                                  OpenPDF(
                                    context: context,
                                    moduleNo: index,
                                    indexNo: dataIndex,
                                  );
                                });
                          } else {
                            return Container(
                                child: const Center(
                                    child: CircularProgressIndicator()));
                          }
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, bool downoladed) async {
  // Create button
  Widget okButton = ElevatedButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    actionsPadding: const EdgeInsets.all(20),
    titlePadding: const EdgeInsets.all(20),
    title: const Text("Opening PDF"),
    content: downoladed
        ? const Text("Your note is opening")
        : const Text("The file is being downloaded"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
