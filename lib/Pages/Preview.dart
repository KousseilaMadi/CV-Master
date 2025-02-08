import 'dart:io';

import 'package:cv_maker/Utility/Colors.dart';
import 'package:cv_maker/Utility/CvGen.dart';
import 'package:cv_maker/Utility/Percent.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class Preview extends StatelessWidget {
  int cvId;
  Preview({required this.cvId, super.key});

  void DownloadCV() async {
    const downloadsFolderPath = '/storage/emulated/0/Download/';
    Directory dir = Directory(downloadsFolderPath);
    File file = File(
        '${dir.path}/${st.CVs[cvId].personalInformation.fullName}_CV${DateTime.now().hour}_${DateTime.now().minute}_${DateTime.now().second}.pdf');
    var status = await Permission.storage.status;
    print(status);
    if (status != PermissionStatus.granted) {
      status = await Permission.storage.request();
    }
    File fileToDownload = File('');
    if (status == PermissionStatus.granted) {
      fileToDownload = File(
          '/data/user/0/com.ukiyo.cvmaster/cache/${st.CVs[cvId].personalInformation.fullName}_CV.pdf');
      try {
        await file!.writeAsBytes(await fileToDownload.readAsBytes());
      } on FileSystemException catch (err) {
        print('err:$err');
      }
    }

    // if (status.isGranted) {
    //   const downloadsFolderPath = '/storage/emulated/0/Download/';
    //   Directory dir = Directory(downloadsFolderPath);
    //   file = File(
    //       '${dir.path}/${st.CVs[cvId].personalInformation.fullName}_CV.pdf');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: colors.white),
            onPressed: () => {Navigator.pop(context)}),
        foregroundColor: colors.white,
        titleTextStyle: TextStyle(fontSize: 28),
        centerTitle: true,
        toolbarHeight: 56,
        title: Text(AppLocalizations.of(context)!.preview),
        backgroundColor: colors.primary,
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            DownloadCV();
          },
          backgroundColor: colors.gold,
          label: Text(
            AppLocalizations.of(context)!.download,
            style: TextStyle(fontSize: 18),
          )),
      body: Container(
        height: percent(100, 'h', context),
        width: percent(100, 'w', context),
        child: Column(
          children: [
            Container(
              height: 1.414 * percent(100, 'w', context),
              width: 1.0 * percent(100, 'w', context),
              child: PDFView(
                filePath:
                    '/data/user/0/com.ukiyo.cvmaster/cache/${st.CVs[cvId].personalInformation.fullName}_CV.pdf',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
