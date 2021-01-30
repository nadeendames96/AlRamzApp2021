import 'dart:ui' as uii;

import 'package:alramzapp2021/services/MarektWServices/exchangemarketcharts_object.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExtangeMarkets.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/dates_formate.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MainChart extends StatefulWidget {
  @override
  _MainChartState createState() => _MainChartState();
}

class _MainChartState extends State<MainChart> {
  String market = '';
  var oldFormat = "MM-dd-yyyy h:mm:ss";
  LocalStorage _storage = LocalStorage('AlRamz');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      market = _storage.getItem('market');
      if (market != null) {
        market = _storage.getItem('market');
      } else {
        market = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ExtangesMarkets().getChartsSummaryByID(
          // market == '' ? StaticValues.market : market
          'DFM'),
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
                        xValueMapper: (ExchangeMArketChartObject Date, _) =>
                            formatDate(
                                context, Date.DateT, oldFormat, "h:mm a"),
                        yValueMapper: (ExchangeMArketChartObject Close, _) =>
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
                        xValueMapper: (ExchangeMArketChartObject Date, _) =>
                            Date.DateT,
                        yValueMapper: (ExchangeMArketChartObject Close, _) =>
                            double.parse(Close.close),
                      ),
                    ],
                  ),
                );
        }
      },
    );
  }
}
