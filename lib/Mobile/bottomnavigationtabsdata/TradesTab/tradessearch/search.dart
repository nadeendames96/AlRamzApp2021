import 'dart:convert';
import 'dart:ui';

import 'package:alramzapp2021/Mobile/important/passwordscreen.dart';
import 'package:alramzapp2021/Mobile/screens/loginscreen_mobile.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/menues/menupopup.dart';
import 'package:alramzapp2021/services/WatchServices/watchallmarkets_object.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/settings/settings.dart';
import 'package:alramzapp2021/utils/assets.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchTrade extends StatefulWidget {
  static String symbol = '';
  @override
  _SearchTradeState createState() => _SearchTradeState();
}

class _SearchTradeState extends State<SearchTrade> {
  static int current = 1;
  String _radioValue =
      current.toString(); //Initial definition of radio button value
  String choiceValue;
  static AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<WatchALLMarketsObjects>> key =
      new GlobalKey();
  static List<WatchALLMarketsObjects> list = new List<WatchALLMarketsObjects>();
  bool loading = true;
  static bool isSubmited = false;
  bool isEmpty = true;
  String profileID = '';
  LocalStorage storage = LocalStorage('AlRamz');

  void getSymbols() async {
    try {
      SharedPreferences prfs = await SharedPreferences.getInstance();
      String webcode = prfs.getString('webcode');
      final response = await http
          .get('${Config.GetALLMarketWatch}$webcode')
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        list = loadSymbols(response.body);
        print('Symbols: ${list.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  static List<WatchALLMarketsObjects> loadSymbols(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed
        .map<WatchALLMarketsObjects>(
            (json) => WatchALLMarketsObjects.fromJson(json))
        .toList();
  }

  static List choose = [];

  @override
  void initState() {
    this.getSymbols();
    super.initState();
  }

  Widget row(WatchALLMarketsObjects watchALLMarketsObjects) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(watchALLMarketsObjects.symbol, style: TextStyleApplied.Text),
          Text(
            watchALLMarketsObjects.symbolNameEnglish,
            style: TextStyleApplied.Text,
          ),
          Text(
            watchALLMarketsObjects.symbolNameArabic,
            style: TextStyleApplied.Text,
          ),
        ],
      ),
    );
  }

  bool sellbuyFlag = true;
  void onSellBuyFlag(bool newvalue) {
    setState(() {
      sellbuyFlag = newvalue;
      if (sellbuyFlag) {
        choose.add(1);
      } else {
        choose.add(0);
      }
    });
  }

  final String image;
  final double size;

  _SearchTradeState({this.image, this.size});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                getTranslated(context, 'searchtrades'),
                style: TextStyleApplied.TextNormal,
              ),
              actions: [
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
                  tag: 'jsnsjkjkfwedk',
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
            body: new Container(
                width: double.maxFinite,
                height: double.maxFinite,
                padding: EdgeInsets.only(
                    left: Sizes.s5, right: Sizes.s5, top: Sizes.s5),
                child: ListView(shrinkWrap: true, children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated(context, 'operation'),
                            style: TextStyleApplied.Text,
                          ),
                          Column(children: [
                            Row(
                              children: [
                                Container(
                                  height: Sizes.s30,
                                  child: Checkbox(
                                    value: sellbuyFlag,
                                    activeColor: AppColors.white,
                                    checkColor: AppColors.black,
                                    onChanged: onSellBuyFlag,
                                  ),
                                ),
                                Text(getTranslated(context, 'buy'),
                                    style: TextStyleApplied.Text)
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: Sizes.s30,
                                  child: Checkbox(
                                    value: sellbuyFlag,
                                    activeColor: AppColors.white,
                                    checkColor: AppColors.black,
                                    onChanged: onSellBuyFlag,
                                  ),
                                ),
                                Text(
                                  getTranslated(context, 'sell'),
                                  style: TextStyleApplied.Text,
                                ),
                              ],
                            ),
                          ]),
                          SizedBox()
                        ],
                      ),
                      SizedBox(
                        height: Sizes.s10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated(context, 'orderid'),
                            style: TextStyleApplied.Text,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: Sizes.s5),
                            color: AppColors.white,
                            width: Sizes.s200 + 25,
                            height: Sizes.s40,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: getTranslated(
                                      context, 'leaveemptyforallorders'),
                                  hintStyle: TextStyleApplied.TextBlack),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Sizes.s5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            getTranslated(context, 'symbol'),
                            style: TextStyleApplied.Text,
                          ),
                          Container(
                              padding: EdgeInsets.only(left: Sizes.s5),
                              width: Sizes.s200 + 25,
                              height: Sizes.s40,
                              color: AppColors.white,
                              // ignore: missing_required_param
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    loading
                                        ? CircularProgressIndicator()
                                        : searchTextField =
                                            AutoCompleteTextField<
                                                WatchALLMarketsObjects>(
                                            key: key,
                                            clearOnSubmit: false,
                                            suggestions: list,
                                            style: TextStyleApplied.TextBlack,
                                            decoration: InputDecoration(
                                              hintText: getTranslated(context,
                                                  'leaveemptyforallsymbols'),
                                              hintStyle:
                                                  TextStyleApplied.TextBlack,
                                            ),
                                            itemFilter: (item, query) {
                                              return item.symbol
                                                  .toUpperCase()
                                                  .startsWith(
                                                      query.toUpperCase());
                                            },
                                            itemSorter: (a, b) {
                                              return a.symbol
                                                  .compareTo(b.symbol);
                                            },
                                            itemSubmitted: (item) {
                                              setState(() {
                                                isSubmited = true;
                                                SearchTrade.symbol =
                                                    item.symbol;
                                                // OrderTab.symbol = item.symbol;
                                                searchTextField
                                                    .textField
                                                    .controller
                                                    .text = item.symbol;
                                              });
                                            },
                                            itemBuilder: (context, item) {
                                              // ui for the autocompelete row
                                              return row(item);
                                            },
                                          ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: Sizes.s5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated(context, 'price'),
                            style: TextStyleApplied.Text,
                          ),
                          Container(
                            color: AppColors.white,
                            width: Sizes.s200 + 25,
                            height: Sizes.s40,
                            child: TextField(
                              style: TextStyleApplied.TextBlack,
                              decoration: InputDecoration(
                                  hintText: getTranslated(
                                      context,
                                      getTranslated(
                                          context, 'leaveemptyformarketprice')),
                                  hintStyle: TextStyleApplied.TextBlack),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Sizes.s5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: Sizes.s5,
                          ),
                          Container(
                            width: Sizes.s100,
                            height: Sizes.s50,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.white, width: 2),
                            ),
                            child: FlatButton(
                              child: Text(
                                getTranslated(context, 'reset'),
                                style: TextStyleApplied.Text,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Sizes.s120,
                                height: Sizes.s50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.white, width: 2),
                                ),
                                child: FlatButton(
                                  child: Text(
                                    getTranslated(context, 'getorders'),
                                    style: TextStyleApplied.Text,
                                  ),
                                  onPressed: Reset,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ]))));
  }

  Reset() {
    searchTextField.controller.clear();
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
