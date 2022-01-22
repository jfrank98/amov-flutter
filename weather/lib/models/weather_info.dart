// ignore_for_file: prefer_typing_uninitialized_variables

class WeatherInfo {
  final double temp;
  final double windSpeed;
  final int sunriseTime;
  final int sunsetTime;
  final int moonrise;
  final int moonset;
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
  final String iconId;

  WeatherInfo(
      {required this.moonrise,
      required this.moonset,
      required this.iconId,
      required this.maxTemp,
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
        precipitation = 0.0,
        sunrise = 0,
        sunset = 0,
        visibility = 0,
        moonrise = 0,
        moonset = 0;

    temperature = json['temp'];
    feelsLikeTemp = json['feels_like'];
    maxTemperature = originalJSON['daily'][0]['temp']['max'];
    minTemperature = originalJSON['daily'][0]['temp']['min'];
    if (hourly) {
      sunrise = 0;
      sunset = 0;
      precipitation = json['pop'].toDouble();
    } else if (daily) {
      temperature = json['temp']['day'];
      feelsLikeTemp = json['feels_like']['day'];
      maxTemperature = json['temp']['max'];
      minTemperature = json['temp']['min'];
      moonrise = json['moonrise'];
      moonset = json['moonset'];
      sunrise = json['sunrise'];
      sunset = json['sunset'];
    } else {
      sunrise = json['sunrise'];
      sunset = json['sunset'];
      precipitation = originalJSON['hourly'][0]['pop'].toDouble();
    }

    return WeatherInfo(
        iconId: json['weather'][0]['icon'],
        temp: temperature.toDouble(),
        maxTemp: maxTemperature.toDouble(),
        minTemp: minTemperature.toDouble(),
        feelsLike: feelsLikeTemp.toDouble(),
        date: json['dt'],
        windSpeed: json['wind_speed'].toDouble(),
        sunriseTime: sunrise,
        sunsetTime: sunset,
        moonrise: moonrise,
        moonset: moonset,
        clouds: json['clouds'],
        weather: json['weather'][0]['main'],
        humidity: json['humidity'],
        uvi: json['uvi'].toDouble(),
        visibility: visibility,
        precipitation: precipitation);
  }

  double? get currentTemperature {
    return temp;
  }
}
