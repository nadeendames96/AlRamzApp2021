import 'dart:convert';
import 'dart:ui';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformate.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/watchtabs/tabs.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/services/WatchServices/getWatchListBySymbol.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'nodata.dart';

class PriceDepth extends StatefulWidget {
  @override
  _PriceDepthState createState() => _PriceDepthState();
}

class _PriceDepthState extends State<PriceDepth> {
  String bidPrice = '', bidVolume = '';
  String offerPrice = '', offerVolume = '';
  var DepthByPrice = '';
  List bidDepth = [];
  List askDepth = [];
  bool isEmpty = false;
  List data = [];
  int timeout = 15;
  bool isContain = false;
  Future<GetWatchListBySymbol> getExchangeWatchListBySymbol(
      String symbol) async {
    String symbolformate = '';
    print(symbol.contains('*'));
    isContain = symbol.contains('*');
    if (isContain == true) {
      symbolformate = symbol.replaceAll('*', '%2A');
      print(symbolformate);
    } else {
      symbolformate = symbol;
      print(symbolformate);
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    print('${Config.GetMarketWatchListBySymbol}$webcode/$symbolformate');
    http.Response response = await http.get(
        '${Config.GetMarketWatchListBySymbol}$webcode/$symbolformate',
        headers: {
          'Cookie': '${Config.cookieSave}'
        }).timeout(Duration(seconds: timeout));
    var jsonDate = null;
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      setState(() {
        data = jsonDate;
        data.map((e) => Entries(e)).toList();
      });

      // for (var jsondata in jsonDate) {
      //   list.add(GetWatchListBySymbol.fromJson(jsondata));
      // }
    } else {
      print('cant able to fetch data from api');
    }
  }

  int totalbidDepth = 0;
  int totalaskDepth = 0;
  int totalbidQ = 0;
  int totalaskQ = 0;
  LocalStorage storage = LocalStorage('AlRamz');

  String symbol = '';
  String textWrong = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bidPrice = storage.getItem('depthprice');
    bidVolume = storage.getItem('bidvol');
    offerPrice = storage.getItem('offerprice');
    offerVolume = storage.getItem('offervol');
    DepthByPrice = storage.getItem('bidprice');
    if (DepthByPrice != null &&
        bidVolume != null &&
        bidPrice != null &&
        offerVolume != null &&
        offerPrice != null) {
      bidPrice = storage.getItem('depthprice');
      bidVolume = storage.getItem('bidvol');
      offerPrice = storage.getItem('offerprice');
      offerVolume = storage.getItem('offervol');
      DepthByPrice = storage.getItem('bidprice');
    } else {
      bidPrice = '0.0';
      bidVolume = '0.0';
      offerPrice = '0.0';
      offerVolume = '0.0';
      DepthByPrice = '0.0';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getExchangeWatchListBySymbol(WatchTabs.symbol),
        builder: (context, _) {
          return Container(
              child: isEmpty
                  ? NoData()
                  : Table(
                      border: TableBorder.all(
                          color: AppColors.light_blue.withOpacity(.2)),
                      textDirection: TextDirection.rtl,
                      children: [
                        TableRow(children: [
                          Text(
                            "#",
                            style: TextStyleApplied.Text,
                            textAlign: TextAlign.center,
                          ),
                          Text(getTranslated(context, 'offqty'),
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Text(getTranslated(context, 'offer'),
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Text(getTranslated(context, 'bid'),
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Text(getTranslated(context, 'bidqty'),
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Text("#",
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                        ]),
                        TableRow(children: [
                          Text(askDepth[1],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Container(
                            child: LiquidLinearProgressIndicator(
                                value: 10000,
                                valueColor: AlwaysStoppedAnimation(Colors.red),
                                backgroundColor: Colors.red,
                                direction: Axis.horizontal,
                                center: SpacificFormate(
                                  askDepth[2],
                                  valueText: TextStyleApplied.Text,
                                )),
                          ),
                          Text(askDepth[0],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Text(bidDepth[0],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Container(
                            child: LiquidLinearProgressIndicator(
                              value: 10000,
                              valueColor: AlwaysStoppedAnimation(Colors.green),
                              backgroundColor: Colors.green,
                              direction: Axis.horizontal,
                              center: SpacificFormate(
                                bidDepth[2],
                                valueText: TextStyleApplied.Text,
                              ),
                            ),
                          ),
                          Text(bidDepth[1],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                        ]),
                        TableRow(children: [
                          Text(askDepth[4],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Container(
                            child: LiquidLinearProgressIndicator(
                              value: 10000,
                              valueColor: AlwaysStoppedAnimation(Colors.red),
                              backgroundColor: Colors.red,
                              direction: Axis.horizontal,
                              center: SpacificFormate(askDepth[5],
                                  valueText: TextStyleApplied.Text),
                            ),
                          ),
                          Text(askDepth[3],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Text(bidDepth[3],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Container(
                            child: LiquidLinearProgressIndicator(
                              value: 10000,
                              valueColor: AlwaysStoppedAnimation(Colors.green),
                              backgroundColor: Colors.green,
                              direction: Axis.horizontal,
                              center: SpacificFormate(bidDepth[5],
                                  valueText: TextStyleApplied.Text),
                            ),
                          ),
                          Text(bidDepth[4],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                        ]),
                        TableRow(children: [
                          Text(askDepth[7],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Container(
                            child: LiquidLinearProgressIndicator(
                              value: double.parse(askDepth[8]),
                              valueColor: AlwaysStoppedAnimation(Colors.red),
                              backgroundColor: Colors.red,
                              direction: Axis.horizontal,
                              center: SpacificFormate(askDepth[8],
                                  valueText: TextStyleApplied.Text),
                            ),
                          ),
                          Text(askDepth[6],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Text(bidDepth[6],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Container(
                            child: LiquidLinearProgressIndicator(
                              value: 10000,
                              valueColor: AlwaysStoppedAnimation(Colors.green),
                              backgroundColor: Colors.green,
                              direction: Axis.horizontal,
                              center: SpacificFormate(bidDepth[8],
                                  valueText: TextStyleApplied.Text),
                            ),
                          ),
                          Text(bidDepth[7],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                        ]),
                        TableRow(children: [
                          Text(askDepth[10],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Container(
                            child: LiquidLinearProgressIndicator(
                              value: 10000,
                              valueColor: AlwaysStoppedAnimation(Colors.red),
                              backgroundColor: Colors.red,
                              direction: Axis.horizontal,
                              center: SpacificFormate(askDepth[11],
                                  valueText: TextStyleApplied.Text),
                            ),
                          ),
                          Text(askDepth[9],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Text(bidDepth[9],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Container(
                            child: LiquidLinearProgressIndicator(
                              value: 10000,
                              valueColor: AlwaysStoppedAnimation(Colors.green),
                              backgroundColor: Colors.green,
                              direction: Axis.horizontal,
                              center: SpacificFormate(bidDepth[11],
                                  valueText: TextStyleApplied.Text),
                            ),
                          ),
                          Text(bidDepth[10],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                        ]),
                        TableRow(children: [
                          Text(askDepth[13],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Container(
                            child: LiquidLinearProgressIndicator(
                              value: double.parse(askDepth[14]),
                              valueColor: AlwaysStoppedAnimation(Colors.red),
                              backgroundColor: Colors.red,
                              direction: Axis.horizontal,
                              center: SpacificFormate(askDepth[14],
                                  valueText: TextStyleApplied.Text),
                            ),
                          ),
                          Text(askDepth[12],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Text(bidDepth[12],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          Container(
                            child: LiquidLinearProgressIndicator(
                              value: 10000,
                              valueColor: AlwaysStoppedAnimation(Colors.green),
                              backgroundColor: Colors.green,
                              direction: Axis.horizontal,
                              center: SpacificFormate(bidDepth[14],
                                  valueText: TextStyleApplied.Text),
                            ),
                          ),
                          Text(bidDepth[13],
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                        ]),
                        TableRow(children: [
                          Text(totalaskDepth.toString(),
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                          SpacificFormate(totalaskQ.toString(),
                              valueText: TextStyleApplied.Text),
                          Text(''),
                          Text(''),
                          SpacificFormate(totalbidQ.toString(),
                              valueText: TextStyleApplied.Text),
                          Text(totalbidDepth.toString(),
                              style: TextStyleApplied.Text,
                              textAlign: TextAlign.center),
                        ]),
                      ],
                    ));
        });
  }

  Entries(e) {
    MapEntry entry = e.entries
        .firstWhere((element) => element.key == 'MBP', orElse: () => null);
    List mbp = [];
    print('emp is empty');
    print(e['MBP'].toString().isEmpty);

    if (e['MBP'].toString().isEmpty) {
      isEmpty = true;
      bidDepth = [];
      askDepth = [];
      totalbidDepth = 0;
      totalaskDepth = 0;
      totalbidQ = 0;
      totalaskQ = 0;
    } else {
      isEmpty = false;
      totalbidDepth = 0;
      totalaskDepth = 0;
      totalbidQ = 0;
      totalaskQ = 0;

      (mbp.add(e['MBP'].toString().split('>')));
    }
    if (mbp.isNotEmpty) {
      isEmpty = false;
      for (var i in mbp) {
        print(i);
        if (i[1] == 'D10') {
          if (i[5] == '0' && i[6] == '0') {
            isEmpty = true;
            bidDepth = [];
            askDepth = [];
            totalbidDepth = 0;
            totalaskDepth = 0;
            totalbidQ = 0;
            totalaskQ = 0;
          } else {
            isEmpty = false;
            totalbidDepth = 0;
            totalaskDepth = 0;
            totalbidQ = 0;
            totalaskQ = 0;

            bidDepth.add(i[6]);
            bidDepth.add(i[7]);
            bidDepth.add(i[8]);
            bidDepth.add(i[9]);
            bidDepth.add(i[10]);
            bidDepth.add(i[11]);
            bidDepth.add(i[12]);
            bidDepth.add(i[13]);
            bidDepth.add(i[14]);
            bidDepth.add(i[15]);
            bidDepth.add(i[16]);
            bidDepth.add(i[17]);
            bidDepth.add(i[18]);
            bidDepth.add(i[19]);
            bidDepth.add(i[20]);

            askDepth.add(i[22]);
            askDepth.add(i[23]);
            askDepth.add(i[24]);
            askDepth.add(i[25]);
            askDepth.add(i[26]);
            askDepth.add(i[27]);
            askDepth.add(i[28]);
            askDepth.add(i[29]);
            askDepth.add(i[30]);
            askDepth.add(i[31]);
            askDepth.add(i[32]);
            askDepth.add(i[33]);
            askDepth.add(i[34]);
            askDepth.add(i[35]);
            askDepth.add(i[36]);
            for (int i = 0; i < bidDepth.length; i++) {
              if (bidDepth[i] == '') {
                bidDepth[i] = '0';
                this.totalbidDepth = int.parse(bidDepth[i]);
              }
            }
            for (int i = 0; i < askDepth.length; i++) {
              if (askDepth[i] == '') {
                askDepth[i] = '0';
                this.totalaskDepth = int.parse(askDepth[i]);
              }
            }
            this.totalbidDepth = int.parse(bidDepth[1]) +
                int.parse(bidDepth[4]) +
                int.parse(bidDepth[7]) +
                int.parse(bidDepth[10]) +
                int.parse(bidDepth[13]);
            this.totalaskDepth = int.parse(askDepth[1]) +
                int.parse(askDepth[4]) +
                int.parse(askDepth[7]) +
                int.parse(askDepth[10]) +
                int.parse(askDepth[13]);
            this.totalbidQ = int.parse(bidDepth[2]) +
                int.parse(bidDepth[5]) +
                int.parse(bidDepth[8]) +
                int.parse(bidDepth[11]) +
                int.parse(bidDepth[14]);
            this.totalaskQ = int.parse(askDepth[2]) +
                int.parse(askDepth[5]) +
                int.parse(askDepth[8]) +
                int.parse(askDepth[11]) +
                int.parse(askDepth[14]);
          }
        } else {
          isEmpty = false;
          if (i[1] == '0' && i[2] == '0') {
            isEmpty = true;
            bidDepth = [];
            askDepth = [];
            totalbidDepth = 0;
            totalaskDepth = 0;
            totalbidQ = 0;
            totalaskQ = 0;
          } else {
            totalbidDepth = 0;
            totalaskDepth = 0;
            totalbidQ = 0;
            totalaskQ = 0;

            bidDepth.add(i[2]);
            bidDepth.add(i[3]);
            bidDepth.add(i[4]);
            bidDepth.add(i[5]);
            bidDepth.add(i[6]);
            bidDepth.add(i[7]);
            bidDepth.add(i[8]);
            bidDepth.add(i[9]);
            bidDepth.add(i[10]);
            bidDepth.add(i[11]);
            bidDepth.add(i[12]);
            bidDepth.add(i[13]);
            bidDepth.add(i[14]);
            bidDepth.add(i[15]);
            bidDepth.add(i[16]);

            askDepth.add(i[18]);
            askDepth.add(i[19]);
            askDepth.add(i[20]);
            askDepth.add(i[21]);
            askDepth.add(i[22]);
            askDepth.add(i[23]);
            askDepth.add(i[24]);
            askDepth.add(i[25]);
            askDepth.add(i[26]);
            askDepth.add(i[27]);
            askDepth.add(i[28]);
            askDepth.add(i[29]);
            askDepth.add(i[30]);
            askDepth.add(i[31]);
            askDepth.add(i[32]);
            for (int i = 0; i < bidDepth.length; i++) {
              if (bidDepth[i] == '') {
                bidDepth[i] = '0';
                this.totalbidDepth = int.parse(bidDepth[i]);
              }
            }
            for (int i = 0; i < askDepth.length; i++) {
              if (askDepth[i] == '') {
                askDepth[i] = '0';
                this.totalaskDepth = int.parse(askDepth[i]);
              }
            }
            this.totalbidDepth = int.parse(bidDepth[1]) +
                int.parse(bidDepth[4]) +
                int.parse(bidDepth[7]) +
                int.parse(bidDepth[10]) +
                int.parse(bidDepth[13]);
            this.totalaskDepth = int.parse(askDepth[1]) +
                int.parse(askDepth[4]) +
                int.parse(askDepth[7]) +
                int.parse(askDepth[10]) +
                int.parse(askDepth[13]);
            this.totalbidQ = int.parse(bidDepth[2]) +
                int.parse(bidDepth[5]) +
                int.parse(bidDepth[8]) +
                int.parse(bidDepth[11]) +
                int.parse(bidDepth[14]);
            this.totalaskQ = int.parse(askDepth[2]) +
                int.parse(askDepth[5]) +
                int.parse(askDepth[8]) +
                int.parse(askDepth[11]) +
                int.parse(askDepth[14]);
          }
        }
      }
    }
  }
}
