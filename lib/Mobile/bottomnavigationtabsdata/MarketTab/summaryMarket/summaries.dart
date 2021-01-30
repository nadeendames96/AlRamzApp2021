import 'dart:async';
import 'dart:convert';
import 'dart:ui' as uii;

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformate.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformatetextcolor.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/indecies/indeciesdesign.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/indecies/index.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/indecies/indexinformation/mainindex.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/scrolling/scroll.dart';
import 'package:alramzapp2021/services/MarektWServices/exchangemarketcharts_object.dart';
import 'package:alramzapp2021/services/MarektWServices/exchangesymmaryindecies_object.dart';
import 'package:alramzapp2021/services/MarektWServices/market_object_byID.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExtangeMarkets.dart';
import 'package:alramzapp2021/services/lookups_object.dart';
import 'package:alramzapp2021/statics_value/staticvalues.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_flutter/signalr_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MarketSummary extends StatefulWidget {
  static List jsonDataIndex = [];
  static List jsonDataGainers = [];
  static List jsonDataLossers = [];
  static List jsonDataActivites = [];
  static List jsonDataNews = [];
  static List getMarketSummary = [];
  static bool isConnectSignalR = false;
  @override
  _MarketSummaryState createState() => _MarketSummaryState();
}

class _MarketSummaryState extends State<MarketSummary> {
  String market = '',
      marketNameEn = '',
      marketNameAr = '',
      turnover = '',
      volume = '',
      trades = '',
      symboltrades = '',
      currentValue = '',
      netChange = '',
      netChangePrec = '',
      statusCodeExchnageMarket = '';

  List jsonDataIndex = [];
  // List jsonDataGainers = [];
  // List jsonDataLossers = [];
  // List jsonDataActivites = [];
  // List jsonDataNews = [];

  SignalR connection;
  String _signalRStatus = 'Unknown';
  String exchangeID = '';
  static String exchangeNameEn = '',
      exchangeNameAr = '',
      netChangePerc = '',
      turnOver = '',
      sector = '',
      nameE = '',
      nameA = '';
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd/MM/yyyy').add_jm();
  final String formatted = formatter.format(now);
  LocalStorage _storage = LocalStorage('AlRamz');
  var jsonData = null;
  var jsondata = null;
  var oldFormat = "MM-dd-yyyy h:mm:ss";
  String currentValue2 = '',
      TurnOver = '',
      TotalExecuted = '',
      NetChange = '',
      NetChangePerc = '',
      Volume = '',
      SymbolsTraded = '',
      marketNameE = '',
      marketNameA = '';
  bool isFirstLogin = true;
  int count = 5;
  bool isDivider = false;
  Timer _timer;
  List data = [];
  String statusCompany = '', statusCompanyA = '';
  bool isOpen = false, isClose = false, isOther = true;
  Future<List<GetLookupsObject>> getLookupsObject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    print("${Config.GetLookups}$webcode");
    http.Response response = await http.get("${Config.GetLookups}$webcode",
        headers: {
          'Cookie': '${Config.cookieSave}'
        }).timeout(const Duration(seconds: Config.Timeout));
    var jsonDate = null;
    List<GetLookupsObject> list = [];
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      setState(() {
        data = jsonDate;
        data.map((e) => Entries(e)).toList();
        // print(jsonData);
      });
      // for (var jsondata in jsonDate) {
      //   list.add(GetLookupsObject.fromJson(jsondata));
      // }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLookupsObject();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        jsonDataIndex = this.jsonDataIndex;
        _timer.cancel();
      });
    });
    setState(() {
      if (_signalRStatus == 'Connected') {
        MarketSummary.isConnectSignalR = true;
      } else {
        MarketSummary.isConnectSignalR = false;
      }
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
      exchangeID = market == '' ? StaticValues.market : market;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MarketSummary.isConnectSignalR
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Container(
                        padding: EdgeInsets.only(left: Sizes.s15),
                        child:
                            Localizations.localeOf(context).languageCode == 'en'
                                ? Text(marketNameE,
                                    style: TextStyleApplied.TextBold)
                                : Text(marketNameA,
                                    style: TextStyleApplied.TextBold),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: Sizes.s15),
                          child: Row(
                            children: [
                              Text(formatted,
                                  style: TextStyleApplied.TextCustomNormal),
                              SizedBox(width: Sizes.s3),
                              Localizations.localeOf(context).languageCode ==
                                      'en'
                                  ? isOpen
                                      ? Text(statusCompany,
                                          style: TextStyleApplied
                                              .TextCustomNormalGreen)
                                      : isClose
                                          ? Text(statusCompany,
                                              style: TextStyleApplied
                                                  .TextCustomNormalRed)
                                          : Text(statusCompany,
                                              style: TextStyleApplied
                                                  .TextCustomNormalOrange)
                                  : isOpen
                                      ? Text(statusCompanyA,
                                          style: TextStyleApplied
                                              .TextCustomNormalGreen)
                                      : isClose
                                          ? Text(statusCompanyA,
                                              style: TextStyleApplied
                                                  .TextCustomNormalRed)
                                          : Text(statusCompanyA,
                                              style: TextStyleApplied
                                                  .TextCustomNormalOrange),
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
                                  SpacficTextColor(
                                      currentValue2, NetChange, NetChangePerc),
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
                                      valueText:
                                          TextStyleApplied.TextCustomLarge,
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
                                          TotalExecuted,
                                          valueText:
                                              TextStyleApplied.TextCustomLarge,
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
                                    child: SpacificFormate(Volume,
                                        valueText:
                                            TextStyleApplied.TextCustomLarge),
                                  ),
                                  SizedBox(
                                    height: Sizes.s5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                          getTranslated(
                                              context, 'symbolstraded'),
                                          style: TextStyleApplied.Text),
                                      SizedBox(
                                        width: Sizes.s5,
                                      ),
                                      Container(
                                        child: Text(SymbolsTraded,
                                            style: TextStyleApplied
                                                .TextCustomLarge),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ])
              : FutureBuilder<MarketObjectByID>(
                  future: ExtangesMarkets().getExchangeSummaryBYID(
                      market == '' ? StaticValues.market : market),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          statusCodeExchnageMarket = snapshot.data.statusCode;
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: Sizes.s15),
                                  child: Localizations.localeOf(context)
                                              .languageCode ==
                                          'en'
                                      ? Text(
                                          marketNameEn == ''
                                              ? StaticValues.marketNameE
                                              : marketNameEn,
                                          style: TextStyleApplied.TextBold)
                                      : Text(
                                          marketNameAr == ''
                                              ? StaticValues.marketNameA
                                              : marketNameAr,
                                          style: TextStyleApplied.TextBold),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: Sizes.s15),
                                    child: Row(
                                      children: [
                                        Text(formatted,
                                            style: TextStyleApplied
                                                .TextCustomNormal),
                                        SizedBox(width: Sizes.s3),
                                        Localizations.localeOf(context)
                                                    .languageCode ==
                                                'en'
                                            ? isOpen
                                                ? Text(statusCompany,
                                                    style: TextStyleApplied
                                                        .TextCustomNormalGreen)
                                                : isClose
                                                    ? Text(statusCompany,
                                                        style: TextStyleApplied
                                                            .TextCustomNormalRed)
                                                    : Text(statusCompany,
                                                        style: TextStyleApplied
                                                            .TextCustomNormalOrange)
                                            : isOpen
                                                ? Text(statusCompanyA,
                                                    style: TextStyleApplied
                                                        .TextCustomNormalGreen)
                                                : isClose
                                                    ? Text(statusCompanyA,
                                                        style: TextStyleApplied
                                                            .TextCustomNormalRed)
                                                    : Text(statusCompanyA,
                                                        style: TextStyleApplied
                                                            .TextCustomNormalOrange),
                                      ],
                                    )),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: Sizes.s10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            currentValue == '' &&
                                                    netChange == '' &&
                                                    netChangePrec == ''
                                                ? SpacficTextColor(
                                                    StaticValues.currentValue,
                                                    StaticValues.netChange,
                                                    StaticValues.netChangePrec)
                                                : SpacficTextColor(currentValue,
                                                    netChange, netChangePrec),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: Sizes.s10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              getTranslated(
                                                  context, 'turnover'),
                                              style: TextStyleApplied
                                                  .TextCustomTabs,
                                            ),
                                            Container(
                                              child: SpacificFormate(
                                                turnover == ''
                                                    ? StaticValues.turnover
                                                    : turnover,
                                                valueText: TextStyleApplied
                                                    .TextCustomLarge,
                                              ),
                                            ),
                                            SizedBox(
                                              height: Sizes.s5,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  getTranslated(
                                                      context, 'trades'),
                                                  style: TextStyleApplied
                                                      .TextCustomTabs,
                                                ),
                                                SizedBox(
                                                  width: Sizes.s5,
                                                ),
                                                Container(
                                                  child: SpacificFormate(
                                                    trades == ''
                                                        ? StaticValues.trades
                                                        : trades,
                                                    valueText: TextStyleApplied
                                                        .TextCustomLarge,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text("|", style: TextStyleApplied.Text),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                                getTranslated(
                                                    context, 'volume'),
                                                style: TextStyleApplied
                                                    .TextCustomTabs),
                                            Container(
                                              child: SpacificFormate(
                                                  volume == ''
                                                      ? StaticValues.volume
                                                      : volume,
                                                  valueText: TextStyleApplied
                                                      .TextCustomLarge),
                                            ),
                                            SizedBox(
                                              height: Sizes.s5,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                    getTranslated(context,
                                                        'symbolstraded'),
                                                    style:
                                                        TextStyleApplied.Text),
                                                SizedBox(
                                                  width: Sizes.s5,
                                                ),
                                                Container(
                                                  child: Text(
                                                      symboltrades == ''
                                                          ? StaticValues
                                                              .symbolTrades
                                                          : symboltrades,
                                                      style: TextStyleApplied
                                                          .TextCustomLarge),
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
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("No messages to display"));
                    }
                    return Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor));
                  }),
          FutureBuilder(
            future: ExtangesMarkets().getChartsSummaryByID(
                // market == '' ? StaticValues.market : market
                MarketSummary.isConnectSignalR
                    ? exchangeID
                    : market == ''
                        ? StaticValues.market
                        : market),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return SfCartesianChart();
              } else {
                // return Container(
                //   height: MediaQuery.of(context).size.height / 1.85,
                //   child: WebViewContainer(
                //       'http://develop.fitoman.com:8080/ChartIQ/technical-analysis-chart.html'),
                // );
                return Localizations.localeOf(context).languageCode == 'en'
                    ? Directionality(
                        textDirection: uii.TextDirection.ltr,
                        child: SfCartesianChart(
                          tooltipBehavior: TooltipBehavior(enable: true),
                          enableAxisAnimation: true,
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                            AreaSeries<ExchangeMArketChartObject, dynamic>(
                              color: AppColors.blue_light,
                              dataSource: snapshot.data,
                              xValueMapper:
                                  (ExchangeMArketChartObject Date, _) =>
                                      Date.DateT,
                              // formatDate(
                              //     context, Date.DateT, oldFormat, "h:mm a"),
                              yValueMapper:
                                  (ExchangeMArketChartObject Close, _) =>
                                      double.parse(Close.close),
                            ),
                          ],
                        ),
                      )
                    : Directionality(
                        textDirection: uii.TextDirection.ltr,
                        child: SfCartesianChart(
                          tooltipBehavior: TooltipBehavior(enable: true),
                          enableAxisAnimation: true,
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                            AreaSeries<ExchangeMArketChartObject, dynamic>(
                              color: AppColors.blue_light,
                              dataSource: snapshot.data,
                              xValueMapper:
                                  (ExchangeMArketChartObject Date, _) =>
                                      Date.DateT,
                              yValueMapper:
                                  (ExchangeMArketChartObject Close, _) =>
                                      double.parse(Close.close),
                            ),
                          ],
                        ),
                      );
              }
            },
          ),
          MarketSummary.isConnectSignalR
              ? Container(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: jsonDataIndex.length,
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
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            // Indecies.nameA =
                                            //     snapshot.data[index].nameA;
                                            // Indecies.currentValue =
                                            //     snapshot.data[index].currentValue;
                                            // Indecies.nameE =
                                            //     snapshot.data[index].nameE;
                                            // Indecies.exchangeID =
                                            //     snapshot.data[index].exchangeID;
                                            // Indecies.netChange =
                                            //     snapshot.data[index].netChange;
                                            // Indecies.netChangePerc =
                                            //     snapshot.data[index].netChangePerc;
                                            // Indecies.turnOver =
                                            //     snapshot.data[index].turnOver;
                                            // Indecies.volume =
                                            //     snapshot.data[index].volume;
                                            // Indecies.sector =
                                            //     snapshot.data[index].sector;
                                            // AppRoutes.push(context, MainIndex());
                                          });
                                        },
                                        child: Localizations.localeOf(context)
                                                    .languageCode ==
                                                'en'
                                            ? Indeies(
                                                jsonDataIndex[index]['NameE'],
                                                jsonDataIndex[index]['Low'],
                                                jsonDataIndex[index]['High'],
                                                jsonDataIndex[index]
                                                    ['CurrentValue'],
                                                jsonDataIndex[index]
                                                    ['NetChange'],
                                                jsonDataIndex[index]
                                                    ['NetChangePerc'])
                                            : Indeies(
                                                jsonDataIndex[index]['NameA'],
                                                jsonDataIndex[index]['Low'],
                                                jsonDataIndex[index]['High'],
                                                jsonDataIndex[index]
                                                    ['CurrentValue'],
                                                jsonDataIndex[index]
                                                    ['NetChange'],
                                                jsonDataIndex[index]
                                                    ['NetChangePerc']))),
                              )
                            : Container(
                                padding:
                                    EdgeInsets.only(left: 2, top: 5, bottom: 5),
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        // Indecies.nameA = snapshot.data[index].nameA;
                                        // Indecies.currentValue =
                                        //     snapshot.data[index].currentValue;
                                        // Indecies.nameE = snapshot.data[index].nameE;
                                        // Indecies.exchangeID =
                                        //     snapshot.data[index].exchangeID;
                                        // Indecies.netChange =
                                        //     snapshot.data[index].netChange;
                                        // Indecies.netChangePerc =
                                        //     snapshot.data[index].netChangePerc;
                                        // Indecies.turnOver =
                                        //     snapshot.data[index].turnOver;
                                        // Indecies.volume = snapshot.data[index].volume;
                                        // Indecies.sector = snapshot.data[index].sector;
                                        // AppRoutes.push(context, MainIndex());
                                      });
                                    },
                                    child: Localizations.localeOf(context)
                                                .languageCode ==
                                            'en'
                                        ? Indeies(
                                            jsonDataIndex[index]['NameE'],
                                            jsonDataIndex[index]['Low'],
                                            jsonDataIndex[index]['High'],
                                            jsonDataIndex[index]
                                                ['CurrentValue'],
                                            jsonDataIndex[index]['NetChange'],
                                            jsonDataIndex[index]
                                                ['NetChangePerc'])
                                        : Indeies(
                                            jsonDataIndex[index]['NameA'],
                                            jsonDataIndex[index]['Low'],
                                            jsonDataIndex[index]['High'],
                                            jsonDataIndex[index]
                                                ['CurrentValue'],
                                            jsonDataIndex[index]['NetChange'],
                                            jsonDataIndex[index]
                                                ['NetChangePerc'])));
                      }))
              : Container(
                  child: FutureBuilder<List<ExchangeMArketIndexiesObject>>(
                    future: ExtangesMarkets().getExchangeSummaryIndecies(
                        market == '' ? StaticValues.market : market),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Column(
                          children: [
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                            Container(
                              child: Text(snapshot.error.toString()),
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
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  Indecies.nameA = snapshot
                                                      .data[index].nameA;
                                                  Indecies.currentValue =
                                                      snapshot.data[index]
                                                          .currentValue;
                                                  Indecies.nameE = snapshot
                                                      .data[index].nameE;
                                                  Indecies.exchangeID = snapshot
                                                      .data[index].exchangeID;
                                                  Indecies.netChange = snapshot
                                                      .data[index].netChange;
                                                  Indecies.netChangePerc =
                                                      snapshot.data[index]
                                                          .netChangePerc;
                                                  Indecies.turnOver = snapshot
                                                      .data[index].turnOver;
                                                  Indecies.volume = snapshot
                                                      .data[index].volume;
                                                  Indecies.sector = snapshot
                                                      .data[index].sector;
                                                  AppRoutes.push(
                                                      context, MainIndex());
                                                });
                                              },
                                              child: Localizations.localeOf(
                                                              context)
                                                          .languageCode ==
                                                      'en'
                                                  ? Indeies(
                                                      snapshot
                                                          .data[index].nameE,
                                                      snapshot.data[index].low,
                                                      snapshot.data[index].high,
                                                      snapshot.data[index]
                                                          .currentValue,
                                                      snapshot.data[index]
                                                          .netChange,
                                                      snapshot.data[index]
                                                          .netChangePerc)
                                                  : Indeies(
                                                      snapshot
                                                          .data[index].nameA,
                                                      snapshot.data[index].low,
                                                      snapshot.data[index].high,
                                                      snapshot.data[index]
                                                          .currentValue,
                                                      snapshot.data[index]
                                                          .netChange,
                                                      snapshot.data[index]
                                                          .netChangePerc))),
                                    )
                                  : Container(
                                      padding: EdgeInsets.only(
                                          left: 2, top: 5, bottom: 5),
                                      child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              Indecies.nameA =
                                                  snapshot.data[index].nameA;
                                              Indecies.currentValue = snapshot
                                                  .data[index].currentValue;
                                              Indecies.nameE =
                                                  snapshot.data[index].nameE;
                                              Indecies.exchangeID = snapshot
                                                  .data[index].exchangeID;
                                              Indecies.netChange = snapshot
                                                  .data[index].netChange;
                                              Indecies.netChangePerc = snapshot
                                                  .data[index].netChangePerc;
                                              Indecies.turnOver =
                                                  snapshot.data[index].turnOver;
                                              Indecies.volume =
                                                  snapshot.data[index].volume;
                                              Indecies.sector =
                                                  snapshot.data[index].sector;
                                              AppRoutes.push(
                                                  context, MainIndex());
                                            });
                                          },
                                          child: Localizations.localeOf(context)
                                                      .languageCode ==
                                                  'en'
                                              ? Indeies(
                                                  snapshot.data[index].nameE,
                                                  snapshot.data[index].low,
                                                  snapshot.data[index].high,
                                                  snapshot
                                                      .data[index].currentValue,
                                                  snapshot
                                                      .data[index].netChange,
                                                  snapshot.data[index]
                                                      .netChangePerc)
                                              : Indeies(
                                                  snapshot.data[index].nameA,
                                                  snapshot.data[index].low,
                                                  snapshot.data[index].high,
                                                  snapshot
                                                      .data[index].currentValue,
                                                  snapshot
                                                      .data[index].netChange,
                                                  snapshot.data[index]
                                                      .netChangePerc)));
                            });
                      }
                    },
                  ),
                ),
          Scroll()
        ],
      ),
    );
  }

  Future<void> initPlatformState() async {
    connection = SignalR(
        'http://109.107.237.83:8080/MobileServices/sr/signalr/hubs', "MyHub",
        headers: {'Cookie': '${Config.cookieSave}'},
        hubMethods: ['sendExchangeMarketObject'],
        statusChangeCallback: _onStatusChange,
        hubCallback: _onNewMessage);
    await connection.connect();
  }

  _onStatusChange(dynamic status) {
    if (mounted) {
      setState(() {
        _signalRStatus = status as String;
      });
      if (_signalRStatus == 'Connected') {
        MarketSummary.isConnectSignalR = true;
      } else {
        MarketSummary.isConnectSignalR = false;
      }
      Fluttertoast.showToast(msg: _signalRStatus);
      print('status connection');
      print(_signalRStatus);
    }
  }

  _onNewMessage(String methodName, dynamic message) {
    print('MethodName = $methodName, Message = $message');
    setState(() {
      jsonData = json.decode(message);
      MarketSummary.getMarketSummary = jsonData;
      for (jsondata in jsonData) {
        if (exchangeID == jsondata['ExchangeID']) {
          invokedMethods();
          exchangeID = jsondata['ExchangeID'];
          currentValue2 = jsondata['CurrentValue'];
          marketNameA = jsondata['NameA'];
          marketNameE = jsondata['NameE'];
          TurnOver = jsondata['TurnOver'];
          NetChange = jsondata['NetChange'];
          NetChangePerc = jsondata['NetChangePerc'];
          Volume = jsondata['Volume'];
          TotalExecuted = jsondata['TotalExecuted'];
          SymbolsTraded = jsondata['SymbolsTraded'];
          statusCodeExchnageMarket = jsondata['StatusCode'];
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
    this.jsonDataIndex = json.decode(resIndex);
    print('jsonIndexx');
    print(jsonDataIndex);
    this.jsonDataIndex = jsonDataIndex;
    final resGainers = await connection.invokeMethod('getTopGainerObject',
        arguments: ['$exchangeID', '$webcode']);
    MarketSummary.jsonDataGainers = json.decode(resGainers);
    print('jsonGainers');
    print(MarketSummary.jsonDataGainers);

    final resLossers = await connection.invokeMethod('getTopLoserObject',
        arguments: ['$exchangeID', '$webcode']);
    MarketSummary.jsonDataLossers = json.decode(resLossers);
    print('jsonLossers');
    print(MarketSummary.jsonDataLossers);

    final resActivites = await connection.invokeMethod('getMostActiveObject',
        arguments: ['$exchangeID', '$webcode']);
    MarketSummary.jsonDataActivites = json.decode(resActivites);

    print('jsonActivites');
    print(MarketSummary.jsonDataActivites);

    // final resNwes = await connection
    //     .invokeMethod('GetAllMarketNews', arguments: ['$exchangeID']);
    // MarketSummary.jsonDataNews = json.decode(resNwes);
    //
    // print('jsonNews');
    // print(MarketSummary.jsonDataNews);
    // await connection.connect();
  }

  Entries(e) {
    MapEntry entry = e.entries.firstWhere(
        (element) => element.key == 'Type' && element.value == 'MRS',
        orElse: () => null);
    if (entry != null) {
      print('Entry Key');
      print(entry.key);

      print('Entry Values');
      print(entry.value);
      // statusCompany = e['DescE'];
      // statusCompanyA = e['DescA'];
      // validity_code = e['ID'];
      // if (e['DescE'] == 'Day') _mySelection2 = e['DescE'];
      // Validaty.add(e['DescE']);
      if (statusCodeExchnageMarket == e['ID']) {
        statusCompany = e['DescE'];
        statusCompanyA = e['DescA'];
      }
      if (statusCompany == 'Continuous' && statusCompanyA == 'مستمر') {
        isOpen = true;
        isClose = false;
        isOther = false;
      } else if (statusCompany == 'Closed' && statusCompanyA == 'مغلق') {
        isClose = true;
        isOpen = false;
        isOther = false;
      } else {
        isOther = true;
        isClose = false;
        isOpen = false;
      }
    }
  }
}
