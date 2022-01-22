// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static String m0(temp) => "Temperature atual: ${temp}";

  static String m1(feelsLike) => "Parecem: ${feelsLike}";

  static String m2(forecast) => "Forecast time: ${forecast}";

  static String m3(name) => "Bem vindo ${name}";

  static String m4(gender) =>
      "${Intl.gender(gender, female: 'Boas mana!', male: 'Boas mano!', other: 'Boas pessoa!')}";

  static String m5(role) => "${Intl.select(role, {
            'admin': 'Boas admin!',
            'manager': 'Boas gestor!',
            'other': 'Boas visitante!',
          })}";

  static String m6(updateTime) => "Last updated: ${updateTime}";

  static String m7(maxTemp) => "Temperatura máxima: ${maxTemp}";

  static String m8(minTemp) => "Temperature mínima: ${minTemp}";

  static String m9(moonrise) => "Nascer da lua: ${moonrise}";

  static String m10(moonset) => "Pôr da lua: ${moonset}";

  static String m11(howMany) =>
      "${Intl.plural(howMany, one: '1 mensagem', other: '${howMany} mensagens')}";

  static String m12(sunrise) => "Nasecer do sol: ${sunrise}";

  static String m13(sunset) => "Pôr do sol: ${sunset}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "pageCurrentTemperature": m0,
        "pageDaily": MessageLookupByLibrary.simpleMessage("Diariamente"),
        "pageFeelsLike": m1,
        "pageForecastTime": m2,
        "pageHomeConfirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
        "pageHomeWelcome": m3,
        "pageHomeWelcomeGender": m4,
        "pageHomeWelcomeRole": m5,
        "pageHourly": MessageLookupByLibrary.simpleMessage("Por hora"),
        "pageLastUpdate": m6,
        "pageMaxTemp": m7,
        "pageMinTemp": m8,
        "pageMoonrise": m9,
        "pageMoonset": m10,
        "pageNotificationsCount": m11,
        "pageRefreshWeatherData":
            MessageLookupByLibrary.simpleMessage("Atualizar"),
        "pageReturnToMain":
            MessageLookupByLibrary.simpleMessage("Voltar à página principal"),
        "pageSunrise": m12,
        "pageSunset": m13
      };
}
