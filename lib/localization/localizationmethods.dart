import 'package:alramzapp2021/localization/setlocalization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getTranslated(BuildContext context, String key) {
  return SetLocalization.of(context).translate(key);
}

// language code
const String English = 'en';
const String Arabic = 'ar';
const String Language_Code = 'languageCode';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(Language_Code, languageCode);
  return _locale(languageCode);
}

Locale _locale(String languagecode) {
  Locale _temp;
  switch (languagecode) {
    case English:
      _temp = Locale(languagecode, 'US');
      print(_temp);
      print(_temp);
      break;
    case Arabic:
      _temp = Locale(languagecode, 'JO');
      break;
    default:
      _temp = Locale(English, 'US');
      break;
  }
  return _temp;
}

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(Language_Code) ?? English;
  return _locale(languageCode);
}
