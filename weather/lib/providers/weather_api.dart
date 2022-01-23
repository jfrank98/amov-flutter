import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/weather_info.dart';

class WeatherAPI {
  static Future<Map<String, dynamic>> fetchWeatherData(
      double? latitude, double? longitude) async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=minutely,alerts&units=metric&appid=${dotenv.env['API_KEY']}"));

    //For some reason the rectangular parentheses are needed for the body to be read correctly
    final data = jsonDecode("[" + response.body + "]");

    //data[0] because jsonDecode returns a List<dynamic> (at least in this case) which has a Map<String, dynamic> as its first element.
    return data[0];
  }

  static Future<WeatherInfo> parseCurrentWeatherData(
          Map<String, dynamic> json) async =>
      WeatherInfo.fromJson(json, json['current'], false, false);

  static Future<List<WeatherInfo>> parseHourlyWeatherData(
      Map<String, dynamic> json) async {
    var hourlyArray = json['hourly'];
    List<WeatherInfo> returnArray = [];

    for (var hourly in hourlyArray) {
      returnArray.add(WeatherInfo.fromJson(json, hourly, false, true));
    }

    return returnArray;
  }

  static Future<List<WeatherInfo>> parseDailyWeatherData(
      Map<String, dynamic> json) async {
    var dailyArray = json['daily'];
    List<WeatherInfo> returnArray = [];

    for (var daily in dailyArray) {
      returnArray.add(WeatherInfo.fromJson(json, daily, true, false));
    }

    return returnArray;
  }

  static Future<String?> getLocationFromCoordinates(
      double lat, double lon) async {
    final response = await http.get(Uri.parse(
        "http://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lon&limit=10&appid=${dotenv.env['API_KEY']}"));

    final data = jsonDecode(response.body);

    return data[0]['name'];
  }

  static String getWeatherPT(String weatherMain) {
    switch (weatherMain) {
      case 'Clouds':
        weatherMain = 'Nublado';
        break;
      case 'Rain':
        weatherMain = 'Chuva';
        break;
      case 'Drizzle':
        weatherMain = 'Chuvisco';
        break;
      case 'Thunderstorm':
        weatherMain = 'Trovoada';
        break;
      case 'Snow':
        weatherMain = 'Neve';
        break;
      case 'Clear':
        weatherMain = 'Limpo';
        break;
      case 'Mist':
        weatherMain = 'Névoa';
        break;
      case 'Smoke':
        weatherMain = 'Fumo no Ar';
        break;
      case 'Haze':
        weatherMain = 'Neblina';
        break;
      case 'Dust':
        weatherMain = 'Pó no Ar';
        break;
      case 'Fog':
        weatherMain = 'Nevoeiro';
        break;
      case 'Sand':
        weatherMain = 'Areia no Ar';
        break;
      case 'Ash':
        weatherMain = 'Cinza no Ar';
        break;
      case 'Squall':
        weatherMain = 'Tempestade';
        break;
    }
    return weatherMain;
  }

  static getUrlForIcon(String iconId) {
    return 'https://openweathermap.org/img/wn/$iconId@2x.png';
  }
}
