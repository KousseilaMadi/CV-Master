import 'package:cv_maker/Pages/Home.dart';
import 'package:cv_maker/Utility/Colors.dart';
import 'package:cv_maker/Utility/CvGen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'Utility/StorageHandler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await readFromStorage();
  await readFromCustomData();
  runApp(App());
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
