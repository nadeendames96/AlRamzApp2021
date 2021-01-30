import 'dart:ui' as uii;

import 'package:alramzapp2021/services/MarektWServices/exchangemarketcharts_object.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/dates_formate.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatelessWidget {
  List dataSource = [];
  Chart({this.dataSource});
  var oldFormat = "MM-dd-yyyy h:mm:ss";

  @override
  Widget build(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'en'
        ? Directionality(
            textDirection: uii.TextDirection.ltr,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              tooltipBehavior: TooltipBehavior(enable: true),
              enableAxisAnimation: true,
              series: <ChartSeries>[
                AreaSeries<ExchangeMArketChartObject, dynamic>(
                  color: Colors.lightBlueAccent,
                  dataSource: dataSource,
                  xValueMapper: (ExchangeMArketChartObject Date, _) =>
                      formatDate(context, Date.DateT, oldFormat, "h:mm a"),
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
                  dataSource: dataSource,
                  xValueMapper: (ExchangeMArketChartObject Date, _) =>
                      Date.DateT.substring(11),
                  yValueMapper: (ExchangeMArketChartObject Close, _) =>
                      double.parse(Close.close),
                ),
              ],
            ),
          );
  }
}
