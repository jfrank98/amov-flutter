import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather/generated/l10n.dart';
import 'package:weather/models/weather_info.dart';
import 'package:weather/providers/weather_api.dart';

import 'dart:developer' as developer;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  WeatherAPI wapi = WeatherAPI();
  double currentTemperature = 0;

  double? cityLat;
  double? cityLon;
  late WeatherInfo current;
  List<WeatherInfo> hourly = List.empty();
  List<WeatherInfo> daily = List.empty();

  Location location = Location();
  LocationData? _locationData;

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;

  Future<void> _fetchLocation() async {
    // Verificar estado do serviço
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }

    // Pede permissões em runtime
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }

    await _getCoordinates();

    //setState(() {});
    // Desafio de usar o onLocationChanged
    location.onLocationChanged.listen(((locationData) {
      _locationData = locationData;
    }));
  }

  Future<void> _getCoordinates() async {
    _locationData = await location.getLocation();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
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
                await _fetchLocation();
                var json = await WeatherAPI.fetchWeatherData(
                        _locationData?.latitude, _locationData?.longitude)
                    as Map<String, dynamic>;
                current = await WeatherAPI.parseCurrentWeatherData(json);
                //developer.log(
                //await WeatherAPI.parseDailyWeatherData(json).toString());
                developer.log("aaaaaaaaaaaaaaa rtghrhSRHWE");
                setState(() {
                  currentTemperature = current.temp;
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
