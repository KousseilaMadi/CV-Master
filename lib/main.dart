import 'dart:io';

import 'package:cv_maker/Pages/Home.dart';
import 'package:cv_maker/Utility/Colors.dart';
import 'package:cv_maker/Utility/CvGen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Utility/StorageHandler.dart';
import 'package:cv_maker/l10n/app_localizations.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await readFromStorage();
  await readFromCustomData();
  runApp(RestartWidget(child: App()));
}

class App extends StatelessWidget {
  App({super.key});
// make statful widget and make it rerender in each button click

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cv_maker',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('es'),
        Locale('it'),
        Locale('fr'),
        Locale('tr'),
        Locale('ru'),
        Locale('de'),
        Locale('hi'),
        Locale('ar'),
      ],
      locale: Locale(st.AppLanguage),
      theme: ThemeData(
        fontFamily: 'Outfit',
        colorScheme: ColorScheme.fromSeed(seedColor: colors.highlight),
        useMaterial3: true,
      ),
      // home: PDFView(
      //   filePath:
      //       '/data/user/0/com.ukiyo.cvmaster/cache/${st.CVs[0].personalInformation.fullName}_CV.pdf',
      // ),
      home: Home(),
    );
  }
}

class RestartWidget extends StatefulWidget {
  final Widget child;
  RestartWidget({required this.child});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidget>()!.restartApp();
  }

  @override
  _RestartWidget createState() => _RestartWidget();
}

class _RestartWidget extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      return KeyedSubtree(
        key: key,
        child: widget.child,
      );
    } catch (e) {
      print(e);
    }
    return widget.child;
  }
}
