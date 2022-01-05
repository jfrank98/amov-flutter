class WeatherData {
  final double degrees;
  final double cityLon;
  final double cityLat;
  final String country;
  final double windSpeed;
  final int sunriseTime;
  final int sunsetTime;

  const WeatherData({
    required this.degrees,
    required this.cityLon,
    required this.cityLat,
    required this.country,
    required this.windSpeed,
    required this.sunriseTime,
    required this.sunsetTime,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      degrees: json['main']['temp'] as double,
      cityLon: json['coord']['lon'] as double,
      cityLat: json['coord']['lat'] as double,
      country: json['sys']['country'] as String,
      windSpeed: json['wind']['speed'] as double,
      sunriseTime: json['sys']['sunrise'] as int,
      sunsetTime: json['sys']['sunset'] as int,
    );
  }

  double get currentTemperature {
    return degrees;
  }
}
