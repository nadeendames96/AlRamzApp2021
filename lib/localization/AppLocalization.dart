import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale locale;
  AppLocalization(this.locale);
  static AppLocalization of(BuildContext context){
    return Localizations.of<AppLocalization>(context,AppLocalization);
  }


  static const LocalizationsDelegate <AppLocalization>delegate=_AppLocalizationDelegate();

  Map<String,String>_localizationStrings;
  Future<bool>load ()async{
    String jsonString=await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String,dynamic>jsonMAp=json.decode(jsonString);

    _localizationStrings=jsonMAp.map((key, value){
      return MapEntry(key,value.toString());

    });

    return true;
  }

  String translate(String key){
    return _localizationStrings[key];
  }
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization>{
  const _AppLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale)async {
    // TODO: implement load
    AppLocalization localization=new AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
    // TODO: implement shouldReload
    return false;
  }
  
}