import 'dart:ui';

import 'package:alramzapp2021/language/language.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/menues/menupopup.dart';
import 'package:alramzapp2021/theme/darkmode.dart';
import 'package:alramzapp2021/theme/trueblack.dart';
import 'package:alramzapp2021/utils/assets.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ns_utils/utils/sizes.dart';

import '../main.dart';

class SettingsTablet extends StatefulWidget {
  @override
  _SettingsTabletState createState() => _SettingsTabletState();
}

class _SettingsTabletState extends State<SettingsTablet> {
  Language language;
  bool isCheck = false;
  LocalStorage storage = LocalStorage('AlRamz');

  final String image;
  final double size;

  _SettingsTabletState({this.image, this.size});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'settings'),
          style: TextStyleApplied.TextNormal,
        ),
        actions: <Widget>[
          Image(
            image: AssetImage(image ?? Assets.ramzicon),
            height: size ?? Sizes.s20,
            width: size ?? Sizes.s20,
            fit: BoxFit.contain,
          ),
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
              // onSelected: choiceAction,
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
//        key: _scaffoldKey,
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
                    Stack(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 310,
                              height: Sizes.s40,
                              color: AppColors.white,
                              child: DropdownButton<Language>(
                                dropdownColor: AppColors.white,
                                isExpanded: true,
                                underline: SizedBox(),
                                // value: language,
                                items: Language.langList(context)
                                    .map<DropdownMenuItem<Language>>(
                                        (lang) => DropdownMenuItem(
                                              value: lang,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    lang.langname,
                                                    style: TextStyleApplied
                                                        .TextBlack,
                                                  ),
                                                ],
                                              ),
                                            ))
                                    .toList(),
                                onChanged: (Language lang) {
                                  language = lang;
                                  _changeLanguage(lang);
                                },
                              ),
                            ),
                            Container(
                              height: Sizes.s40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.white)),
                              child: Icon(
                                Icons.arrow_drop_down,
                              ),
                            )
                          ],
                        )
                      ],
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
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.s10,
                ),
                child: Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: CheckboxListTile(
                    title: Text(
                      getTranslated(context, 'enableFingerPrint'),
                      style: TextStyleApplied.Text,
                    ),
                    value: isCheck,
                    checkColor: Colors.green,
                    activeColor: Colors.white,
                    onChanged: _onRememberMeChanged,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
        isCheck = newValue;

        if (isCheck) {
          // HomeScreen.currect_index = 0;
          // LoginScreen.isEnableFingerPrint = true;
          // AppRoutes.push(context, LoginScreen());
        } else {
          // LoginScreen.isEnableFingerPrint = true;
        }
      });
  void _changeLanguage(Language lang) {
    Locale _temp;
    switch (lang.languagecode) {
      case 'en':
        _temp = Locale(lang.languagecode, 'US');
        storage.setItem('lang', _temp);

        break;
      case 'ar':
        _temp = Locale(lang.languagecode, 'JO');
        storage.setItem('lang', _temp);

        break;
      default:
        _temp = Locale('en', 'US');
        storage.setItem('lang', _temp);
        break;
    }
    MyApp.setLocales(context, _temp);
  }

  // void choiceAction(Action) async {
  //   //    print("Mune PopUp");
  //   if (Action == MenuPopUp.change_password) {
  //     AppRoutes.push(context, Changepassword());
  //   } else if (Action == MenuPopUp.settings) {
  //     AppRoutes.push(context, SettingsTablet());
  //   } else if (Action == MenuPopUp.sign_out) {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String webcode = prefs.getString('webcode');
  //     http.Response response = await http.post(
  //       '${Config.signout}$webcode',
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: null,
  //     );
  //     if (response.statusCode == 200) {
  //       Navigator.of(context, rootNavigator: true).pushReplacement(
  //           MaterialPageRoute(builder: (context) => LoginScreen()));
  //       prefs.clear();
  //       prefs.commit();
  //     } else {
  //       throw Exception('cant sign out by api');
  //     }
  //   }
  // }
}
