import 'dart:async';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/Models/marketmodel.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/summaryMarket/summaries.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/services/MarektWServices/exchane_object.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExtangeMarkets.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ns_utils/src.dart';

class SelectMarket extends StatefulWidget {
  static List exchangesID = List();

  @override
  _SelectMarketState createState() => _SelectMarketState();
}

class _SelectMarketState extends State<SelectMarket> {
  LocalStorage _storage = LocalStorage('AlRamz');

  // SignalR connection;
  String _signalRStatus = 'Unknown';
  var jsonData = null;

  Future<List<ExchangeMarketObject>> selectmarket =
      ExtangesMarkets().getExchangeSummary();
  String market = '',
      marketNameEn = '',
      marketNameAr = '',
      _currentValue = '',
      netChange = '',
      netChangePrec = '',
      turnover = '',
      volume = '',
      trades = '',
      symboltrades = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.90,
        child: Scaffold(
          appBar: AppBar(
              title: Text(getTranslated(context, 'selectmarket')),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.close,
                      color: AppColors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]),
          body: MarketSummary.isConnectSignalR
              ? Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: MarketSummary.getMarketSummary.length,
                      itemBuilder: (_, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FlatButton(
                              onPressed: () async {
                                // await connection.connect();
                                setState(() {
                                  // _currentValue = snapshot
                                  //     .data[index].currentValue;
                                  // _storage.setItem('_currentValue',
                                  //     _currentValue);
                                  market = MarketSummary.getMarketSummary[index]
                                      ['ExchangeID'];
                                  marketNameEn = MarketSummary
                                      .getMarketSummary[index]['NameE'];
                                  marketNameAr = MarketSummary
                                      .getMarketSummary[index]['NameA'];
                                  _storage.setItem('market', market);
                                  // _storage.setItem(
                                  //     'marketNameEn', marketNameEn);
                                  // _storage.setItem(
                                  //     'marketNameAr', marketNameAr);
                                  // netChange = snapshot
                                  //     .data[index].netChange;
                                  // netChangePrec = snapshot
                                  //     .data[index].netChangePerc;
                                  // volume =
                                  //     snapshot.data[index].volume;
                                  // turnover =
                                  //     snapshot.data[index].turnOver;
                                  // symboltrades = snapshot
                                  //     .data[index].symbolsTraded;
                                  // trades = snapshot
                                  //     .data[index].totalExecuted;
                                  // _storage.setItem(
                                  //     '_netChange', netChange);
                                  // _storage.setItem('_netChangePrec',
                                  //     netChangePrec);
                                  // _storage.setItem(
                                  //     '_Turnover', turnover);
                                  // _storage.setItem(
                                  //     '_Volume', volume);
                                  // _storage.setItem(
                                  //     '_Trades', trades);
                                  // _storage.setItem('_SymbolTrades',
                                  //     symboltrades);
                                  AppRoutes.push(context, MarketModel());
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: Sizes.s20, left: Sizes.s5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Localizations.localeOf(context)
                                                .languageCode ==
                                            'en'
                                        ? Text(
                                            MarketSummary
                                                        .getMarketSummary[index]
                                                    ['NameE'] ??
                                                ' ',
                                            style: TextStyleApplied.Text,
                                          )
                                        : Text(
                                            MarketSummary
                                                        .getMarketSummary[index]
                                                    ['NameA'] ??
                                                ' ',
                                            style: TextStyleApplied.Text,
                                          ),
                                    Localizations.localeOf(context)
                                                .languageCode ==
                                            'en'
                                        ? Text(
                                            MarketSummary
                                                        .getMarketSummary[index]
                                                    ['NameE'] ??
                                                ' ',
                                            style: TextStyleApplied.Text,
                                          )
                                        : Text(
                                            MarketSummary
                                                        .getMarketSummary[index]
                                                    ['NameA'] ??
                                                ' ',
                                            style: TextStyleApplied.Text,
                                          ),
                                    SizedBox(
                                      height: Sizes.s10,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      }))
              : Container(
                  color: AppColors.primary,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Opacity(
                      opacity: 1,
                      child: FutureBuilder<List<ExchangeMarketObject>>(
                          future: ExtangesMarkets().getExchangeSummary(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Column(
                                children: [
                                  CircularProgressIndicator(),
                                  Container(
                                    child: Text('${snapshot.error}'),
                                  )
                                ],
                              );
                            } else {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (_, index) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FlatButton(
                                          onPressed: () async {
                                            // await connection.connect();
                                            setState(() {
                                              _currentValue = snapshot
                                                  .data[index].currentValue;
                                              _storage.setItem('_currentValue',
                                                  _currentValue);
                                              market = snapshot
                                                  .data[index].exchangeId;
                                              marketNameEn = snapshot
                                                  .data[index].exchangeNameE;
                                              marketNameAr = snapshot
                                                  .data[index].exchangeNameA;

                                              _storage.setItem(
                                                  'market', market);
                                              _storage.setItem(
                                                  'marketNameEn', marketNameEn);
                                              _storage.setItem(
                                                  'marketNameAr', marketNameAr);
                                              netChange = snapshot
                                                  .data[index].netChange;
                                              netChangePrec = snapshot
                                                  .data[index].netChangePerc;
                                              volume =
                                                  snapshot.data[index].volume;
                                              turnover =
                                                  snapshot.data[index].turnOver;
                                              symboltrades = snapshot
                                                  .data[index].symbolsTraded;
                                              trades = snapshot
                                                  .data[index].totalExecuted;
                                              _storage.setItem(
                                                  '_netChange', netChange);
                                              _storage.setItem('_netChangePrec',
                                                  netChangePrec);
                                              _storage.setItem(
                                                  '_Turnover', turnover);
                                              _storage.setItem(
                                                  '_Volume', volume);
                                              _storage.setItem(
                                                  '_Trades', trades);
                                              _storage.setItem('_SymbolTrades',
                                                  symboltrades);
                                              AppRoutes.push(
                                                  context, MarketModel());
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: Sizes.s20, left: Sizes.s5),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Localizations.localeOf(context)
                                                            .languageCode ==
                                                        'en'
                                                    ? Text(
                                                        snapshot.data[index]
                                                            .exchangeNameE,
                                                        style: TextStyleApplied
                                                            .Text,
                                                      )
                                                    : Text(
                                                        snapshot.data[index]
                                                            .exchangeNameA,
                                                        style: TextStyleApplied
                                                            .Text,
                                                      ),
                                                Localizations.localeOf(context)
                                                            .languageCode ==
                                                        'en'
                                                    ? Text(
                                                        snapshot.data[index]
                                                            .exchangeNameE,
                                                        style: TextStyleApplied
                                                            .Text,
                                                      )
                                                    : Text(
                                                        snapshot.data[index]
                                                            .exchangeNameA,
                                                        style: TextStyleApplied
                                                            .Text,
                                                      ),
                                                SizedBox(
                                                  height: Sizes.s10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            }
                          })),
                ),
        ));
  }
}
