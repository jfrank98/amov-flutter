class WeatherData {
  final double degrees;
  final double cityLon;
  final double cityLat;
  final double windSpeed;
  final int sunriseTime;
  final int sunsetTime;

  const WeatherData({
    required this.degrees,
    required this.cityLon,
    required this.cityLat,
    required this.windSpeed,
    required this.sunriseTime,
    required this.sunsetTime,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      degrees: json['current']['temp'] as double,
      cityLon: json['lon'] as double,
      cityLat: json['lat'] as double,
      windSpeed: json['current']['wind_speed'] as double,
      sunriseTime: json['current']['sunrise'] as int,
      sunsetTime: json['current']['sunset'] as int,
    );
  }

  double get currentTemperature {
    return degrees;
  }
}
