import 'package:location/location.dart';

import 'weather_info.dart';

class SelfUpdatedWeatherData {
  double? cityLat;
  double? cityLon;
  late WeatherInfo current;
  List<WeatherInfo> hourly = List.empty();
  List<WeatherInfo> daily = List.empty();

  Location location = Location();
  LocationData? _locationData;

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;

  SelfUpdatedWeatherData() {}

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

  updateAllWeatherData(Map<String, dynamic> json) {
    cityLon = json['lon'] as double;
    cityLat = json['lat'] as double;

    current = WeatherInfo.fromJson(json, json['current'], false);

    //hourlyArray = json['hourly'] as Map<String, dynamic>;

    //hourly.add(WeatherInfo.fromJson(json['hourly']));
    //daily.add(WeatherInfo.fromJson(json['daily']));
  }

  getCurrentWeather() {}

  getRawWeatherData() {}
}
