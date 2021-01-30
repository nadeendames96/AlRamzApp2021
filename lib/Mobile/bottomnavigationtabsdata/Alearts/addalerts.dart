import 'dart:convert';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/Alearts/show_date.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformate.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformatetextcolor.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/watchtabs/tabs.dart';
import 'package:alramzapp2021/Mobile/important/passwordscreen.dart';
import 'package:alramzapp2021/Mobile/methods/getexchangesummary.dart';
import 'package:alramzapp2021/Mobile/screens/loginscreen_mobile.dart';
import 'package:alramzapp2021/Mobile/transfetaccount/transferaccount.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addaleart.dart';
import 'aleart.dart';
import 'convertCateria.dart';
import 'convertParameter.dart';

class AddAleart extends StatefulWidget {
  @override
  _AddAleartState createState() => _AddAleartState();
}

class _AddAleartState extends State<AddAleart> {
  final String image;
  final double size;
  List parameters = [
    'Select',
    'Last Price',
    'High Price',
    'Low Price',
    'Bid Price',
    'Offer Price',
    'Net Change',
    'Net Change %',
    'Average Price',
    'Total Value',
    'Total Volume'
  ];

  List criteria = [
    'Select',
    'Equals',
    'Not Equals',
    'Greater than',
    'Greater than or equals',
    'Less than',
    'Less than or equals'
  ];
  bool isSms = false;
  String parameterIsSms = 'N';
  String condition = '', conditionValue = '', conditionName = '';
  void isRememberSms(bool isSms) {
    this.isSms = isSms;

    if (this.isSms) {
      this.parameterIsSms = 'Y';
    } else {
      this.parameterIsSms = 'N';
    }
  }

  void getSymbols() async {
    try {
      SharedPreferences prfs = await SharedPreferences.getInstance();
      String webcode = prfs.getString('webcode');
      final response = await http
          .get(
            '${Config.GetALLMarketWatch}$webcode',
          )
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

  _AddAleartState({this.image, this.size});
  static AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<WatchALLMarketsObjects>> key =
      new GlobalKey();
  static List<WatchALLMarketsObjects> list = new List<WatchALLMarketsObjects>();
  bool loading = true;
  static bool isSubmited = false;
  String _mySelection;
  List data = List();
  TextEditingController valueText = TextEditingController();
  Widget row(WatchALLMarketsObjects watchALLMarketsObjects) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            watchALLMarketsObjects.symbol,
            style: TextStyleApplied.Text,
          ),
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

  static DateTime today = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    this.getSymbols();
    super.initState();
  }

  TextEditingController symbolAleart = TextEditingController();

  String selectMarket, selectParameter, selectCateria;
  @override
  Widget build(BuildContext context) {
    return _addAleart();
  }

  _addAleart() {
    return Scaffold(
      appBar: AppBar(
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
        title: Text(getTranslated(context, 'newalert')),
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes.s10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslated(context, 'exchange'),
                style: TextStyleApplied.Text,
              ),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: Sizes.s5),
                        width: Sizes.s200,
                        height: Sizes.s40,
                        color: AppColors.white,
                        child: new DropdownButton<String>(
                          underline: SizedBox(),
                          isExpanded: true,
                          hint: Text(
                            getTranslated(context, 'select'),
                            style: TextStyleApplied.TextBlack,
                          ),
                          value: selectMarket,
                          onChanged: (newVal) {
                            selectMarket = newVal;
                          },
                          items: Localizations.localeOf(context).languageCode ==
                                  'en'
                              ? marketsNameE.map((market) {
                                  return DropdownMenuItem<String>(
                                    child: Text(market),
                                    value: market,
                                  );
                                }).toList()
                              : marketsNameA.map((market) {
                                  return DropdownMenuItem<String>(
                                    child: Text(market),
                                    value: market,
                                  );
                                }).toList(),
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
          SizedBox(
            height: Sizes.s3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslated(context, 'symbol'),
                style: TextStyleApplied.Text,
              ),
              Container(
                  padding: EdgeInsets.only(left: Sizes.s5),
                  width: Sizes.s200 + 26,
                  height: Sizes.s40,
                  color: AppColors.white,
                  // ignore: missing_required_param
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        loading
                            ? CircularProgressIndicator()
                            : searchTextField =
                                AutoCompleteTextField<WatchALLMarketsObjects>(
                                key: key,
                                controller: symbolAleart,
                                clearOnSubmit: false,
                                suggestions: list,
                                style: TextStyleApplied.TextBlack,
                                decoration: InputDecoration(
                                  hintText: getTranslated(context, 'symbol'),
                                  hintStyle: TextStyleApplied.TextBlack,
                                ),
                                itemFilter: (item, query) {
                                  return item.symbol
                                      .toUpperCase()
                                      .startsWith(query.toUpperCase());
                                },
                                itemSorter: (a, b) {
                                  return a.symbol.compareTo(b.symbol);
                                },
                                itemSubmitted: (item) {
                                  setState(() {
                                    WatchTabs.symbol = item.symbol;
                                    isSubmited = true;
                                    symbolAleart.text = item.symbol;
                                    // searchSymbols.symbol = item.symbol;
                                    searchTextField.textField.controller.text =
                                        item.symbol;
                                    WatchTabs.lasttrade = item.lastTradePrice;
                                    WatchTabs.netchange =
                                        double.parse(item.netChange);
                                    WatchTabs.netchangeprec =
                                        item.netChangePerc;
                                    WatchTabs.bidprice = item.bidPrice;
                                    WatchTabs.bidvol = item.bidVolume;
                                    WatchTabs.offerprice = item.offerPrice;
                                    WatchTabs.offervol = item.offerVolume;
                                    WatchTabs.limitup = item.maxPrice;
                                    WatchTabs.limitdn = item.minPrice;
                                    WatchTabs.buypower = item.buyCashFlowPerc;
                                    WatchTabs.cash = item.buyCashFlowPerc;
                                    isSubmited = true;
                                    searchTextField.textField.controller.text =
                                        item.symbol.toString();
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
            height: Sizes.s3,
          ),
          isSubmited
              ? Container(
                  padding: EdgeInsets.all(Sizes.s5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.light_blue),
                  ),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: Sizes.s5),
                            child: Text(
                              WatchTabs.symbol,
                              style: TextStyleApplied.Text,
                            )),
                        Container(
                            margin: EdgeInsets.only(right: Sizes.s5),
                            child: SpacficTextColor(
                              WatchTabs.lasttrade,
                              WatchTabs.netchange.toString(),
                              WatchTabs.netchangeprec,
                            ))
                      ],
                    ),
                    Divider(
                      color: AppColors.black.withOpacity(.3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: Sizes.s5),
                            child: Text(getTranslated(context, 'bidvol'))),
                        Row(
                          children: [
                            SpacificFormate(
                              WatchTabs.bidvol,
                              valueText: TextStyleApplied.TextSmallGreen,
                            ),
                            SizedBox(
                              width: Sizes.s3,
                            ),
                            Text(getTranslated(context, 'offervol')),
                          ],
                        ),
                        SpacificFormate(
                          WatchTabs.offervol,
                          valueText: TextStyleApplied.TextSmallRed,
                        )
                      ],
                    ),
                    Divider(
                      color: AppColors.black.withOpacity(.3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: Sizes.s5),
                            child: Text(getTranslated(context, 'bidprice'))),
                        Row(
                          children: [
                            SpacificFormate(
                              WatchTabs.bidprice,
                              valueText: TextStyleApplied.TextSmallGreen,
                            ),
                            SizedBox(
                              width: Sizes.s3,
                            ),
                            Text(getTranslated(context, 'offerprice')),
                          ],
                        ),
                        SpacificFormate(
                          WatchTabs.offerprice,
                          valueText: TextStyleApplied.TextSmallRed,
                        )
                      ],
                    ),
                  ]))
              : Container(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              getTranslated(context, 'parameter'),
              style: TextStyleApplied.Text,
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: Sizes.s5),
                      width: Sizes.s200,
                      height: Sizes.s40,
                      color: AppColors.white,
                      child: new DropdownButton<String>(
                          underline: SizedBox(),
                          isExpanded: true,
                          hint: Text(
                            getTranslated(context, 'select'),
                            style: TextStyleApplied.TextBlack,
                          ),
                          value: selectParameter,
                          onChanged: (newVal) {
                            selectParameter = newVal;
                            CovertParameter(selectParameter);
                          },
                          items: parameters.map((item) {
                            return DropdownMenuItem<String>(
                              child: Text(
                                item,
                                style: TextStyleApplied.Text,
                              ),
                              value: item,
                            );
                          }).toList()),
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
          ]),
          SizedBox(
            height: Sizes.s3,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              getTranslated(context, 'criteria'),
              style: TextStyleApplied.Text,
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: Sizes.s5),
                      width: Sizes.s200,
                      height: Sizes.s40,
                      color: AppColors.white,
                      child: new DropdownButton<String>(
                          underline: SizedBox(),
                          isExpanded: true,
                          hint: Text(
                            getTranslated(context, 'select'),
                            style: TextStyleApplied.TextBlack,
                          ),
                          value: selectCateria,
                          onChanged: (newVal) {
                            selectCateria = newVal;
                            ConvertCateriaToSymbol(selectCateria);
                          },
                          items: parameters.map((item) {
                            return DropdownMenuItem<String>(
                              child: Text(
                                item,
                                style: TextStyleApplied.Text,
                              ),
                              value: item,
                            );
                          }).toList()),
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
          ]),
          SizedBox(
            height: Sizes.s3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslated(context, 'value'),
                style: TextStyleApplied.Text,
              ),
              Container(
                color: AppColors.white,
                width: Sizes.s200 + 26,
                height: Sizes.s40,
                child: TextField(
                  controller: valueText,
                  style: TextStyleApplied.TextBlack,
                  decoration:
                      InputDecoration(hintStyle: TextStyleApplied.TextBlack),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Sizes.s3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslated(context, 'validtill'),
                style: TextStyleApplied.Text,
              ),
              Container(
                color: AppColors.white,
                width: Sizes.s200 + 26,
                height: Sizes.s40,
                child: GestureDetector(
                  child: Text(
                    "${today.toLocal()}".split(' ')[0],
                    style: TextStyleApplied.TextBlack,
                  ),
                  onTap: () {
                    ShowDate();
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Checkbox(
                value: isSms,
                checkColor: Colors.green,
                activeColor: Colors.white,
                onChanged: isRememberSms,
              ),
              Text(
                getTranslated(context, 'notifymebysms'),
                style: TextStyleApplied.Text,

//                          style: kLabelStyle,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.white),
                ),
                child: FlatButton(
                  onPressed: () {
                    addAleart(selectMarket, WatchTabs.symbol, selectCateria,
                        valueText.text, selectParameter, today, parameterIsSms);
                  },
                  child: Text(
                    getTranslated(context, 'create'),
                    style: TextStyleApplied.Text,
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
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
        },
        body: null,
      );
      if (response.statusCode == 200) {
        Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        throw Exception('cant sign out by api');
      }
    }
  }
}
