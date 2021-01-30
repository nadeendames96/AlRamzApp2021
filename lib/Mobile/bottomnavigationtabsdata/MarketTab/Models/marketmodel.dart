import 'dart:async';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/Alearts/aleart.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/markettabinfo/markettabsmobile.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/selectmarkets/selectmarket.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/summaryMarket/summaries.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketModel extends StatefulWidget {
  @override
  _MarketModelState createState() => _MarketModelState();
}

class _MarketModelState extends State<MarketModel> {
  final String image;
  final double size;

  _MarketModelState({this.image, this.size});

  LocalStorage _storage = LocalStorage('AlRamz');
  String market = '', marketNameEn = '', marketNameAr = '';
  int count = 2;
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      market = _storage.getItem('market');
      marketNameEn = _storage.getItem('marketNameEn');
      marketNameAr = _storage.getItem('marketNameAr');
      if (market != null) {
        market = _storage.getItem('market');
      } else {
        market = '';
      }
      if (marketNameEn != null) {
        marketNameEn = _storage.getItem('marketNameEn');
      } else {
        marketNameEn = '';
      }
      if (marketNameAr != null) {
        marketNameAr = _storage.getItem('marketNameAr');
      } else {
        marketNameAr = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(
            getTranslated(context, 'market'),
            style: TextStyleApplied.Text,
          ),
          automaticallyImplyLeading: false,
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
            PopupMenuButton<String>(
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
          ],
        ),
        body: SingleChildScrollView(
          child: Builder(builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Sizes.s50,
                  decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(1.0)),
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return SelectMarket();
                            }));
                      });
                    },
                    child: MarketSummary.isConnectSignalR
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: Sizes.s10, right: Sizes.s10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Text(HomeScreen.marketNameE[0].toString()),
                                Localizations.localeOf(context).languageCode ==
                                        'en'
                                    ? Text(
                                        marketNameEn == ''
                                            ? StaticValues.marketNameE
                                            : marketNameEn,
                                        style: TextStyleApplied.TextNormal)
                                    // HomeScreen.values.toString())
                                    : Text(
                                        marketNameAr == ''
                                            ? StaticValues.marketNameA
                                            : marketNameAr,
                                        style: TextStyleApplied.TextNormal,
                                      ),
                                Icon(
                                  Icons.arrow_circle_down_sharp,
                                  color: AppColors.white,
                                )
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                                left: Sizes.s10, right: Sizes.s10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Text(HomeScreen.marketNameE[0].toString()),
                                Localizations.localeOf(context).languageCode ==
                                        'en'
                                    ? Text(
                                        marketNameEn == ''
                                            ? StaticValues.marketNameE
                                            : marketNameEn,
                                        style: TextStyleApplied.TextNormal)
                                    // HomeScreen.values.toString())
                                    : Text(
                                        marketNameAr == ''
                                            ? StaticValues.marketNameA
                                            : marketNameAr,
                                        style: TextStyleApplied.TextNormal,
                                      ),
                                Icon(
                                  Icons.arrow_circle_down_sharp,
                                  color: AppColors.white,
                                )
                              ],
                            ),
                          ),
                  ),
                ),
                MarketMobileTabs(),
              ],
            );
          }),
        ));
  }

  void choiceAction(Action) async {
    //    print("Mune PopUp");
    if (Action == MenuPopUpMobile.change_password) {
      AppRoutes.push(context, Changepassword());
    } else if (Action == MenuPopUpMobile.settings) {
      AppRoutes.push(context, Settings());
    } else if (Action == MenuPopUpMobile.aleart) {
      AppRoutes.push(context, AlertScreen());
    } else if (Action == MenuPopUpMobile.transfer_account) {
      AppRoutes.push(context, TransferAmount());
    } else if (Action == MenuPopUpMobile.sign_out) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String webcode = prefs.getString('webcode');
      prefs.clear();
      prefs.commit();
      http.Response response = await http.post(
        '${Config.signout}$webcode',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': '${Config.cookieSave}',
        },
        body: null,
      );
      print('signout response');
      print(response.statusCode);
      if (response.statusCode == 200) {
        Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        throw Exception('cant sign out by api');
      }
    }
  }
}
