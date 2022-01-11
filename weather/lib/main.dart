import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'providers/weather_api.dart';
import 'dart:developer' as developer;

Future main() async {
  await dotenv.load(fileName: "assets/.env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('pt', ''), // Portuguese, no country code
      ],
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherAPI wapi = WeatherAPI();
  double currentTemperature = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      //backgroundColor: const Color(0xFF003166),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.15, vertical: height * 0.15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TextField(
            //   style: const TextStyle(color: Colors.white, fontSize: 25),
            //   textAlign: TextAlign.center,
            //   decoration: InputDecoration(
            //       filled: true,
            //       fillColor: const Color(0xFF0055b3),
            //       //contentPadding: const EdgeInsets.all(100),
            //       hintText: "City name",
            //       hintStyle: const TextStyle(color: Colors.white),
            //       border: InputBorder.none,
            //       focusedBorder: OutlineInputBorder(
            //         gapPadding: 200,
            //         borderSide: const BorderSide(color: Colors.white),
            //         borderRadius: BorderRadius.circular(25.7),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         gapPadding: 200,
            //         borderSide: const BorderSide(color: Color(0xFF0055b3)),
            //         borderRadius: BorderRadius.circular(25.7),
            //       )),
            //   onChanged: (val) {
            //     //setState(() => wapi.city = val);
            //   },
            // ),
            Text(
              '${currentTemperature.toStringAsFixed(0)} ºC',
              style: const TextStyle(fontSize: 35),
            ),
            ElevatedButton(
              onPressed: () async {
                double temp = await wapi.currentTemperature;
                developer.log("aaaaaaaaaaaaaaa rtghrhSRHWE");
                setState(() {
                  currentTemperature = temp;
                });
              },
              child: Text(
                S.of(context).pageHomeWelcome('nozes'),
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
