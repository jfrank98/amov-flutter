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

  static String m2(name) => "Welcome ${name}";

  static String m3(gender) =>
      "${Intl.gender(gender, female: 'Hi woman!', male: 'Hi man!', other: 'Hi there!')}";

  static String m4(role) => "${Intl.select(role, {
            'admin': 'Hi admin!',
            'manager': 'Hi manager!',
            'other': 'Hi visitor!',
          })}";

  static String m5(maxTemp) => "Max. temperature: ${maxTemp}";

  static String m6(minTemp) => "Min. temperature: ${minTemp}";

  static String m7(howMany) =>
      "${Intl.plural(howMany, one: '1 message', other: '${howMany} messages')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "pageCurrentTemperature": m0,
        "pageFeelsLike": m1,
        "pageHomeConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "pageHomeWelcome": m2,
        "pageHomeWelcomeGender": m3,
        "pageHomeWelcomeRole": m4,
        "pageMaxTemp": m5,
        "pageMinTemp": m6,
        "pageNotificationsCount": m7
      };
}
