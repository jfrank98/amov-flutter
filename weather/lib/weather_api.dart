import 'dart:convert';
import 'dart:developer';
import 'package:location/location.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather/weather_data.dart';
import 'requests.dart';
import 'dart:developer' as developer;

class WeatherAPI {
  Requests request = Requests();
  Location location = Location();

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  LocationData? _locationData;

  Future<WeatherData> fetchWeatherData() async {
    await _fetchLocation();

    developer.log(
        "lat: ${_locationData?.latitude} lon: ${_locationData?.longitude}");

    request.setCoordinates(_locationData?.latitude, _locationData?.longitude);

    final response = await http.get(Uri.parse(request.currentWeather));

    //For some reason the rectangular parentheses are needed for the body to be read correctly
    final data = jsonDecode("[" + response.body + "]");

    //data[0] because jsonDecode returns a List<dynamic> (at least in this case) which has a Map<String, dynamic> as its first element.
    return WeatherData.fromJson(data[0]);
  }

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

    // setState(() {});
    // Desafio de usar o onLocationChanged
    location.onLocationChanged.listen(((locationData) {
      _locationData = locationData;
    }));
  }

  Future<void> _getCoordinates() async {
    _locationData = await location.getLocation();
    //setState(() {});
  }

  Future<double> get currentTemperature async => await fetchWeatherData()
      .then((weatherData) => weatherData.currentTemperature - 273.15);
}
