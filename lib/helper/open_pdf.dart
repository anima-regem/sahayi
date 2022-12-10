import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import './data_variables.dart';

class OpenPDF extends StatefulWidget {
  final int moduleNo;
  final int indexNo;
  const OpenPDF({super.key, required this.moduleNo, required this.indexNo});

  @override
  State<OpenPDF> createState() => _OpenPDFState();
}

class _OpenPDFState extends State<OpenPDF> {
  void downloadFile(String url, String fileName) async {
    print('REadched dwnld');
    if (await checkFile(fileName)) {
      Directory dirPath = await getApplicationDocumentsDirectory();
      String fileFullPath = dirPath.path + fileName;
      OpenFile.open(fileFullPath);
      return;
    }
    try {
      String urlPath = url + fileName;
      print(urlPath);
      Dio dio = Dio();
      Response response = await dio.get(
        urlPath,
        onReceiveProgress: (rec, total) => (print("${(rec / total) * 100}%")),
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response.headers);
      File file = File(fileName);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      Directory dirPath = await getApplicationDocumentsDirectory();
      String fileFullPath = dirPath.path + fileName;
      OpenFile.open(fileFullPath);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkFile(String fileName) async {
    print('checkfile');
    Directory dirPath = await getApplicationDocumentsDirectory();
    if (await File('${dirPath.path}/$fileName').exists()) {
      print('file found');
      return true;
    } else {
      print('not found');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    String fileName = data[widget.indexNo]['code'] +
        '/' +
        "M${data[widget.indexNo]['modules'][widget.moduleNo]}.pdf";
    print(baseURL);
    print(fileName);
    downloadFile(baseURL, fileName);
    return Container();
  }
}
