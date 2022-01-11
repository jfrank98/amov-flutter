class WeatherInfo {
  final double temp;
  final double windSpeed;
  final int sunriseTime;
  final int sunsetTime;
  final double feelsLike;
  final int clouds;
  final String weather;
  final int humidity;
  final int uvi;
  final int visibility;

  const WeatherInfo(
      {required this.temp,
      required this.windSpeed,
      required this.sunriseTime,
      required this.sunsetTime,
      required this.feelsLike,
      required this.clouds,
      required this.weather,
      required this.humidity,
      required this.uvi,
      required this.visibility});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
        temp: json['temp'] as double,
        windSpeed: json['wind_speed'] as double,
        sunriseTime: json['sunrise'] as int,
        sunsetTime: json['sunset'] as int,
        feelsLike: json['feels_like'] as double,
        clouds: json['clouds'] as int,
        weather: json['weather'][0]['main'] as String,
        humidity: json['humidity'] as int,
        uvi: json['uvi'],
        visibility: json['visibility']);
  }

  double get currentTemperature {
    return temp;
  }
}
