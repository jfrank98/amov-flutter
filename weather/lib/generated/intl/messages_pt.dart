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

  static String m2(name) => "Bem vindo ${name}";

  static String m3(gender) =>
      "${Intl.gender(gender, female: 'Boas mana!', male: 'Boas mano!', other: 'Boas pessoa!')}";

  static String m4(role) => "${Intl.select(role, {
            'admin': 'Boas admin!',
            'manager': 'Boas gestor!',
            'other': 'Boas visitante!',
          })}";

  static String m5(maxTemp) => "Temperatura máxima: ${maxTemp}";

  static String m6(minTemp) => "Temperature mínima: ${minTemp}";

  static String m7(howMany) =>
      "${Intl.plural(howMany, one: '1 mensagem', other: '${howMany} mensagens')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "pageCurrentTemperature": m0,
        "pageDaily": MessageLookupByLibrary.simpleMessage("Diariamente"),
        "pageFeelsLike": m1,
        "pageHomeConfirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
        "pageHomeWelcome": m2,
        "pageHomeWelcomeGender": m3,
        "pageHomeWelcomeRole": m4,
        "pageHourly": MessageLookupByLibrary.simpleMessage("Por hora"),
        "pageMaxTemp": m5,
        "pageMinTemp": m6,
        "pageNotificationsCount": m7,
        "pageRefreshWeatherData":
            MessageLookupByLibrary.simpleMessage("Atualizar")
      };
}
