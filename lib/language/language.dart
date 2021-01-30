import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:flutter/cupertino.dart';

class Language {
  final int id;
  final String langname;
  final String flag;
  final String languagecode;

  Language(this.id, this.langname, this.flag, this.languagecode);

  static List<Language> langList(BuildContext context) {
    return <Language>[
      Language(1, getTranslated(context, 'en'), '🇺🇸', 'en'),
      Language(2, getTranslated(context, 'ar'), '🇯🇴', 'ar'),
    ];
  }
}
