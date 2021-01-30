import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamz/AlRamz2020/alramz/lib/utils/colors.dart';

enum ThemeType { light, dark, custom, black }

class ThemeModel extends ChangeNotifier {
  final Color color;

  ThemeModel({
    this.color,
    this.customBlackTheme,
    this.customLightTheme,
    this.customDarkTheme,
    this.customCustomTheme,
    String key,
  }) {
    init();
  }

  final ThemeData customLightTheme,
      customDarkTheme,
      customBlackTheme,
      customCustomTheme;

  int _accentColor = Colors.redAccent.value;
  bool _customTheme = false;
  int _darkAccentColor = Colors.greenAccent.value;
  bool _darkMode = false;
  int _primaryColor = AppColors.secondary.value;
  SharedPreferences _prefs;
  bool _trueBlack = false;

  ThemeType get type {
    if (_darkMode ?? false) {
      if (_trueBlack ?? false) return ThemeType.black;
      return ThemeType.dark;
    }
    if (_customTheme ?? false) return ThemeType.custom;
    return ThemeType.light;
  }

  void changeDarkMode(bool value) {
    _darkMode = value;
    _prefs.setBool("dark_mode", _darkMode);
    notifyListeners();
  }

  void changeTrueBlack(bool value) {
    _trueBlack = value;
    _prefs.setBool("true_black", _trueBlack);
    notifyListeners();
  }

  void changeCustomTheme(bool value) {
    _customTheme = value;
    _prefs.setBool("custom_theme", _customTheme);
    notifyListeners();
  }

  void changePrimaryColor(Color value) {
    _primaryColor = value.value;
    _prefs.setInt("primary_color", _primaryColor);
    notifyListeners();
  }

  void changeAccentColor(Color value) {
    _accentColor = value.value;
    _prefs.setInt("accent_color", _accentColor);
    notifyListeners();
  }

  void changeDarkAccentColor(Color value) {
    _darkAccentColor = value.value;
    _prefs.setInt("dark_accent_color", _darkAccentColor);
    notifyListeners();
  }

  ThemeData get theme {
    if (_prefs == null) {
      init();
    }
    switch (type) {
      case ThemeType.light:
        return customLightTheme ??
            ThemeData.dark().copyWith(
              scaffoldBackgroundColor: AppColors.secondary,
              buttonColor: AppColors.primary,
              backgroundColor: AppColors.primary,
              bottomAppBarColor: AppColors.blueblue,
              primaryColorDark: AppColors.primary,
              accentColor: AppColors.primary,
              appBarTheme: AppBarTheme(color: AppColors.maincolor),
              buttonTheme: ButtonThemeData(buttonColor: AppColors.primary),
              cardColor: AppColors.graylight,
              dividerColor: AppColors.white,
            );
      case ThemeType.dark:
        return customDarkTheme ??
            ThemeData.dark().copyWith(
              accentColor: darkAccentColor ?? null,
            );
      case ThemeType.black:
        return customBlackTheme ??
            ThemeData.dark().copyWith(
                scaffoldBackgroundColor: Colors.black,
                backgroundColor: Colors.black,
                bottomAppBarColor: AppColors.light_black,
                primaryColorDark: Colors.black,
                accentColor: darkAccentColor ?? null,
                appBarTheme: AppBarTheme(
                  color: AppColors.black,
                ),
                buttonTheme:
                    ButtonThemeData(buttonColor: AppColors.light_black),
                cardColor: AppColors.light_black,
                dividerColor: AppColors.white);
      case ThemeType.custom:
        return customCustomTheme != null
            ? ThemeData.light().copyWith(primaryColor: AppColors.secondary)
            : ThemeData.light().copyWith(primaryColor: AppColors.secondary);
      default:
        return customLightTheme ??
            ThemeData.light().copyWith(primaryColor: AppColors.secondary);
    }
  }

  void checkPlatformBrightness(BuildContext context) {
    if (!darkMode &&
        MediaQuery.of(context).platformBrightness == Brightness.dark) {
      changeDarkMode(true);
    }
  }

  ThemeData get darkTheme {
    if (_prefs == null) {
      init();
    }

    if (_trueBlack ?? false) {
      return customBlackTheme ??
          ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.black,
            backgroundColor: Colors.black,
            bottomAppBarColor: Colors.black,
            primaryColorDark: Colors.black,
            accentColor: darkAccentColor ?? null,
          );
    }
    return customDarkTheme ??
        ThemeData.dark().copyWith(
          accentColor: darkAccentColor ?? null,
        );
  }

  Color get backgroundColor {
    if (darkMode ?? false) {
      if (trueBlack ?? false) return Colors.black;
      return ThemeData.dark().scaffoldBackgroundColor;
    }
    if (customTheme ?? false) return primaryColor;
    return null;
  }

  Color get textColor {
    if (customTheme ?? false) return Colors.white;
    if (darkMode ?? false) return AppColors.gray;
    return Colors.black;
  }

  Color get textColorInvert {
    if (customTheme ?? false) return Colors.black;
    if (darkMode ?? false) return Colors.black;
    return Colors.white;
  }

  Future init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    if (_prefs != null) {
      _darkMode = _prefs.getBool("dark_mode");
      _trueBlack = _prefs.getBool("true_black");
      _customTheme = _prefs.getBool("custom_theme");
      _primaryColor = _prefs.getInt("primary_color");
      _accentColor = _prefs.getInt("accent_color");
      _darkAccentColor = _prefs.getInt("dark_accent_color");
      notifyListeners();
    } else {
      print("Error Loading Theme...");
    }
  }

  bool get darkMode =>
      _darkMode ?? (type == ThemeType.dark || type == ThemeType.black);

  bool get trueBlack => _trueBlack ?? type == ThemeType.black;

  bool get customTheme => _customTheme ?? type == ThemeType.custom;

  Color get primaryColor {
    if (_primaryColor == null) {
      return type == ThemeType.dark
          ? ThemeData.dark().primaryColor
          : ThemeData.light().primaryColor;
    }
    return Color(_primaryColor);
  }

  Color get accentColor {
    if (type == ThemeType.dark || type == ThemeType.black) {
      if (_darkAccentColor == null) {
        return ThemeData.dark().accentColor;
      }
      return Color(_darkAccentColor);
    }

    if (_accentColor == null) {
      return ThemeData.light().accentColor;
    }

    if (_customTheme) {
      return Color(_accentColor);
    }

    return Colors.redAccent;
  }

  Color get darkAccentColor {
    if (_darkAccentColor == null) return ThemeData.dark().accentColor;
    return Color(_darkAccentColor);
  }

  void reset() {
    _prefs.clear();
    _darkMode = false;
    _trueBlack = false;
    _customTheme = false;
    _primaryColor = AppColors.secondary.value;
    _accentColor = Colors.redAccent.value;
    _darkAccentColor = Colors.greenAccent.value;
  }
}
