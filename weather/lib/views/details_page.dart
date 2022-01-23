import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:weather/generated/l10n.dart';
import 'package:weather/models/weather_info.dart';
import 'package:weather/providers/weather_api.dart';
import 'package:weather/views/main_page.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage(
      {Key? key,
      required this.selectedWeatherInfo,
      required this.city,
      required this.index})
      : super(key: key);

  final WeatherInfo selectedWeatherInfo;
  final String? city;
  final int index;
  @override
  Widget build(BuildContext context) {
    findSystemLocale();
    const textStyle = TextStyle(fontSize: 30, color: Color(0xfff8f8f2));

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MainPage()));
          },
          tooltip: S.of(context).pageRefreshWeatherData,
          child: const Icon(Icons.arrow_back),
          backgroundColor: const Color(0xFFab82e8),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF282a36), Color(0xFF282a36)])),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
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
                      decoration: _getBoxDecoration(),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, top: 30, bottom: 30),
                          child: Column(
                            children: [
                              Text(
                                  index == 0
                                      ? S.of(context).pageToday
                                      : DateFormat.yMEd(Intl.systemLocale)
                                          .format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  selectedWeatherInfo.date *
                                                      1000)),
                                  style: const TextStyle(
                                      color: Color(0xFFf8f8f2), fontSize: 30)),
                              Text(
                                Intl.systemLocale == 'pt_PT'
                                    ? WeatherAPI.getWeatherPT(
                                        selectedWeatherInfo.weather)
                                    : selectedWeatherInfo.weather,
                                style: textStyle,
                              ),
                              Image.network(
                                WeatherAPI.getUrlForIcon(
                                    selectedWeatherInfo.iconId),
                                scale: 0.8,
                              ),
                              Text(
                                "${selectedWeatherInfo.temp.round()}°C",
                                style: textStyle,
                              ),
                              Text(
                                  S.of(context).pageForecastTime(
                                      DateFormat.Hms().format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              selectedWeatherInfo.date *
                                                  1000))),
                                  style: const TextStyle(
                                      fontSize: 25, color: Color(0xfff8f8f2)))
                            ],
                          ))),
                  Container(
                    width: 230,
                    decoration: _getBoxDecoration(),
                    child: Column(
                      verticalDirection: VerticalDirection.down,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Max: ${selectedWeatherInfo.maxTemp.round()}°C',
                              style: textStyle,
                            ),
                            Text(
                              'Min: ${selectedWeatherInfo.minTemp.round()}°C',
                              style: textStyle,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 340,
                    decoration: _getBoxDecoration(),
                    child: Column(
                      verticalDirection: VerticalDirection.down,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              S.of(context).pageSunrise(DateFormat.Hms().format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      selectedWeatherInfo.sunriseTime * 1000))),
                              style: textStyle,
                            ),
                            Text(
                              S.of(context).pageSunset(DateFormat.Hms().format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      selectedWeatherInfo.sunsetTime * 1000))),
                              style: textStyle,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 340,
                    decoration: _getBoxDecoration(),
                    child: Column(
                      verticalDirection: VerticalDirection.down,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              S.of(context).pageMoonrise(DateFormat.Hms()
                                  .format(DateTime.fromMillisecondsSinceEpoch(
                                      selectedWeatherInfo.moonrise * 1000))),
                              style: textStyle,
                            ),
                            Text(
                              S.of(context).pageMoonset(DateFormat.Hms().format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      selectedWeatherInfo.moonset * 1000))),
                              style: textStyle,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getBoxDecoration() {
    return BoxDecoration(
        boxShadow: const [
          BoxShadow(
              offset: Offset.zero, blurRadius: 20, blurStyle: BlurStyle.outer)
        ],
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFbd93f9), Color(0x69bd93f9)]),
        //color: const Color(0x69bd93f9),
        border:
            Border.all(color: const Color(0xFFf8f8f2), style: BorderStyle.none),
        borderRadius: const BorderRadius.all(Radius.circular(20)));
  }
}
