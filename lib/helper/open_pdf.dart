import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import './data_variables.dart';

class OpenPDF {
  final int moduleNo;
  final int indexNo;

  OpenPDF(
      {required BuildContext context,
      required this.moduleNo,
      required this.indexNo}) {
    PDFOpen(context);
  }

  bool isDownloaded = false;
  void downloadFile(String url, String fileName) async {
    print('REadched dwnld');
    Directory dirPath = await getApplicationDocumentsDirectory();
    File file = File('${dirPath.path}/$fileName');
    if (await file.exists()) {
      OpenFile.open(file.path);
      return;
    }
    try {
      String urlPath = url + fileName;
      Dio dio = Dio();
      Response response = await dio.get(
        urlPath,
        onReceiveProgress: (count, total) =>
            {print(((count / total) * 100).toStringAsFixed(0))},
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: true,
            sendTimeout: 100000,
            receiveTimeout: 100000,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      if (!await file.exists()) {
        await file.create(recursive: true);
      }
      await file.writeAsBytes(response.data);
      OpenFile.open(file.path);
    } catch (e) {
      // print(e);
    }
  }

  void PDFOpen(BuildContext context) {
    final String fileName = data[indexNo]['code'] +
        '/' +
        "M${data[indexNo]['modules'][moduleNo]}.pdf";
    downloadFile(baseURL, fileName);
    // showAlertDialog(context);
  }
}
