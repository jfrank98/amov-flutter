// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Confirm`
  String get pageHomeConfirm {
    return Intl.message(
      'Confirm',
      name: 'pageHomeConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Welcome {name}`
  String pageHomeWelcome(Object name) {
    return Intl.message(
      'Welcome $name',
      name: 'pageHomeWelcome',
      desc: '',
      args: [name],
    );
  }

  /// `{gender, select, male {Hi man!} female {Hi woman!} other {Hi there!}}`
  String pageHomeWelcomeGender(String gender) {
    return Intl.gender(
      gender,
      male: 'Hi man!',
      female: 'Hi woman!',
      other: 'Hi there!',
      name: 'pageHomeWelcomeGender',
      desc: '',
      args: [gender],
    );
  }

  /// `{role, select, admin {Hi admin!} manager {Hi manager!} other {Hi visitor!}}`
  String pageHomeWelcomeRole(Object role) {
    return Intl.select(
      role,
      {
        'admin': 'Hi admin!',
        'manager': 'Hi manager!',
        'other': 'Hi visitor!',
      },
      name: 'pageHomeWelcomeRole',
      desc: '',
      args: [role],
    );
  }

  /// `{howMany, plural, one{1 message} other{{howMany} messages}}`
  String pageNotificationsCount(num howMany) {
    return Intl.plural(
      howMany,
      one: '1 message',
      other: '$howMany messages',
      name: 'pageNotificationsCount',
      desc: '',
      args: [howMany],
    );
  }

  /// `Current temperature: {temp}`
  String pageCurrentTemperature(Object temp) {
    return Intl.message(
      'Current temperature: $temp',
      name: 'pageCurrentTemperature',
      desc: '',
      args: [temp],
    );
  }

  /// `Feels like: {feelsLike}`
  String pageFeelsLike(Object feelsLike) {
    return Intl.message(
      'Feels like: $feelsLike',
      name: 'pageFeelsLike',
      desc: '',
      args: [feelsLike],
    );
  }

  /// `Max. temperature: {maxTemp}`
  String pageMaxTemp(Object maxTemp) {
    return Intl.message(
      'Max. temperature: $maxTemp',
      name: 'pageMaxTemp',
      desc: '',
      args: [maxTemp],
    );
  }

  /// `Min. temperature: {minTemp}`
  String pageMinTemp(Object minTemp) {
    return Intl.message(
      'Min. temperature: $minTemp',
      name: 'pageMinTemp',
      desc: '',
      args: [minTemp],
    );
  }

  /// `Refresh`
  String get pageRefreshWeatherData {
    return Intl.message(
      'Refresh',
      name: 'pageRefreshWeatherData',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get pageDaily {
    return Intl.message(
      'Daily',
      name: 'pageDaily',
      desc: '',
      args: [],
    );
  }

  /// `Hourly`
  String get pageHourly {
    return Intl.message(
      'Hourly',
      name: 'pageHourly',
      desc: '',
      args: [],
    );
  }

  /// `Return to main page`
  String get pageReturnToMain {
    return Intl.message(
      'Return to main page',
      name: 'pageReturnToMain',
      desc: '',
      args: [],
    );
  }

  /// `Sunrise: {sunrise}`
  String pageSunrise(Object sunrise) {
    return Intl.message(
      'Sunrise: $sunrise',
      name: 'pageSunrise',
      desc: '',
      args: [sunrise],
    );
  }

  /// `Sunset: {sunset}`
  String pageSunset(Object sunset) {
    return Intl.message(
      'Sunset: $sunset',
      name: 'pageSunset',
      desc: '',
      args: [sunset],
    );
  }

  /// `Moonrise: {moonrise}`
  String pageMoonrise(Object moonrise) {
    return Intl.message(
      'Moonrise: $moonrise',
      name: 'pageMoonrise',
      desc: '',
      args: [moonrise],
    );
  }

  /// `Moonset: {moonset}`
  String pageMoonset(Object moonset) {
    return Intl.message(
      'Moonset: $moonset',
      name: 'pageMoonset',
      desc: '',
      args: [moonset],
    );
  }

  /// `Last updated: {updateTime}`
  String pageLastUpdate(Object updateTime) {
    return Intl.message(
      'Last updated: $updateTime',
      name: 'pageLastUpdate',
      desc: '',
      args: [updateTime],
    );
  }

  /// `Forecast time: {forecast}`
  String pageForecastTime(Object forecast) {
    return Intl.message(
      'Forecast time: $forecast',
      name: 'pageForecastTime',
      desc: '',
      args: [forecast],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
