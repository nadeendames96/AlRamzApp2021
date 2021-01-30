import 'dart:async';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/Alearts/aleart.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/profile/profiles.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/symbols/searchsymbol/searchsymbol.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/symbols/symbollist/symbollist.dart';
import 'package:alramzapp2021/Mobile/important/passwordscreen.dart';
import 'package:alramzapp2021/Mobile/screens/loginscreen_mobile.dart';
import 'package:alramzapp2021/Mobile/transfetaccount/transferaccount.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/menues/menupopup.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/settings/settings.dart';
import 'package:alramzapp2021/statics_value/staticvalues.dart';
import 'package:alramzapp2021/utils/assets.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchModel extends StatefulWidget {
  @override
  _WatchModelState createState() => _WatchModelState();
}

class _WatchModelState extends State<WatchModel> {
  String profileName = '';
  LocalStorage storage = LocalStorage('AlRamz');
  Timer timer;
  int count = 10;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      profileName = storage.getItem('profileName');
      if (profileName != null) {
        profileName = storage.getItem('profileName');
      } else {
        profileName = '';
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  final String image;
  final double size;

  _WatchModelState({this.image, this.size});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          getTranslated(context, 'marketwatch'),
          style: TextStyleApplied.Text,
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
            tag: 'mekfjeifue',
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
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              color: AppColors.white,
              size: Sizes.s25,
            ),
            onPressed: () {
              setState(() {
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) {
                      return SearchSymbols();
                    }));
              });
            },
          ),
        ],
      ),
      // key: _scaffoldKey,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              child: SizedBox(
                width: double.infinity,
                child: Hero(
                  tag: "move2332",
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        AppRoutes.push(context, Profiles());
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(getTranslated(context, 'profile'),
                                style: TextStyleApplied.Text),
                            Text(
                                profileName == ''
                                    ? StaticValues.profileName
                                    : profileName,
                                style: TextStyleApplied.TextNormal),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "|",
                              style: TextStyleApplied.Text,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_downward,
                                color: AppColors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SymbolList(),
        ],
        //
      ),
    );
  }

  void choiceAction(Action) async {
    //    print("Mune PopUp");
    if (Action == MenuPopUpMobile.aleart) {
      AppRoutes.push(context, AlertScreen());
    }
    if (Action == MenuPopUpMobile.transfer_account) {
      AppRoutes.push(context, TransferAmount());
    }
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

  // getFtchDate() {
  //   count = 10;
  //   if (timer != null) {
  //     timer.cancel();
  //   }
  //   timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
  //     setState(() {
  //       if (count > 0) {
  //         getExchangeWatchProfiles();
  //         count--;
  //       } else {
  //         timer.cancel();
  //       }
  //     });
  //   });
  // }
}
