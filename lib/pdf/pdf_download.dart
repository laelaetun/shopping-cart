import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

Future<void> downloadPdf(String url, String fileName) async {
  try {
    // Request storage permission (Android)
    if (Platform.isAndroid) {
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        print("Permission denied!");
        return;
      }
    }

    // Get device directory
    Directory directory;
    if (Platform.isAndroid) {
      directory = (await getExternalStorageDirectory())!;
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    String filePath = "${directory.path}/$fileName.pdf";

    // Download PDF
    Dio dio = Dio();
    await dio.download(url, filePath);

    print("PDF saved to $filePath");
  } catch (e) {
    print("Error downloading PDF: $e");
  }
}

class PdfDownloadPage extends StatelessWidget {
  final String pdfUrl =
      "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Download PDF Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await downloadPdf(pdfUrl, "sample_file");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('PDF Downloaded Successfully!')),
            );
          },
          child: Text('Download PDF'),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: PdfDownloadPage()));
