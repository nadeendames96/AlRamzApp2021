import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/watchtabs/tabs.dart';
import 'package:alramzapp2021/services/WatchServices/watchessymbolchart.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExchangeWatches.dart';
import 'package:alramzapp2021/statics_value/staticvalues.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SymbolChart extends StatefulWidget {
  @override
  _SymbolChartState createState() => _SymbolChartState();
}

class _SymbolChartState extends State<SymbolChart> {
  String MArket = '';
  String bidPrice = WatchTabs.bidprice, updateDate = WatchTabs.updatedate;
  String market = '';
  String Symbol = WatchTabs.symbol;
  LocalStorage storage = LocalStorage('AlRamz');
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: ExchangesWatches().getChartsWatchesBySymbol(
            Symbol, market == '' ? StaticValues.market : market),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Column(
              children: [
                CircularProgressIndicator(),
                Container(),
              ],
            );
          } else {
            return Center(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(),
                series: <ChartSeries>[
                  AreaSeries<GetSymbolDialyChartObject, dynamic>(
                    opacity: 0.38,
                    color: Colors.lightBlueAccent,
                    dataSource: snapshot.data,
                    xValueMapper: (GetSymbolDialyChartObject Date, _) =>
                        Date.date,
                    yValueMapper: (GetSymbolDialyChartObject Close, _) =>
                        double.parse(Close.close),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
