import 'dart:convert';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accounttabs/accounttabs.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/services/WatchServices/getcompainesloockup_object.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'accountportfiolio.dart';

class SearchPortifiolo extends StatefulWidget {
  static String symbol = '';

  @override
  _SearchPortifioloState createState() => _SearchPortifioloState();
}

class _SearchPortifioloState extends State<SearchPortifiolo> {
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<WatchGetCompaniesLookups>> key =
      new GlobalKey();
  static List<WatchGetCompaniesLookups> list =
      new List<WatchGetCompaniesLookups>();
  bool loading = true;
  void getSymbols() async {
    try {
      SharedPreferences prfs = await SharedPreferences.getInstance();
      String webcode = prfs.getString('webcode');
      final response = await http
          .get('${Config.GetCompaniesLookups}$webcode')
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        list = loadSymbols(response.body);
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

  @override
  void initState() {
    getSymbols();
    super.initState();
  }

  Widget row(WatchGetCompaniesLookups watchALLMarketsObjects) {
    return SingleChildScrollView(
      child: Container(
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
            ),
            Text(
              watchALLMarketsObjects.symbolCompanyA,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.9,
        child: Container(
            padding: EdgeInsets.only(top: Sizes.s150),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            color: AppColors.primary,
            child: Opacity(
              opacity: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        getTranslated(context, 'searchsymbol'),
                        style: TextStyleApplied.Text,
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            loading
                                ? CircularProgressIndicator()
                                : searchTextField = AutoCompleteTextField<
                                    WatchGetCompaniesLookups>(
                                    key: key,
                                    clearOnSubmit: false,
                                    suggestions: list,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: FontSizes.s14),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          10.0, 30.0, 10.0, 20.0),
                                      hintText:
                                          getTranslated(context, 'symbol'),
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
                                        SearchPortifiolo.symbol = item.symbol;
                                        AccountPortifiolo.symbol = item.symbol;
                                        searchTextField.textField.controller
                                            .text = item.symbol;
                                      });
                                    },
                                    itemBuilder: (context, item) {
                                      return row(item);
                                    },
                                  ),
                          ],
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: Sizes.s10),
                    color: AppColors.lightgreen2,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          AccountPortifiolo('searchSymbols.symbol');
                          AppRoutes.push(context, AccountTabs());
                        });
                      },
                      child: Text(
                        getTranslated(context, 'display'),
                        style: TextStyleApplied.Text,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Sizes.s10),
                    color: AppColors.gray,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          searchTextField.textField.controller.clear();
                          SearchPortifiolo.symbol = '';
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        getTranslated(context, 'reset'),
                        style: TextStyleApplied.Text,
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
