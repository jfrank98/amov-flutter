// ignore_for_file: prefer_typing_uninitialized_variables

class WeatherInfo {
  final double temp;
  final double windSpeed;
  final int sunriseTime;
  final int sunsetTime;
  final double feelsLike;
  final int clouds;
  final String weather;
  final int humidity;
  final double uvi;
  final int visibility;
  final double maxTemp;
  final double minTemp;

  WeatherInfo(
      {required this.maxTemp,
      required this.minTemp,
      required this.temp,
      required this.windSpeed,
      required this.sunriseTime,
      required this.sunsetTime,
      required this.feelsLike,
      required this.clouds,
      required this.weather,
      required this.humidity,
      required this.uvi,
      required this.visibility});

  factory WeatherInfo.fromJson(Map<String, dynamic> originalJSON,
      Map<String, dynamic> json, bool daily) {
    var temperature, maxTemperature, minTemperature, feelsLikeTemp;

    if (daily) {
      temperature = json['temp']['day'];
      feelsLikeTemp = json['feels_like']['day'];
      maxTemperature = json['temp']['max'];
      minTemperature = json['temp']['min'];
    } else {
      temperature = json['temp'];
      feelsLikeTemp = json['feels_like'];
      maxTemperature = originalJSON['daily'][0]['temp']['max'];
      minTemperature = originalJSON['daily'][0]['temp']['min'];
    }

    return WeatherInfo(
        temp: temperature,
        maxTemp: maxTemperature,
        minTemp: minTemperature,
        feelsLike: feelsLikeTemp,
        windSpeed: json['wind_speed'],
        sunriseTime: json['sunrise'],
        sunsetTime: json['sunset'],
        clouds: json['clouds'],
        weather: json['weather'][0]['main'],
        humidity: json['humidity'],
        uvi: json['uvi'].toDouble(),
        visibility: json['visibility']);
  }

  double? get currentTemperature {
    return temp;
  }
}
