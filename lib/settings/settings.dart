import 'dart:ui';

import 'package:alramzapp2021/Mobile/important/passwordscreen.dart';
import 'package:alramzapp2021/Mobile/screens/loginscreen_mobile.dart';
import 'package:alramzapp2021/language/language.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/menues/menupopup.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/theme/darkmode.dart';
import 'package:alramzapp2021/theme/trueblack.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Language language;
  bool isCheck = false;
  LocalStorage storage = LocalStorage('AlRamz');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'settings'),
          style: TextStyleApplied.Text,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: AppColors.white,
              size: Sizes.s25,
            ),
          ),
          Hero(
            tag: 'heroMenuPopup44432',
            child: PopupMenuButton<String>(
              offset: Offset(0, 100),
              onSelected: choiceAction,
              icon: Icon(
                Icons.menu,
                size: Sizes.s25,
              ),
              itemBuilder: (BuildContext context) {
                return MenuPopUpMobile.choice.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
      body: dropDownButtonSettings(),
    ));
  }

  Widget dropDownButtonSettings() {
    return Container(
        padding:
            EdgeInsets.only(left: Sizes.s20, top: Sizes.s10, bottom: Sizes.s20),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: Sizes.s10),
              child: Container(
                margin: EdgeInsets.only(left: Sizes.s5, right: Sizes.s30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      getTranslated(context, 'language'),
                      style: TextStyleApplied.Text,
                    ),
                    DropdownButton<Language>(
                      underline: SizedBox(),
                      icon: Icon(
                        Icons.language,
                        color: AppColors.white,
                      ),
                      items: Language.langList(context)
                          .map<DropdownMenuItem<Language>>(
                              (lang) => DropdownMenuItem(
                                    value: lang,
                                    child: Row(
                                      children: [
                                        Text(
                                          lang.langname,
                                        ),
                                      ],
                                    ),
                                  ))
                          .toList(),
                      onChanged: (Language lang) {
                        _changeLanguage(lang);
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Sizes.s5,
            ),
            DarkModeSwitch(),
            TrueBlackSwitch(),
            SizedBox(
              height: Sizes.s5,
            ),
            Container(
              margin: EdgeInsets.only(right: Sizes.s30),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.s10,
                ),
                child: Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: CheckboxListTile(
                    title: Text(getTranslated(context, 'enableFingerPrint'),
                        style: TextStyleApplied.Text),
                    value: isCheck,
                    checkColor: Colors.green,
                    activeColor: Colors.white,
                    onChanged: _onRememberMeChanged,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ),
            ),
            Card(
              child: FlatButton(
                onPressed: () {
                  AppRoutes.push(context, LoginScreen());
                },
                child: Text(getTranslated(context, 'save')),
              ),
            )
          ],
        ));
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
        isCheck = newValue;
      });
  void _changeLanguage(Language lang) async {
    Locale _temp = await setLocale(lang.languagecode);
    MyApp.setLocales(context, _temp);
  }

  void choiceAction(Action) async {
    //    print("Mune PopUp");
    if (Action == MenuPopUpMobile.change_password) {
      AppRoutes.push(context, Changepassword());
    } else if (Action == MenuPopUpMobile.settings) {
      AppRoutes.push(context, Settings());
    } else if (Action == MenuPopUpMobile.sign_out) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String webcode = prefs.getString('webcode');
      http.Response response = await http.post(
        '${Config.signout}$webcode',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: null,
      );
      if (response.statusCode == 200) {
        Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
        prefs.clear();
        prefs.commit();
      } else {
        throw Exception('cant sign out by api');
      }
    }
  }
}
