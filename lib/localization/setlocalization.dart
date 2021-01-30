import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetLocalization {
  final Locale locale;

  SetLocalization(this.locale);

  static SetLocalization of(BuildContext context) {
    return Localizations.of<SetLocalization>(context, SetLocalization);
  }

  static const LocalizationsDelegate<SetLocalization> delegate =
      _getLocalizationDelegate();

  Map<String, String> _localizationStrings;
  Future load() async {
    String jsonString =
        await rootBundle.loadString('lib/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMAp = json.decode(jsonString);

    _localizationStrings =
        jsonMAp.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) {
    return _localizationStrings[key];
  }
}

class _getLocalizationDelegate extends LocalizationsDelegate<SetLocalization> {
  const _getLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<SetLocalization> load(Locale locale) async {
    // TODO: implement load
    SetLocalization localization = new SetLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<SetLocalization> old) {
    // TODO: implement shouldReload
    return false;
  }
}
