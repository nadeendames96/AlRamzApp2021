import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/markettabinfo/markettabinfo.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/summaryMarket/summaries.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/watchtabs/tabs.dart';
import 'package:alramzapp2021/services/MarektWServices/excangelosers_object.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExtangeMarkets.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class Losers extends StatefulWidget {
  static String symbol = '';

  @override
  _LosersState createState() => _LosersState();
}

class _LosersState extends State<Losers> {
  LocalStorage storage = LocalStorage('AlRamz');
  String market = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    market = storage.getItem('market');
    if (market != null) {
      market = storage.getItem('market');
    } else {
      market = '';
    }
  }

  bool isDivider = false;

  @override
  Widget build(BuildContext context) {
    return MarketSummary.isConnectSignalR
        ? Container(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: MarketSummary.jsonDataLossers.length,
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {
                    isDivider = true;
                  } else {
                    isDivider = false;
                  }
                  return isDivider
                      ? Container(
                          color: AppColors.black.withOpacity(.3),
                          child: Card(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          // WatchTabs.symbol =
                                          // snapshot.data[index].symbol;
                                          // WatchTabs.lasttrade = snapshot
                                          //     .data[index].lastTradePrice;
                                          // WatchTabs.netchange = double.parse(
                                          // snapshot.data[index].netChange);
                                          // WatchTabs.netchangeprec = snapshot
                                          //     .data[index].netChangePerc;
                                          // WatchTabs.bidprice =
                                          // snapshot.data[index].bidPrice;
                                          // WatchTabs.updatedate = snapshot
                                          //     .data[index].lastUpdateTime;
                                          // AppRoutes.push(
                                          // context, WatchTabs());
                                        });
                                      },
                                      child: MarketTabInfo(
                                          MarketSummary.jsonDataLossers[index]
                                              ['Symbol'],
                                          Localizations.localeOf(context)
                                                      .languageCode ==
                                                  'en'
                                              ? MarketSummary
                                                      .jsonDataLossers[index]
                                                  ['SymbolNameE']
                                              : MarketSummary
                                                      .jsonDataLossers[index]
                                                  ['SymbolNameA'],
                                          MarketSummary.jsonDataLossers[index]
                                              ['LowPrice'],
                                          MarketSummary.jsonDataLossers[index]
                                              ['HighPrice'],
                                          MarketSummary.jsonDataLossers[index]
                                              ['LastTradePrice'],
                                          MarketSummary.jsonDataLossers[index]
                                              ['NetChange'],
                                          MarketSummary.jsonDataLossers[index]
                                              ['NetChangePerc'])))),
                        )
                      : Container(
                          padding: EdgeInsets.only(left: 2, top: 2, bottom: 2),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  // WatchTabs.symbol =
                                  // snapshot.data[index].symbol;
                                  // WatchTabs.lasttrade =
                                  // snapshot.data[index].lastTradePrice;
                                  // WatchTabs.netchange = double.parse(
                                  // snapshot.data[index].netChange);
                                  // WatchTabs.netchangeprec =
                                  // snapshot.data[index].netChangePerc;
                                  // WatchTabs.bidprice =
                                  // snapshot.data[index].bidPrice;
                                  // WatchTabs.updatedate =
                                  // snapshot.data[index].lastUpdateTime;
                                  // AppRoutes.push(context, WatchTabs());
                                });
                              },
                              child: MarketTabInfo(
                                  MarketSummary.jsonDataLossers[index]
                                      ['Symbol'],
                                  Localizations.localeOf(context)
                                              .languageCode ==
                                          'en'
                                      ? MarketSummary.jsonDataLossers[index]
                                          ['SymbolNameE']
                                      : MarketSummary.jsonDataLossers[index]
                                          ['SymbolNameA'],
                                  MarketSummary.jsonDataLossers[index]
                                      ['LowPrice'],
                                  MarketSummary.jsonDataLossers[index]
                                      ['HighPrice'],
                                  MarketSummary.jsonDataLossers[index]
                                      ['LastTradePrice'],
                                  MarketSummary.jsonDataLossers[index]
                                      ['NetChange'],
                                  MarketSummary.jsonDataLossers[index]
                                      ['NetChangePerc'])));
                }),
          )
        : Container(
            child: FutureBuilder<List<ExchnageLossersMarketObject>>(
                future: ExtangesMarkets().getExchangeSummaryLosers(market
                    // == '' ? StaticValues.market : market
                    ),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Column(
                      children: [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                        Container(
                          child: Text(snapshot.error),
                        )
                      ],
                    );
                  } else {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          if (index % 2 == 0) {
                            isDivider = true;
                          } else {
                            isDivider = false;
                          }
                          return isDivider
                              ? Container(
                                  color: AppColors.black.withOpacity(.3),
                                  child: Card(
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2, bottom: 2),
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  WatchTabs.symbol = snapshot
                                                      .data[index].symbol;
                                                  WatchTabs.lasttrade = snapshot
                                                      .data[index]
                                                      .lastTradePrice;
                                                  WatchTabs.netchange =
                                                      double.parse(snapshot
                                                          .data[index]
                                                          .netChange);
                                                  WatchTabs.netchangeprec =
                                                      snapshot.data[index]
                                                          .netChangePerc;
                                                  WatchTabs.bidprice = snapshot
                                                      .data[index].bidPrice;
                                                  WatchTabs.updatedate =
                                                      snapshot.data[index]
                                                          .lastUpdateTime;
                                                  AppRoutes.push(
                                                      context, WatchTabs());
                                                });
                                              },
                                              child: MarketTabInfo(
                                                  snapshot.data[index].symbol,
                                                  Localizations.localeOf(
                                                                  context)
                                                              .languageCode ==
                                                          'en'
                                                      ? snapshot.data[index]
                                                          .symbolNameE
                                                      : snapshot.data[index]
                                                          .symbolNameA,
                                                  snapshot.data[index].lowPrice,
                                                  snapshot
                                                      .data[index].highPrice,
                                                  snapshot.data[index]
                                                      .lastTradePrice,
                                                  snapshot
                                                      .data[index].netChange,
                                                  snapshot.data[index]
                                                      .netChangePerc)))),
                                )
                              : Container(
                                  padding: EdgeInsets.only(
                                      left: 2, top: 2, bottom: 2),
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          WatchTabs.symbol =
                                              snapshot.data[index].symbol;
                                          WatchTabs.lasttrade = snapshot
                                              .data[index].lastTradePrice;
                                          WatchTabs.netchange = double.parse(
                                              snapshot.data[index].netChange);
                                          WatchTabs.netchangeprec = snapshot
                                              .data[index].netChangePerc;
                                          WatchTabs.bidprice =
                                              snapshot.data[index].bidPrice;
                                          WatchTabs.updatedate = snapshot
                                              .data[index].lastUpdateTime;
                                          AppRoutes.push(context, WatchTabs());
                                        });
                                      },
                                      child: MarketTabInfo(
                                          snapshot.data[index].symbol,
                                          Localizations.localeOf(context)
                                                      .languageCode ==
                                                  'en'
                                              ? snapshot.data[index].symbolNameE
                                              : snapshot
                                                  .data[index].symbolNameA,
                                          snapshot.data[index].lowPrice,
                                          snapshot.data[index].highPrice,
                                          snapshot.data[index].lastTradePrice,
                                          snapshot.data[index].netChange,
                                          snapshot.data[index].netChangePerc)));
                        });
                  }
                }),
          );
  }
}
