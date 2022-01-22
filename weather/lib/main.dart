import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

import 'views/main_page.dart';

Future main() async {
  await dotenv.load(fileName: "assets/.env");

  runApp(const MyApp());
}

const localizationsDelegates = <LocalizationsDelegate>[
  S.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];

const supportedLocales = [
  Locale('en', ''), // English, no country code
  Locale('pt', ''), // Portuguese, no country code
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Dongle'),
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      home: const MainPage(),
      localeResolutionCallback: (
        locale,
        supportedLocales,
      ) {
        if (supportedLocales.contains(Locale(locale!.languageCode))) {
          return locale;
        } else {
          return const Locale('en', '');
        }
      },
    );
  }
}
