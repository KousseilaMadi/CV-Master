import 'dart:io';
import 'package:cv_maker/Utility/Colors.dart';
import 'package:cv_maker/Utility/CvGen.dart';
import 'package:cv_maker/Utility/Dialogs.dart';
import 'package:cv_maker/Utility/Percent.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:flutter/material.dart';
import 'package:cv_maker/l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// ignore: must_be_immutable
class Preview extends StatefulWidget {
  int cvId;
  Preview({required this.cvId, super.key});
  @override
  State<Preview> createState() => _Preview();
}

class _Preview extends State<Preview> {
  @override
  Widget build(BuildContext context) {
    Future<void> DownloadCV() async {
      const downloadsFolderPath = '/storage/emulated/0/Download/';
      Directory dir = Directory(downloadsFolderPath);
      File file = File(
          '${dir.path}/${st.CVs[widget.cvId].personalInformation.fullName}_${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}.pdf');
      var status = await Permission.storage.status;
      print(status);
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      }
      print(status);

      File fileToDownload = File('');
      if (status == PermissionStatus.granted) {
        fileToDownload = File(
            '/data/user/0/com.ukiyo.cvmaster/cache/${st.CVs[widget.cvId].personalInformation.fullName}_CV_${widget.cvId.toString()}.pdf');
        try {
          await file
              .writeAsBytes(await fileToDownload.readAsBytes())
              .then((value) => {
                    customDialog(
                        context,
                        AppLocalizations.of(context)!.fileSaved,
                        ' ${AppLocalizations.of(context)!.savedIn} ${dir}')
                  });
        } catch (err) {
          customDialog(
              context, AppLocalizations.of(context)!.error, err.toString());
          print('err:$err');
        }
      }
    }

    return WillPopScope(
        child: Scaffold(
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
                  child: SfPdfViewer.file(
                    File(
                        '/data/user/0/com.ukiyo.cvmaster/cache/${st.CVs[widget.cvId].personalInformation.fullName}_CV_${widget.cvId.toString()}.pdf'),
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        });
  }
}
