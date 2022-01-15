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
  final double? precipitation;
  final int date;

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
      required this.visibility,
      required this.date,
      this.precipitation});

  factory WeatherInfo.fromJson(Map<String, dynamic> originalJSON,
      Map<String, dynamic> json, bool daily, bool hourly) {
    var temperature,
        maxTemperature,
        minTemperature,
        feelsLikeTemp,
        precipitation = 0.0;

    feelsLikeTemp = json['feels_like'];

    if (hourly) {
      precipitation = json['pop'];
    } else if (daily) {
      temperature = json['temp']['day'];
      feelsLikeTemp = json['feels_like']['day'];
      maxTemperature = json['temp']['max'];
      minTemperature = json['temp']['min'];
    } else {
      temperature = json['temp'];
      precipitation = originalJSON['hourly'][0]['pop'].toDouble();
      maxTemperature = originalJSON['daily'][0]['temp']['max'];
      minTemperature = originalJSON['daily'][0]['temp']['min'];
    }

    return WeatherInfo(
        temp: temperature,
        maxTemp: maxTemperature,
        minTemp: minTemperature,
        feelsLike: feelsLikeTemp,
        date: json['dt'],
        windSpeed: json['wind_speed'].toDouble(),
        sunriseTime: json['sunrise'],
        sunsetTime: json['sunset'],
        clouds: json['clouds'],
        weather: json['weather'][0]['main'],
        humidity: json['humidity'],
        uvi: json['uvi'].toDouble(),
        visibility: json['visibility'],
        precipitation: precipitation);
  }

  double? get currentTemperature {
    return temp;
  }
}
