import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather/weather_data.dart';
import 'requests.dart';

class WeatherAPI {
  Requests request = Requests();

  Future<WeatherData> fetchWeatherData() async {
    final response = await http.get(Uri.parse(request.currentWeather));

    //For some reason the rectangular parentheses are needed for the body to be read correctly
    final data = jsonDecode("[" + response.body + "]");

    //data[0] because jsonDecode returns a List<dynamic> (at least in this case) which has a Map<String, dynamic> as its first element.
    return WeatherData.fromJson(data[0]);
  }

  set city(String city) {
    request.city = city;
  }

  Future<double> get currentTemperature async => await fetchWeatherData()
      .then((weatherData) => weatherData.currentTemperature - 273.15);
}
