// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Requests {
  String weather_request = "";

  setCoordinates(double? lat, double? lon) {
    weather_request =
        "https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${dotenv.env['API_KEY']}";
  }

  set city(String city) {
    weather_request =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=${dotenv.env['API_KEY']}";
  }

  String get currentWeather {
    return weather_request;
  }
}
