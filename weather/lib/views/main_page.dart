import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/generated/l10n.dart';
import 'package:weather/models/weather_info.dart';
import 'package:weather/providers/weather_api.dart';

import 'dart:developer' as developer;

import 'package:weather/views/details_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

enum FORECAST_TYPE { HOURLY, DAILY }

class _MainPageState extends State<MainPage> {
  WeatherAPI wapi = WeatherAPI();
  double currentTemperature = 0, feelsLike = 0, maxTemp = 0, minTemp = 0;
  List<bool> isSelected = [false, true];
  String date = '', weatherMain = '';
  String imageUrl = '';
  String? city = '';

  late WeatherInfo current;
  List<WeatherInfo> hourly = List.empty();
  List<WeatherInfo> daily = List.empty();
  FORECAST_TYPE requestedForecast = FORECAST_TYPE.DAILY;

  Location location = Location();
  LocationData? _locationData;

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    imageUrl = "https://openweathermap.org/img/wn/10d@2x.png";
    _getDataFromSharedPreferences();

    location.onLocationChanged.listen(((locationData) {
      _locationData = locationData;
    }));
  }

  Future<void> _fetchLocation() async {
    // Verificar estado do serviço
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }

    // Pede permissões em runtime
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }

    await _getCoordinates();
    setState(() {});
    city = await WeatherAPI.getLocationFromCoordinates(
        _locationData?.latitude ?? 0, _locationData?.longitude ?? 0);
  }

  Future<void> _getCoordinates() async {
    _locationData = await location.getLocation();
    setState(() {});
  }

  Future<void> _getDataFromSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> weatherData;
    String? weatherDataStr = preferences.getString('weatherData');
    city = preferences.getString('city');

    if (weatherDataStr == null || city == null) {
      await _fetchLocation();

      var json = await WeatherAPI.fetchWeatherData(
          _locationData?.latitude, _locationData?.longitude);

      await _updateDataFromSharedPreferences(json);
      weatherDataStr = preferences.getString('weatherData');
      city = preferences.getString('city');
    }
    weatherData = jsonDecode(weatherDataStr!) as Map<String, dynamic>;

    current = await WeatherAPI.parseCurrentWeatherData(weatherData);
    hourly = await WeatherAPI.parseHourlyWeatherData(weatherData);
    daily = await WeatherAPI.parseDailyWeatherData(weatherData);

    setState(() {
      date = DateFormat.Hms()
          .format(DateTime.fromMillisecondsSinceEpoch(current.date * 1000));
      feelsLike = current.feelsLike;
      currentTemperature = current.temp;
      maxTemp = current.maxTemp;
      minTemp = current.minTemp;
      imageUrl = WeatherAPI.getUrlForIcon(current.iconId);
      weatherMain = current.weather;
    });
  }

  Future<void> _updateDataFromSharedPreferences(
      Map<String, dynamic> json) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('weatherData', jsonEncode(json));
    preferences.setString('city', city ?? '');
  }

  void _updateWeatherData() async {
    await _fetchLocation();
    var json = await WeatherAPI.fetchWeatherData(
        _locationData?.latitude, _locationData?.longitude);

    current = await WeatherAPI.parseCurrentWeatherData(json);
    hourly = await WeatherAPI.parseHourlyWeatherData(json);
    daily = await WeatherAPI.parseDailyWeatherData(json);

    setState(() {
      date = DateFormat.Hms()
          .format(DateTime.fromMillisecondsSinceEpoch(current.date * 1000));
      feelsLike = current.feelsLike;
      currentTemperature = current.temp;

      weatherMain = current.weather;
      imageUrl = WeatherAPI.getUrlForIcon(current.iconId);
      developer.log("aferg ${json['lat']} ${json['lon']}");
    });

    _updateDataFromSharedPreferences(json);
  }

  List<Widget> _getChildrenForHorizontalWeather() {
    List<Widget> widgetList = [];

    switch (requestedForecast) {
      case FORECAST_TYPE.DAILY:
        var i = 1;
        for (WeatherInfo dailyInfo in daily) {
          widgetList.add(InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPage(
                              selectedWeatherInfo: dailyInfo,
                              city: city,
                            )));
              },
              //splashColor: const Color(0xFF000000),
              child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset.zero,
                            blurRadius: 6,
                            blurStyle: BlurStyle.outer)
                      ],
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFbd93f9), Color(0x69bd93f9)]),
                      //color: const Color(0x69bd93f9),
                      border: Border.all(
                          color: const Color(0xFFf8f8f2),
                          style: BorderStyle.none),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                          child: Column(
                        children: [
                          Text(
                              DateFormat.E().format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      dailyInfo.date * 1000)),
                              style: const TextStyle(
                                  color: Color(0xFFf8f8f2), fontSize: 20)),
                          Image.network(
                            WeatherAPI.getUrlForIcon(dailyInfo.iconId),
                            scale: 2,
                          ),
                          Text('${dailyInfo.temp.round()} °C',
                              style: const TextStyle(
                                  color: Color(0xFFf8f8f2), fontSize: 20)),
                        ],
                      ))))));
        }

        break;
      case FORECAST_TYPE.HOURLY:
        var i = 1;
        for (var hourlyInfo in hourly) {
          widgetList.add(Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset.zero,
                        blurRadius: 6,
                        blurStyle: BlurStyle.outer)
                  ],
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFbd93f9), Color(0x69bd93f9)]),
                  border: Border.all(
                      color: const Color(0xFFf8f8f2), style: BorderStyle.none),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                      child: Column(
                    children: [
                      Text(
                          DateFormat.Hm().add_E().format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  hourlyInfo.date * 1000)),
                          style: const TextStyle(
                              color: Color(0xFFf8f8f2), fontSize: 20)),
                      Image.network(
                        WeatherAPI.getUrlForIcon(hourlyInfo.iconId),
                        scale: 2,
                      ),
                      Text('${hourlyInfo.temp.round()} °C',
                          style: const TextStyle(
                              color: Color(0xFFf8f8f2), fontSize: 20)),
                    ],
                  )))));
        }
        break;
    }

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 30, color: Color(0xfff8f8f2));

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: _updateWeatherData,
          tooltip: S.of(context).pageRefreshWeatherData,
          child: const Icon(Icons.refresh),
          backgroundColor: const Color(0xFFab82e8),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 20),
          color: const Color(0xFF282a36),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                verticalDirection: VerticalDirection.down,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    city ?? '',
                    style: const TextStyle(
                        fontSize: 40,
                        color: Color(0xffff79c6),
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset.zero,
                              blurRadius: 20,
                              blurStyle: BlurStyle.outer)
                        ],
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFbd93f9), Color(0x69bd93f9)]),
                        //color: const Color(0x69bd93f9),
                        border: Border.all(
                            color: const Color(0xFFf8f8f2),
                            style: BorderStyle.none),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 50, right: 50, top: 30, bottom: 30),
                        child: Column(
                          children: [
                            Text(
                              weatherMain,
                              style: textStyle,
                            ),
                            Image.network(
                              imageUrl,
                              scale: 0.8,
                            ),
                            Text(
                              "${currentTemperature.round()}°C",
                              style: textStyle,
                            ),
                            Text(
                              '${S.of(context).pageFeelsLike(feelsLike.round())}°C',
                              style: const TextStyle(
                                  color: Color(0xfff8f8f2), fontSize: 25),
                            ),
                            Text(S.of(context).pageLastUpdate(date),
                                style: const TextStyle(
                                    fontSize: 25, color: Color(0xfff8f8f2)))
                          ],
                        )),
                  ),
                  Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xAA44475a),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset.zero,
                              blurRadius: 10,
                              blurStyle: BlurStyle.outer)
                        ],
                      ),
                      child: Column(
                        children: [
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            buttonMinWidth: 20,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Color(0x69bd93f9)),
                                child: ToggleButtons(
                                    fillColor: const Color(0x69bd93f9),
                                    selectedColor: const Color(0xFF000000),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    textStyle: const TextStyle(fontSize: 20),
                                    constraints: const BoxConstraints(
                                        minWidth: 70,
                                        maxWidth: 200,
                                        minHeight: 30,
                                        maxHeight: 100),
                                    onPressed: (index) {
                                      setState(() {
                                        for (int buttonIndex = 0;
                                            buttonIndex < isSelected.length;
                                            buttonIndex++) {
                                          if (buttonIndex == index) {
                                            isSelected[buttonIndex] = true;
                                          } else {
                                            isSelected[buttonIndex] = false;
                                          }
                                        }

                                        if (index == 0) {
                                          requestedForecast =
                                              FORECAST_TYPE.HOURLY;
                                        } else {
                                          requestedForecast =
                                              FORECAST_TYPE.DAILY;
                                        }
                                      });
                                    },
                                    children: [
                                      Text(
                                        S.of(context).pageHourly,
                                      ),
                                      Text(
                                        S.of(context).pageDaily,
                                      )
                                    ],
                                    isSelected: isSelected),
                              ),
                            ],
                          ),
                          ShaderMask(
                            shaderCallback: (Rect rect) {
                              return const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.purple,
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.purple,
                                      ],
                                      stops: [0.0, 0.1, 0.9, 1.0],
                                      tileMode: TileMode
                                          .mirror // 10% purple, 80% transparent, 10% purple
                                      )
                                  .createShader(rect);
                            },
                            blendMode: BlendMode.dstOut,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 140,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: _getChildrenForHorizontalWeather(),
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          )),
    );
  }
}
