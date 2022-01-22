// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(temp) => "Current temperature: ${temp}";

  static String m1(feelsLike) => "Feels like: ${feelsLike}";

  static String m2(forecast) => "Forecast time: ${forecast}";

  static String m3(name) => "Welcome ${name}";

  static String m4(gender) =>
      "${Intl.gender(gender, female: 'Hi woman!', male: 'Hi man!', other: 'Hi there!')}";

  static String m5(role) => "${Intl.select(role, {
            'admin': 'Hi admin!',
            'manager': 'Hi manager!',
            'other': 'Hi visitor!',
          })}";

  static String m6(updateTime) => "Last updated: ${updateTime}";

  static String m7(maxTemp) => "Max. temperature: ${maxTemp}";

  static String m8(minTemp) => "Min. temperature: ${minTemp}";

  static String m9(moonrise) => "Moonrise: ${moonrise}";

  static String m10(moonset) => "Moonset: ${moonset}";

  static String m11(howMany) =>
      "${Intl.plural(howMany, one: '1 message', other: '${howMany} messages')}";

  static String m12(sunrise) => "Sunrise: ${sunrise}";

  static String m13(sunset) => "Sunset: ${sunset}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "pageCurrentTemperature": m0,
        "pageDaily": MessageLookupByLibrary.simpleMessage("Daily"),
        "pageFeelsLike": m1,
        "pageForecastTime": m2,
        "pageHomeConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "pageHomeWelcome": m3,
        "pageHomeWelcomeGender": m4,
        "pageHomeWelcomeRole": m5,
        "pageHourly": MessageLookupByLibrary.simpleMessage("Hourly"),
        "pageLastUpdate": m6,
        "pageMaxTemp": m7,
        "pageMinTemp": m8,
        "pageMoonrise": m9,
        "pageMoonset": m10,
        "pageNotificationsCount": m11,
        "pageRefreshWeatherData":
            MessageLookupByLibrary.simpleMessage("Refresh"),
        "pageReturnToMain":
            MessageLookupByLibrary.simpleMessage("Return to main page"),
        "pageSunrise": m12,
        "pageSunset": m13
      };
}
