import 'dart:async';
import 'dart:convert';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformate.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformatetextcolor.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_flutter/signalr_flutter.dart';

class FirstSection extends StatefulWidget {
  static List jsonDataIndex = [];
  static List jsonDataGainers = [];
  static List jsonDataLossers = [];
  static List jsonDataActivites = [];
  static List jsonDataNews = [];
  @override
  _FirstSectionState createState() => _FirstSectionState();
}

class _FirstSectionState extends State<FirstSection> {
  String market = '',
      marketNameEn = '',
      marketNameAr = '',
      turnover = '',
      volume = '',
      trades = '',
      symboltrades = '',
      currentValue = '',
      netChange = '',
      netChangePrec = '';

  SignalR connection;
  String _signalRStatus = 'Unknown';
  String exchangeID = '';
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd/MM/yyyy').add_jm();
  final String formatted = formatter.format(now);
  LocalStorage _storage = LocalStorage('AlRamz');
  var jsonData = null;
  var jsondata = null;
  String currentValue2 = '',
      TurnOver = '',
      TotalExecuted = '',
      NetChange = '',
      NetChangePerc = '',
      Volume = '',
      SymbolsTraded = '';
  bool isFirstLogin = true;
  int count = 5;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      initPlatformState();
      currentValue = _storage.getItem('_currentValue');
      netChange = _storage.getItem('_netChange');
      netChangePrec = _storage.getItem('_netChangePrec');
      turnover = _storage.getItem('_Turnover');
      volume = _storage.getItem('_Volume');
      trades = _storage.getItem('_Trades');
      symboltrades = _storage.getItem('_SymbolTrades');
      market = _storage.getItem('market');
      marketNameEn = _storage.getItem('marketNameEn');
      marketNameAr = _storage.getItem('marketNameAr');
      exchangeID = market;
      if (market != null) {
        market = _storage.getItem('market');
        exchangeID = market;
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
        marketNameEn = '';
      }
      if (turnover != null) {
        turnover = _storage.getItem('_Turnover');
      } else {
        turnover = '';
      }
      if (volume != null) {
        volume = _storage.getItem('_Volume');
      } else {
        volume = '';
      }
      if (trades != null) {
        trades = _storage.getItem('_Trades');
      } else {
        trades = '';
      }
      if (symboltrades != null) {
        symboltrades = _storage.getItem('_SymbolTrades');
      } else {
        symboltrades = '';
      }
      if (currentValue != null) {
        currentValue = _storage.getItem('_currentValue');
      } else {
        currentValue = '';
      }
      if (netChange != null) {
        netChange = _storage.getItem('_netChange');
      } else {
        netChange = '';
      }
      if (netChangePrec != null) {
        netChangePrec = _storage.getItem('_netChangePrec');
      } else {
        netChangePrec = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return _signalRStatus == 'Connected'
    //     ?
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: Sizes.s15),
            child: Localizations.localeOf(context).languageCode == 'en'
                ? Text(exchangeID,
                    // ? marketNameEn == ''
                    //     ? StaticValues.marketNameE
                    //     : marketNameEn
                    // : marketNameAr == ''
                    //     ? StaticValues.marketNameA
                    //     : marketNameAr,
                    style: TextStyleApplied.TextBold)
                : Text(exchangeID, style: TextStyleApplied.TextBold),
          ),
          Padding(
              padding: EdgeInsets.only(left: Sizes.s15),
              child: Row(
                children: [
                  Text(formatted, style: TextStyleApplied.TextCustomNormal),
                  SizedBox(width: Sizes.s3),
                ],
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: Sizes.s10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // currentValue == '' &&
                      //         netChange == '' &&
                      //         netChangePrec == ''
                      //     ? SpacficTextColor(
                      //         StaticValues.currentValue,
                      //         StaticValues.netChange,
                      //         StaticValues.netChangePrec)
                      //     : SpacficTextColor(
                      //         currentValue, netChange, netChangePrec),
                      SpacficTextColor(currentValue2, NetChange, NetChangePerc),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: Sizes.s10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        getTranslated(context, 'turnover'),
                        style: TextStyleApplied.TextCustomTabs,
                      ),
                      Container(
                        child: SpacificFormate(
                          TurnOver,
                          // turnover == '' ? StaticValues.turnover : turnover,
                          // snapshot.data.turnOver,
                          valueText: TextStyleApplied.TextCustomLarge,
                        ),
                      ),
                      SizedBox(
                        height: Sizes.s5,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            getTranslated(context, 'trades'),
                            style: TextStyleApplied.TextCustomTabs,
                          ),
                          SizedBox(
                            width: Sizes.s5,
                          ),
                          Container(
                            child: SpacificFormate(
                              TotalExecuted
                              // trades == '' ? StaticValues.trades : trades,
                              // snapshot.data.totalExecuted
                              ,
                              valueText: TextStyleApplied.TextCustomLarge,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text("|", style: TextStyleApplied.Text),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(getTranslated(context, 'volume'),
                          style: TextStyleApplied.TextCustomTabs),
                      Container(
                        child: SpacificFormate(
                            Volume
                            // snapshot.data.volume
                            // volume == '' ? StaticValues.volume : volume,
                            ,
                            valueText: TextStyleApplied.TextCustomLarge),
                      ),
                      SizedBox(
                        height: Sizes.s5,
                      ),
                      Row(
                        children: <Widget>[
                          Text(getTranslated(context, 'symbolstraded'),
                              style: TextStyleApplied.Text),
                          SizedBox(
                            width: Sizes.s5,
                          ),
                          Container(
                            child: Text(
                                SymbolsTraded
                                // snapshot.data.symbolsTraded
                                // symboltrades == ''
                                //     ? StaticValues.symbolTrades
                                //     : symboltrades,
                                ,
                                style: TextStyleApplied.TextCustomLarge),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ]);
    // : FutureBuilder<MarketObjectByID>(
    //     future: ExtangesMarkets().getExchangeSummaryBYID(
    //         market == '' ? StaticValues.market : market),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return ListView.builder(
    //           shrinkWrap: true,
    //           itemCount: 1,
    //           itemBuilder: (context, index) {
    //             return Column(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Container(
    //                     padding: EdgeInsets.only(left: Sizes.s15),
    //                     child:
    //                         Localizations.localeOf(context).languageCode ==
    //                                 'en'
    //                             ? Text(snapshot.data.exchangeNameE,
    //                                 // ? marketNameEn == ''
    //                                 //     ? StaticValues.marketNameE
    //                                 //     : marketNameEn
    //                                 // : marketNameAr == ''
    //                                 //     ? StaticValues.marketNameA
    //                                 //     : marketNameAr,
    //                                 style: TextStyleApplied.TextBold)
    //                             : Text(snapshot.data.exchangeNameA,
    //                                 style: TextStyleApplied.TextBold),
    //                   ),
    //                   Padding(
    //                       padding: EdgeInsets.only(left: Sizes.s15),
    //                       child: Row(
    //                         children: [
    //                           Text(formatted,
    //                               style: TextStyleApplied.TextCustomNormal),
    //                           SizedBox(width: Sizes.s3),
    //                         ],
    //                       )),
    //                   Column(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: <Widget>[
    //                       Row(
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: <Widget>[
    //                           SizedBox(
    //                             width: Sizes.s10,
    //                           ),
    //                           Column(
    //                             mainAxisAlignment: MainAxisAlignment.start,
    //                             crossAxisAlignment:
    //                                 CrossAxisAlignment.center,
    //                             children: <Widget>[
    //                               // currentValue == '' &&
    //                               //         netChange == '' &&
    //                               //         netChangePrec == ''
    //                               //     ? SpacficTextColor(
    //                               //         StaticValues.currentValue,
    //                               //         StaticValues.netChange,
    //                               //         StaticValues.netChangePrec)
    //                               //     : SpacficTextColor(
    //                               //         currentValue, netChange, netChangePrec),
    //                               SpacficTextColor(currentValue2, NetChange,
    //                                   NetChangePerc),
    //                             ],
    //                           )
    //                         ],
    //                       ),
    //                       SizedBox(
    //                         height: Sizes.s10,
    //                       ),
    //                       Row(
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         mainAxisAlignment:
    //                             MainAxisAlignment.spaceEvenly,
    //                         children: <Widget>[
    //                           Column(
    //                             mainAxisAlignment: MainAxisAlignment.start,
    //                             crossAxisAlignment:
    //                                 CrossAxisAlignment.center,
    //                             children: <Widget>[
    //                               Text(
    //                                 getTranslated(context, 'turnover'),
    //                                 style: TextStyleApplied.TextCustomTabs,
    //                               ),
    //                               Container(
    //                                 child: SpacificFormate(
    //                                   TurnOver,
    //                                   // turnover == '' ? StaticValues.turnover : turnover,
    //                                   // snapshot.data.turnOver,
    //                                   valueText:
    //                                       TextStyleApplied.TextCustomLarge,
    //                                 ),
    //                               ),
    //                               SizedBox(
    //                                 height: Sizes.s5,
    //                               ),
    //                               Row(
    //                                 children: <Widget>[
    //                                   Text(
    //                                     getTranslated(context, 'trades'),
    //                                     style:
    //                                         TextStyleApplied.TextCustomTabs,
    //                                   ),
    //                                   SizedBox(
    //                                     width: Sizes.s5,
    //                                   ),
    //                                   Container(
    //                                     child: SpacificFormate(
    //                                       TotalExecuted
    //                                       // trades == '' ? StaticValues.trades : trades,
    //                                       // snapshot.data.totalExecuted
    //                                       ,
    //                                       valueText: TextStyleApplied
    //                                           .TextCustomLarge,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ],
    //                           ),
    //                           Text("|", style: TextStyleApplied.Text),
    //                           Column(
    //                             mainAxisAlignment: MainAxisAlignment.start,
    //                             crossAxisAlignment:
    //                                 CrossAxisAlignment.center,
    //                             children: <Widget>[
    //                               Text(getTranslated(context, 'volume'),
    //                                   style:
    //                                       TextStyleApplied.TextCustomTabs),
    //                               Container(
    //                                 child: SpacificFormate(
    //                                     Volume
    //                                     // snapshot.data.volume
    //                                     // volume == '' ? StaticValues.volume : volume,
    //                                     ,
    //                                     valueText: TextStyleApplied
    //                                         .TextCustomLarge),
    //                               ),
    //                               SizedBox(
    //                                 height: Sizes.s5,
    //                               ),
    //                               Row(
    //                                 children: <Widget>[
    //                                   Text(
    //                                       getTranslated(
    //                                           context, 'symbolstraded'),
    //                                       style: TextStyleApplied.Text),
    //                                   SizedBox(
    //                                     width: Sizes.s5,
    //                                   ),
    //                                   Container(
    //                                     child: Text(
    //                                         SymbolsTraded
    //                                         // snapshot.data.symbolsTraded
    //                                         // symboltrades == ''
    //                                         //     ? StaticValues.symbolTrades
    //                                         //     : symboltrades,
    //                                         ,
    //                                         style: TextStyleApplied
    //                                             .TextCustomLarge),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ]);
    //           },
    //         );
    //       } else if (snapshot.hasError) {
    //         return Center(child: Text("No messages to display"));
    //       }
    //       return Center(
    //           child: CircularProgressIndicator(
    //               backgroundColor: Theme.of(context).primaryColor));
    //     });
  }

  Future<void> initPlatformState() async {
    connection = SignalR(
        'http://109.107.237.83:8080/MobileServices/sr/signalr/hubs', "MyHub",
        headers: {'Cookie': '${Config.cookieSave}'},
        hubMethods: ['sendExchangeMarketObject'],
        statusChangeCallback: _onStatusChange,
        hubCallback: _onNewMessage);
    invokedMethods();
    await connection.connect();
  }

  _onStatusChange(dynamic status) {
    if (mounted) {
      setState(() {
        _signalRStatus = status as String;
      });
      Fluttertoast.showToast(msg: _signalRStatus);
      print('statuc connection');
      print(_signalRStatus);
    }
  }

  _onNewMessage(String methodName, dynamic message) {
    print('MethodName = $methodName, Message = $message');
    setState(() {
      jsonData = json.decode(message);
      for (jsondata in jsonData) {
        if (exchangeID == jsondata['ExchangeID']) {
          currentValue2 = jsondata['CurrentValue'];
          TurnOver = jsondata['TurnOver'];
          NetChange = jsondata['NetChange'];
          NetChangePerc = jsondata['NetChangePerc'];
          Volume = jsondata['Volume'];
          TotalExecuted = jsondata['TotalExecuted'];
          SymbolsTraded = jsondata['SymbolsTraded'];
        } else {}
      }
    });
  }

  void invokedMethods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    final resIndex = await connection.invokeMethod<dynamic>(
        'getMarketIndexObject',
        arguments: ['$exchangeID', '$webcode']);
    FirstSection.jsonDataIndex = json.decode(resIndex);
    print('jsonIndexx');
    print(FirstSection.jsonDataIndex);

    final resGainers = await connection.invokeMethod('getTopGainerObject',
        arguments: ['$exchangeID', '$webcode']);
    FirstSection.jsonDataGainers = json.decode(resGainers);
    print('jsonGainers');
    print(FirstSection.jsonDataGainers);

    final resLossers = await connection.invokeMethod('getTopLoserObject',
        arguments: ['$exchangeID', '$webcode']);
    FirstSection.jsonDataLossers = json.decode(resLossers);
    print('jsonLossers');
    print(FirstSection.jsonDataLossers);

    final resActivites = await connection.invokeMethod('getMostActiveObject',
        arguments: ['$exchangeID', '$webcode']);
    FirstSection.jsonDataActivites = json.decode(resActivites);

    print('jsonActivites');
    print(FirstSection.jsonDataActivites);

    final resNwes = await connection
        .invokeMethod('GetAllMarketNews', arguments: ['$exchangeID']);
    FirstSection.jsonDataNews = json.decode(resNwes);

    print('jsonNews');
    print(FirstSection.jsonDataNews);
    // await connection.connect();
  }
}
