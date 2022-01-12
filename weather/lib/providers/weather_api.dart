import 'dart:convert';
import 'dart:developer';
import 'package:location/location.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/weather_data.dart';
import 'package:weather/models/weather_info.dart';
import '../requests.dart';
import 'dart:developer' as developer;

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
      WeatherInfo.fromJson(json, json['current'], false);

  static Future<List<WeatherInfo>> parseHourlyWeatherData(
      Map<String, dynamic> json) async {
    var hourlyArray = json['hourly'];
    List<WeatherInfo> returnArray = List.empty();

    for (var hourly in hourlyArray) {
      returnArray.add(WeatherInfo.fromJson(json, hourly, false));
    }

    return returnArray;
  }

  static Future<List<WeatherInfo>> parseDailyWeatherData(
      Map<String, dynamic> json) async {
    var dailyArray = json['daily'];
    List<WeatherInfo> returnArray = [];

    for (var daily in dailyArray) {
      returnArray.add(WeatherInfo.fromJson(json, daily, true));
    }

    return returnArray;
  }
}
