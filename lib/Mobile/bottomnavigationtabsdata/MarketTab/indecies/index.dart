import 'dart:async';
import 'dart:convert';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/summary/firstsec.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_flutter/signalr_flutter.dart';

import 'indeciesdesign.dart';

class Indecies extends StatefulWidget {
  static String currentValue = '',
      exchangeID = '',
      exchangeNameEn = '',
      exchangeNameAr = '',
      netChange = '',
      netChangePerc = '',
      turnOver = '',
      volume = '',
      sector = '',
      nameE = '',
      nameA = '';

  @override
  _IndeciesState createState() => _IndeciesState();
}

class _IndeciesState extends State<Indecies> {
  LocalStorage storage = LocalStorage('AlRamz');
  String market = '';
  Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // _timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      //   setState(() {
      //     //  FirstSection().createState().invokedMethods();
      //     FirstSection.jsonDataIndex;
      //   });
      // });

      market = storage.getItem('market');
      if (market != null) {
        market = storage.getItem('market');
      } else {
        market = '';
      }
    });
  }

  SignalR connection;
  String _signalRStatus = 'Unknown';
  String exchangeID = '',
      indexNameE = '',
      indexNameA = '',
      lowIndex = '',
      hightIndex = '',
      currentValueIndex = '',
      netChangeIndex = '',
      netChangePrecIndex = '';
  List jsonData = [];
  bool isDivider = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: FirstSection.jsonDataIndex.length,
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
                                      FirstSection.jsonDataIndex[index]
                                          ['NameE'],
                                      FirstSection.jsonDataIndex[index]['Low'],
                                      FirstSection.jsonDataIndex[index]['High'],
                                      FirstSection.jsonDataIndex[index]
                                          ['CurrentValue'],
                                      FirstSection.jsonDataIndex[index]
                                          ['NetChange'],
                                      FirstSection.jsonDataIndex[index]
                                          ['NetChangePerc'])
                                  : Indeies(
                                      FirstSection.jsonDataIndex[index]
                                          ['NameA'],
                                      FirstSection.jsonDataIndex[index]['Low'],
                                      FirstSection.jsonDataIndex[index]['High'],
                                      FirstSection.jsonDataIndex[index]
                                          ['CurrentValue'],
                                      FirstSection.jsonDataIndex[index]
                                          ['NetChange'],
                                      FirstSection.jsonDataIndex[index]
                                          ['NetChangePerc']))),
                    )
                  : Container(
                      padding: EdgeInsets.only(left: 2, top: 5, bottom: 5),
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
                          child: Localizations.localeOf(context).languageCode ==
                                  'en'
                              ? Indeies(
                                  FirstSection.jsonDataIndex[index]['NameE'],
                                  FirstSection.jsonDataIndex[index]['Low'],
                                  FirstSection.jsonDataIndex[index]['High'],
                                  FirstSection.jsonDataIndex[index]
                                      ['CurrentValue'],
                                  FirstSection.jsonDataIndex[index]
                                      ['NetChange'],
                                  FirstSection.jsonDataIndex[index]
                                      ['NetChangePerc'])
                              : Indeies(
                                  FirstSection.jsonDataIndex[index]['NameA'],
                                  FirstSection.jsonDataIndex[index]['Low'],
                                  FirstSection.jsonDataIndex[index]['High'],
                                  FirstSection.jsonDataIndex[index]
                                      ['CurrentValue'],
                                  FirstSection.jsonDataIndex[index]
                                      ['NetChange'],
                                  FirstSection.jsonDataIndex[index]
                                      ['NetChangePerc'])));
            })
        // child: FutureBuilder<List<ExchangeMArketIndexiesObject>>(
        //   future: getExchangeSummaryIndecies(
        //       // market == '' ? StaticValues.market : market
        //       market),
        //   builder: (context, snapshot) {
        //     if (snapshot.data == null) {
        //       return Column(
        //         children: [
        //           Center(
        //             child: CircularProgressIndicator(),
        //           ),
        //           Container(
        //             child: Text(snapshot.error.toString()),
        //           )
        //         ],
        //       );
        //     } else {
        //       return ListView.builder(
        //           physics: NeverScrollableScrollPhysics(),
        //           shrinkWrap: true,
        //           itemCount: snapshot.data.length,
        //           itemBuilder: (context, index) {
        //             if (index % 2 == 0) {
        //               isDivider = true;
        //             } else {
        //               isDivider = false;
        //             }
        //             return isDivider
        //                 ? Container(
        //                     color: AppColors.black.withOpacity(.3),
        //                     child: Card(
        //                         child: InkWell(
        //                             onTap: () {
        //                               setState(() {
        //                                 Indecies.nameA =
        //                                     snapshot.data[index].nameA;
        //                                 Indecies.currentValue =
        //                                     snapshot.data[index].currentValue;
        //                                 Indecies.nameE =
        //                                     snapshot.data[index].nameE;
        //                                 Indecies.exchangeID =
        //                                     snapshot.data[index].exchangeID;
        //                                 Indecies.netChange =
        //                                     snapshot.data[index].netChange;
        //                                 Indecies.netChangePerc =
        //                                     snapshot.data[index].netChangePerc;
        //                                 Indecies.turnOver =
        //                                     snapshot.data[index].turnOver;
        //                                 Indecies.volume =
        //                                     snapshot.data[index].volume;
        //                                 Indecies.sector =
        //                                     snapshot.data[index].sector;
        //                                 AppRoutes.push(context, MainIndex());
        //                               });
        //                             },
        //                             child: Localizations.localeOf(context)
        //                                         .languageCode ==
        //                                     'en'
        //                                 ? Indeies(
        //                                     snapshot.data[index].nameE,
        //                                     snapshot.data[index].low,
        //                                     snapshot.data[index].high,
        //                                     snapshot.data[index].currentValue,
        //                                     snapshot.data[index].netChange,
        //                                     snapshot.data[index].netChangePerc)
        //                                 : Indeies(
        //                                     snapshot.data[index].nameA,
        //                                     snapshot.data[index].low,
        //                                     snapshot.data[index].high,
        //                                     snapshot.data[index].currentValue,
        //                                     snapshot.data[index].netChange,
        //                                     snapshot.data[index].netChangePerc))),
        //                   )
        //                 : Container(
        //                     padding: EdgeInsets.only(left: 2, top: 5, bottom: 5),
        //                     child: InkWell(
        //                         onTap: () {
        //                           setState(() {
        //                             Indecies.nameA = snapshot.data[index].nameA;
        //                             Indecies.currentValue =
        //                                 snapshot.data[index].currentValue;
        //                             Indecies.nameE = snapshot.data[index].nameE;
        //                             Indecies.exchangeID =
        //                                 snapshot.data[index].exchangeID;
        //                             Indecies.netChange =
        //                                 snapshot.data[index].netChange;
        //                             Indecies.netChangePerc =
        //                                 snapshot.data[index].netChangePerc;
        //                             Indecies.turnOver =
        //                                 snapshot.data[index].turnOver;
        //                             Indecies.volume = snapshot.data[index].volume;
        //                             Indecies.sector = snapshot.data[index].sector;
        //                             AppRoutes.push(context, MainIndex());
        //                           });
        //                         },
        //                         child: Localizations.localeOf(context)
        //                                     .languageCode ==
        //                                 'en'
        //                             ? Indeies(
        //                                 snapshot.data[index].nameE,
        //                                 snapshot.data[index].low,
        //                                 snapshot.data[index].high,
        //                                 snapshot.data[index].currentValue,
        //                                 snapshot.data[index].netChange,
        //                                 snapshot.data[index].netChangePerc)
        //                             : Indeies(
        //                                 snapshot.data[index].nameA,
        //                                 snapshot.data[index].low,
        //                                 snapshot.data[index].high,
        //                                 snapshot.data[index].currentValue,
        //                                 snapshot.data[index].netChange,
        //                                 snapshot.data[index].netChangePerc)));
        //           });
        //     }
        //   },
        // ),
        );
  }

  Future getExchangeSummaryIndecies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocalStorage _storage = LocalStorage('AlRamz');
    String webcode =
        prefs.getString('webcode'); // jsonDate = json.decode(response.body);

    // List<ExchangeMArketIndexiesObject> list = [];
    connection = SignalR(
      'http://109.107.237.83:8080/MobileServices/sr/signalr/hubs',
      "MyHub",
      headers: {'Cookie': '${Config.cookieSave}'},
      statusChangeCallback: _onStatusChange,
    );
    final res = await connection.invokeMethod('getMarketIndexObject',
        arguments: ['$market', '$webcode']);
    connection.connect();
    jsonData = json.decode(res);
    print('result');
    print(res);
    // return list;
  }

  _onStatusChange(dynamic status) {
    if (mounted) {
      setState(() {
        _signalRStatus = status as String;
      });
      Fluttertoast.showToast(msg: _signalRStatus);
    }
  }
}
