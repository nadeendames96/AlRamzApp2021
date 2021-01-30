import 'dart:convert';
import 'dart:ui';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/Models/watchmodel.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/services/Models/addSymbolProfile_object.dart';
import 'package:alramzapp2021/services/WatchServices/getcompainesloockup_object.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:ns_utils/src.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchSymbols extends StatefulWidget {
  @override
  _SearchSymbolsState createState() => _SearchSymbolsState();
}

class _SearchSymbolsState extends State<SearchSymbols> {
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<WatchGetCompaniesLookups>> key =
      new GlobalKey();
  List<WatchGetCompaniesLookups> list = new List<WatchGetCompaniesLookups>();
  bool loading = true;
  void getSymbols() async {
    try {
      SharedPreferences prfs = await SharedPreferences.getInstance();
      String webcode = prfs.getString('webcode');
      final response = await http.get('${Config.GetCompaniesLookups}$webcode');
      if (response.statusCode == 200) {
        list = loadSymbols(response.body);
        print('Symbols: ${list.length}');
        print('${Config.GetCompaniesLookups}$webcode');
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

  static List<WatchGetCompaniesLookups> loadSymbols(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed
        .map<WatchGetCompaniesLookups>(
            (json) => WatchGetCompaniesLookups.fromJson(json))
        .toList();
  }

  String profileID = '';
  LocalStorage storage = LocalStorage('AlRamz');
  String symbol = '';
  @override
  void initState() {
    getSymbols();
    super.initState();
    profileID = storage.getItem('profileID');
    if (profileID != null) {
      profileID = storage.getItem('profileID');
    } else {
      profileID = '';
    }
  }

  Widget row(WatchGetCompaniesLookups watchALLMarketsObjects) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            watchALLMarketsObjects.symbol,
            style: TextStyleApplied.Text,
          ),
          Text(
            watchALLMarketsObjects.symbolCompanyE,
            style: TextStyleApplied.Text,
          ),
          Text(
            watchALLMarketsObjects.symbolCompanyA,
            style: TextStyleApplied.Text,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.90,
        child: Scaffold(
            body: Container(
          margin: EdgeInsets.only(top: Sizes.s100),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Opacity(
            opacity: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      getTranslated(context, 'searchsymboltowatch'),
                      style: TextStyle(
                          color: AppColors.white, fontSize: FontSizes.s20),
                    ),
                    Hero(
                      tag: 'profileback',
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: AppColors.red,
                          size: Sizes.s40,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Sizes.s30,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    color: AppColors.white,
                    // ignore: missing_required_param
                    child: Column(
                      children: [
                        loading
                            ? CircularProgressIndicator()
                            : searchTextField =
                                AutoCompleteTextField<WatchGetCompaniesLookups>(
                                key: key,
                                clearOnSubmit: false,
                                suggestions: list,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: FontSizes.s16),
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
                                    symbol = item.symbol;
                                    storage.setItem('symbolMobile', symbol);
                                    searchTextField.textField.controller.text =
                                        item.symbol;
                                  });
                                },
                                itemBuilder: (context, item) {
                                  // ui for the autocompelete row
                                  return row(item);
                                },
                              ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(top: Sizes.s10),
                  color: AppColors.lightgreen2,
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        AddSymbol(symbol, '', '', '', '', '', '');
                      });
                    },
                    color: AppColors.lightgreen2,
                    child: Text(
                      getTranslated(context, 'addtoprofile'),
                      style: TextStyleApplied.Text,
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }

  Future<WatchAddSymbolProfileObjects> AddSymbol(symbol, lowPrice, highPrice,
      executed, lastTradePrice, netChange, netChangePerc) async {
    String profileID = this.profileID;
    String symbol = this.symbol;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    final http.Response response = await http.post(
        '${Config.AddMarketWatchProfileSymbol}${
        // profileID == '' ? StaticValues.profileID :
        profileID}/$symbol/$webcode',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'symbol': symbol,
          'lowPrice': lowPrice,
          'highPrice': highPrice,
          'executed': executed,
          'lastTradePrice': lastTradePrice,
          'netChange': netChange,
          'netChangePerc': netChangePerc,
        }));
    print('${Config.AddMarketWatchProfileSymbol}${
        // profileID == '' ? StaticValues.profileID :
        profileID}/$symbol/$webcode');
    var jsonData = null;
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      AppRoutes.push(context, WatchModel());
    } else {
      throw Exception('cant fetch data from api');
    }
  }
}
