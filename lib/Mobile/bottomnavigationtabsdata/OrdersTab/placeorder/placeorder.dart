import 'dart:convert';
import 'dart:ui';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformate.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformatetextcolor.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/OrdersTab/assests/viewwidget.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/OrdersTab/assests/viewwigdet2.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/overview/bootomsectionfirstswection.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/watchtabs/tabs.dart';
import 'package:alramzapp2021/Mobile/important/passwordscreen.dart';
import 'package:alramzapp2021/Mobile/screens/loginscreen_mobile.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/menues/menupopup.dart';
import 'package:alramzapp2021/services/OrdersService/getorderlist_object.dart';
import 'package:alramzapp2021/services/OrdersService/reskmangment.dart';
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
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:ns_utils/src.dart';
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceOrder extends StatefulWidget {
  static String select = 'Select';
  static bool isBuy = BootomSection.isBuy;
  static bool allBalance = false;
  static bool allPosition = false;
  static TextEditingController symbol = TextEditingController(text: 'Symbol');
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  static AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<WatchALLMarketsObjects>> key =
      new GlobalKey();
  static List<WatchALLMarketsObjects> list = new List<WatchALLMarketsObjects>();
  bool loading = true;
  static bool isSubmited = false;
  String buyPower = '', cash = '', share = '', sellorder = '', buyorder = '';
  Future<String> getAccountsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    var response = await http.get('${Config.GetAccountUsers}$webcode',
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        data = jsonData;
      });
    } else {
      throw Exception('cant fetch data');
    }

    return "Sucess";
  }

  Future<String> getLookupsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    var response = await http.get('${Config.GetLookups}$webcode', headers: {
      "Accept": "application/json",
      'Cookie': '${Config.cookieSave}'
    });
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        data2 = jsonData;
        data2.map((e) => Entries(e)).toList();
        // print(jsonData);
      });
    } else {
      throw Exception('cant fetch data');
    }

    return 'OK';
  }

  void getSymbols() async {
    try {
      SharedPreferences prfs = await SharedPreferences.getInstance();
      String webcode = prfs.getString('webcode');
      final response = await http.get('${Config.GetALLMarketWatch}$webcode',
          headers: {
            'Cookie': '${Config.cookieSave}'
          }).timeout(const Duration(seconds: 15));
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

  bool isEmpty = true;
  String profileID = '';
  LocalStorage storage = LocalStorage('AlRamz');
  static String MarketType = '';
  @override
  void initState() {
    this.getSymbols();
    this.getAccountsData();
    this.getLookupsData();
    isSubmited = false;
    super.initState();

    profileID = storage.getItem('profileID');
    if (profileID != null) {
      profileID = storage.getItem('profileID');
    } else {
      profileID = '';
    }
  }

  List data = List(); //edited line
  String _mySelection = 'Select';
  DateTime selectedDate = DateTime.now();
  List data2 = List(); //edited line
  String _mySelection2 = 'Day';
  List Validaty = List();
  String accountID = '';
  String mainClientID = '';
  String clientID = '';
  String nin = '';
  static String symbolSelect = '';
  static String sellbuyflag = 'B';
  static String validity_code = '';
  TextEditingController price = TextEditingController();
  static String accountName = '';
  TextEditingController quantity = TextEditingController();
  String orderValue = '0.0';
  String _radioValue = BootomSection.currentValue
      .toString(); //Initial definition of radio button value
  int choiceValue;
  final String image;
  final double size;
  _PlaceOrderState({this.image, this.size});

  Widget row(WatchALLMarketsObjects watchALLMarketsObjects) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            watchALLMarketsObjects.symbol,
            style: TextStyle(fontSize: FontSizes.s14),
          ),
          Text(
            watchALLMarketsObjects.symbolNameEnglish,
            style: TextStyle(fontSize: FontSizes.s14),
          ),
          Text(
            watchALLMarketsObjects.symbolNameArabic,
            style: TextStyle(fontSize: FontSizes.s14),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text(
                getTranslated(context, 'placeorder'),
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
                  tag: 'jkcdcdnjcdnjc',
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
                          child: Text(
                            choice,
                            style: TextStyleApplied.Text,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ],
            ),
            body: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(left: Sizes.s5, right: Sizes.s5),
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      SizedBox(
                        height: Sizes.s10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated(context, 'account'),
                            style: TextStyleApplied.Text,
                          ),
                          Stack(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: Sizes.s5),
                                    width: Sizes.s200,
                                    height: Sizes.s40,
                                    color: AppColors.white,
                                    child: new DropdownButton(
                                      underline: SizedBox(),
                                      isExpanded: true,
                                      hint: Text(
                                        PlaceOrder.select,
                                        style: TextStyleApplied.TextBlack,
                                      ),
                                      dropdownColor: AppColors.white,
                                      style: TextStyleApplied.TextBlack,
                                      items: data.map((item) {
                                        return new DropdownMenuItem(
                                          child: new Text(item['ClientNameE']),
                                          value: item['ClientNameE'].toString(),
                                          onTap: () {
                                            setState(() {
                                              this.accountID =
                                                  item['AccountID'];
                                              this.clientID = item['ClientID'];
                                              this.mainClientID =
                                                  item['MainClientID'];
                                              this.nin = item['NIN'];
                                            });
                                            setState(() {
                                              reskManagment();
                                            });
                                          },
                                        );
                                      }).toList(),
                                      onChanged: (newVal) {
                                        setState(() {
                                          _mySelection = newVal;
                                          accountName = newVal;
                                        });
                                      },
                                      value: _mySelection,
                                    ),
                                  ),
                                  Container(
                                    height: Sizes.s40,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: AppColors.white)),
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
                                              hintText: getTranslated(
                                                  context, 'symbol'),
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
                                                reskManagment();
                                                MarketType = item.marketType;
                                                WatchTabs.symbol = item.symbol;
                                                isSubmited = true;
                                                // searchSymbols.symbol = item.symbol;
                                                symbolSelect = item.symbol;
                                                searchTextField
                                                    .textField
                                                    .controller
                                                    .text = item.symbol;
                                                WatchTabs.lasttrade =
                                                    item.lastTradePrice;
                                                WatchTabs.netchange =
                                                    double.parse(
                                                        item.netChange);
                                                WatchTabs.netchangeprec =
                                                    item.netChangePerc;
                                                WatchTabs.bidprice =
                                                    item.bidPrice;
                                                WatchTabs.bidvol =
                                                    item.bidVolume;
                                                WatchTabs.offerprice =
                                                    item.offerPrice;
                                                WatchTabs.offervol =
                                                    item.offerVolume;
                                                WatchTabs.limitup =
                                                    item.maxPrice;
                                                WatchTabs.limitdn =
                                                    item.minPrice;
                                                WatchTabs.buypower =
                                                    item.buyCashFlowPerc;
                                                WatchTabs.cash =
                                                    item.buyCashFlowPerc;
                                                isSubmited = true;
                                                searchTextField.textField
                                                        .controller.text =
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
                        height: Sizes.s5,
                      ),
                      isSubmited
                          ? Container(
                              padding: EdgeInsets.all(Sizes.s5),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.light_blue),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          margin:
                                              EdgeInsets.only(left: Sizes.s5),
                                          child: Text(
                                            WatchTabs.symbol,
                                            style: TextStyleApplied.Text,
                                          )),
                                      Container(
                                          margin:
                                              EdgeInsets.only(right: Sizes.s5),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          margin:
                                              EdgeInsets.only(left: Sizes.s5),
                                          child: Text(getTranslated(
                                              context, 'bidvol'))),
                                      Row(
                                        children: [
                                          SpacificFormate(
                                            WatchTabs.bidvol,
                                            valueText:
                                                TextStyleApplied.TextSmallGreen,
                                          ),
                                          SizedBox(
                                            width: Sizes.s3,
                                          ),
                                          Text(getTranslated(
                                              context, 'offervol')),
                                        ],
                                      ),
                                      SpacificFormate(
                                        WatchTabs.offervol,
                                        valueText:
                                            TextStyleApplied.TextSmallRed,
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: AppColors.black.withOpacity(.3),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          margin:
                                              EdgeInsets.only(left: Sizes.s5),
                                          child: Text(getTranslated(
                                              context, 'bidprice'))),
                                      Row(
                                        children: [
                                          SpacificFormate(
                                            WatchTabs.bidprice,
                                            valueText:
                                                TextStyleApplied.TextSmallGreen,
                                          ),
                                          SizedBox(
                                            width: Sizes.s3,
                                          ),
                                          Text(getTranslated(
                                              context, 'offerprice')),
                                        ],
                                      ),
                                      SpacificFormate(
                                        WatchTabs.offerprice,
                                        valueText:
                                            TextStyleApplied.TextSmallRed,
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: AppColors.black.withOpacity(.3),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          margin:
                                              EdgeInsets.only(left: Sizes.s5),
                                          child: Text(getTranslated(
                                              context, 'LimitUp'))),
                                      Row(
                                        children: [
                                          Text(
                                            WatchTabs.limitup,
                                          ),
                                          SizedBox(
                                            width: Sizes.s3,
                                          ),
                                          Text(getTranslated(
                                              context, 'LimitDown')),
                                        ],
                                      ),
                                      Text(
                                        WatchTabs.limitdn,
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: AppColors.black.withOpacity(.3),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          margin:
                                              EdgeInsets.only(left: Sizes.s5),
                                          child: Text(getTranslated(
                                              context, 'buypower'))),
                                      Row(
                                        children: [
                                          SpacificFormate(buyPower),
                                          SizedBox(
                                            width: Sizes.s5,
                                          ),
                                          Text(getTranslated(
                                              context, 'ownedshr')),
                                        ],
                                      ),
                                      SpacificFormate(share),
                                    ],
                                  ),
                                  Divider(
                                    color: AppColors.black.withOpacity(.3),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          margin:
                                              EdgeInsets.only(left: Sizes.s5),
                                          child: Text(
                                              getTranslated(context, 'cash'))),
                                      Row(
                                        children: [
                                          SpacificFormate(cash),
                                          SizedBox(
                                            width: Sizes.s5,
                                          ),
                                          Text(getTranslated(
                                              context, 'sellorder')),
                                        ],
                                      ),
                                      SpacificFormate(sellorder)
                                    ],
                                  ),
                                  Divider(
                                    color: AppColors.black.withOpacity(.3),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(getTranslated(context, 'buyorder')),
                                      SizedBox(
                                        width: Sizes.s5,
                                      ),
                                      SpacificFormate(buyorder)
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: Sizes.s3,
                      ),
                      ViewWidget(),
                      Row(
                        children: [
                          Text(
                            getTranslated(context, 'ordertype'),
                            style: TextStyleApplied.Text,
                          ),
                          SizedBox(
                            width: Sizes.s100,
                          ),
                          Row(
                            children: [
                              Row(
                                children: <Widget>[
                                  Radio(
                                    activeColor: AppColors.white,
                                    value: '1',
                                    groupValue: _radioValue,
                                    onChanged: (value) {
                                      sellbuyflag = 'B';
                                      PlaceOrder.isBuy = true;
                                      radioButtonChanges(value);
                                    },
                                  ),
                                  Text(
                                    getTranslated(context, 'buy'),
                                    style: TextStyleApplied.Text,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Radio(
                                    activeColor: AppColors.white,
                                    value: '2',
                                    groupValue: _radioValue,
                                    onChanged: (value) {
                                      sellbuyflag = 'S';
                                      PlaceOrder.isBuy = false;
                                      radioButtonChanges(value);
                                    },
                                  ),
                                  Text(
                                    getTranslated(context, 'sell'),
                                    style: TextStyleApplied.Text,
                                  ),
                                ],
                              ),
                            ],
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
                            getTranslated(context, 'quantity'),
                            style: TextStyleApplied.Text,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: Sizes.s5),
                            color: AppColors.white,
                            width: Sizes.s200 + 25,
                            height: Sizes.s40,
                            child: TextField(
                              style: TextStyleApplied.Text,
                              controller:
                                  PlaceOrder.allPosition ? share : quantity,
                              decoration: InputDecoration(
                                  hintStyle: TextStyleApplied.TextBlack),
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
                            getTranslated(context, 'price'),
                            style: TextStyleApplied.Text,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: Sizes.s5),
                            color: AppColors.white,
                            width: Sizes.s200 + 25,
                            height: Sizes.s40,
                            child: TextField(
                              style: TextStyleApplied.TextBlack,
                              controller: price..text = '0',
                              decoration: InputDecoration(
                                  hintText: getTranslated(
                                      context, 'leaveemptyforallprices'),
                                  hintStyle: TextStyleApplied.TextBlack),
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
                            getTranslated(context, 'ordervalue'),
                            style: TextStyleApplied.Text,
                          ),
                          Container(
                            color: AppColors.white,
                            width: Sizes.s200 + 25,
                            height: Sizes.s40,
                            child: Text(
                              orderValue,
                              style: TextStyleApplied.TextBlack,
                            ),
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
                            getTranslated(context, 'validity'),
                            style: TextStyleApplied.TextBlack,
                          ),
                          Stack(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: Sizes.s5),
                                  width: Sizes.s200,
                                  height: Sizes.s40,
                                  color: AppColors.white,
                                  child: new DropdownButton(
                                    isExpanded: true,
                                    hint: Text(
                                      _mySelection2,
                                      style: TextStyleApplied.TextBlack,
                                    ),
                                    value: _mySelection2,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _mySelection2 = newValue;
                                      });
                                    },
                                    dropdownColor: AppColors.white,
                                    style: TextStyleApplied.TextBlack,
                                    items: Validaty.map((decE) {
                                      return new DropdownMenuItem<String>(
                                        child: new Text(decE),
                                        value: decE,
                                      );
                                    }).toList(),
                                    underline: SizedBox(),
                                  ),
                                ),
                                Container(
                                  height: Sizes.s40,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.white)),
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                )
                              ],
                            )
                          ])
                        ],
                      ),
                      SizedBox(
                        height: Sizes.s3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated(context, 'validitydate'),
                            style: TextStyleApplied.Text,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: Sizes.s5),
                            width: Sizes.s200 + 25,
                            height: Sizes.s40,
                            color: AppColors.white,
                            child: GestureDetector(
                              child: Text(
                                  "${selectedDate.toLocal()}".split(' ')[0],
                                  style: TextStyleApplied.TextBlack),
                              onTap: showDateFrom,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Sizes.s3,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       getTranslated(context, 'SmartOrder'),
                      //       style: TextStyleApplied.Text,
                      //     ),
                      //     Container(
                      //         padding: EdgeInsets.only(left: Sizes.s5),
                      //         width: Sizes.s200,
                      //         height: Sizes.s30,
                      //         color: AppColors.black,
                      //         child: TextField(
                      //           enabled: false,
                      //         )),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: Sizes.s3,
                      // ),
                      ViewWidget2(),
                      SizedBox(
                        height: Sizes.s3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: Sizes.s200 + 25,
                            height: Sizes.s50,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.white),
                              color: PlaceOrder.isBuy
                                  ? AppColors.lightgreen2
                                  : AppColors.pink,
                            ),
                            child: FlatButton(
                              child: Text(
                                getTranslated(context, 'placeintomarket'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: PlaceOrder.isBuy
                                      ? AppColors.black
                                      : AppColors.white,
                                  fontSize: FontSizes.s16,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              onPressed: () {
                                setState(() {
                                  reskManagment();
                                  // }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: Sizes.s30,
                        margin: EdgeInsets.only(top: Sizes.s200),
                        color: PlaceOrder.isBuy
                            ? AppColors.lightgreen2
                            : AppColors.pink,
                      )
                    ])))));
  }

  Entries(e) {
    MapEntry entry = e.entries.firstWhere(
        (element) => element.key == 'Type' && element.value == 'TIF',
        orElse: () => null);
    if (entry != null) {
      validity_code = e['ID'];
      if (e['DescE'] == 'Day') _mySelection2 = e['DescE'];
      Validaty.add(e['DescE']);
    }
  }

  void radioButtonChanges(var value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case '1':
          print(sellbuyflag);
          choiceValue = int.parse(value);
          break;
        case '2':
          print(sellbuyflag);
          choiceValue = int.parse(value);
          break;
        default:
          choiceValue = int.parse(value);
      }
    });
  }

  //AddOrders(accountName, symbolSelect, sellbuyflag,
  //                                   quantity.text, price.text, '', '');
  Future<ReskManagment> reskManagment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String brokenID = prefs.getString('brokerid');
    String webcode = prefs.getString('webcode');
    String ucode = prefs.getString('ucode');
    String CompInit = prefs.getString('CompInit');
    String usertype = prefs.getString('UserType');
    print(
        'http://develop.fitoman.com:8080/MobileServicesRamz/TradingWServices/GetRiskManagment');
    var response = await http.post(
        'http://develop.fitoman.com:8080/MobileServicesRamz/TradingWServices/GetRiskManagment',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'AccountID': accountID,
          'ClientID': clientID,
          'CompInit': CompInit,
          'CustodyID': '-1',
          'IncludeFacil': 'Y',
          'IncludeMargin': 'Y',
          'MainClientID': mainClientID,
          'MemberID': brokenID,
          'NIN': nin,
          'OrderID': '-1',
          'OrderType': sellbuyflag,
          'PortMang': brokenID,
          'Price': price.text == '' ? '0' : price.text,
          'Qty': quantity.text == '' ? '0' : quantity.text,
          'Symbol': WatchTabs.symbol,
          'TypeCode': MarketType,
          'UCode': ucode.toString(),
          'UserCat': usertype.toString(),
          'Validity': _mySelection2,
          'ValidityCode': validity_code,
          'settType': '-1',
          'webCode': webcode
        }));
    var jsonResponse = null;
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Json Response');
      print(jsonResponse);
      print(response.statusCode);
      print('accountID ' + accountID);
      print('clientID ' + clientID);
      print('mainClientID ' + mainClientID);
      print('brokenID ' + brokenID);
      print('webcode ' + webcode);
      print('userCode ' + ucode);
      print('userType ' + usertype.toString());
      print('nin ' + nin);
      print('Date ' + _mySelection2);
      print('validityCode ' + validity_code);
      print('symbol ' + symbolSelect);
      print('price ' + price.text);
      print('quantity ' + quantity.text);
      print('sellbyflag ' + sellbuyflag);
      print('CompInit ' + CompInit);
      print('markettype ' + MarketType);
      buyPower = jsonResponse['BuyPower'];
      cash = jsonResponse['Cash'];
      share = jsonResponse['Shares'];
      sellorder = jsonResponse['SellOrders'];
      buyorder = jsonResponse['BuyOrders'];
      orderValue = jsonResponse['OrderValue'];

      // AddOrders(accountName, symbolSelect, sellbuyflag, quantity.text,
      //     price.text, '', '');
    } else {
      throw Exception('cant able to get data');
    }
  }

  Future<GetOrderListObject> AddOrders(accountName, symbol, orderType, quantity,
      price, statusCode, reason) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    String ipAddress = prefs.getString('ipAddress');
    print(accountName);
    print(symbolSelect);
    print(accountID);
    print(clientID);
    print(validity_code);
    print(nin);
    print(price);
    print(quantity);
    try {
      ///AddOrders/{SellBuyFlag}/{Symbol}/{Price}/{webCode}/{ValidityCode}/{IPAddress}/{IsAllorNone}/{AccountID}/{ClientID}/{NIN}/{CustodianID}/{Sett_Type}/{TotalVolume}/{Origin}
      var response = await http.post(
          'http://develop.fitoman.com:8080/MobileServicesRamz/RealTimeWServices/AddOrders/$sellbuyflag/$symbolSelect/$price/$webcode/${validity_code}/$ipAddress/N/${accountID}/${clientID}/${nin}/-1/-1/${quantity}/A',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'accountNameE': accountName,
            'symbol': symbol,
            'sellBuyFlag': orderType,
            'totalVolume': quantity,
            'price': price,
            'statusCode': statusCode,
            'rejectReason': reason,
          }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        Navigator.pop(context);
      } else {
        throw Exception('cant fetch data');
      }
    } catch (e) {
      print(e);
    }
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

  showDateFrom() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 1),
      lastDate: DateTime(DateTime.now().year + 20),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
