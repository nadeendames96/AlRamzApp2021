import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/spalish_screen/layout.dart';
import 'package:alramzapp2021/theme/thememodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'localization/setlocalization.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  static void setLocales(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  static void setLanguage(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  final ThemeModel _model = ThemeModel();
  LocalStorage storage = LocalStorage('AlRamz');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      _model.init();
    } catch (e) {
      print("Error Loading Theme: $e");
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getLocale().then((local) {
      setState(() {
        this._locale = local;
        print(_locale);
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _locale == null
        ? Container(
            child: CircularProgressIndicator(),
          )
        : MultiProvider(
            providers: [
                ChangeNotifierProvider<ThemeModel>.value(value: _model),
              ],
            child: Consumer<ThemeModel>(
              builder: (context, model, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: model.theme,
                title: 'AlRamz',
                home: Layout(),
                // theme: ThemeData.light().copyWith(primaryColor: AppColors.primary),
                supportedLocales: [Locale('en', 'US'), Locale('ar', 'JO')],
                localizationsDelegates: [
                  SetLocalization.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (local, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == local.languageCode &&
                        supportedLocale.countryCode == local.countryCode) {
                      return local;
                    }
                  }
                  return supportedLocales.first;
                },
                locale: _locale,
              ),
            ));
  }
}
