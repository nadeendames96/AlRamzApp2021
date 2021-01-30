import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountpage/accountpage.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountsummary/accountsummary.dart';
import 'package:alramzapp2021/services/Accounts/accountportofiolo_object.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExcahngesAccounts.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AccountCharts extends StatefulWidget {
  @override
  _AccountChartsState createState() => _AccountChartsState();
}

class _AccountChartsState extends State<AccountCharts> {
  String clientID = AccountPage.clientID;
  String date = AccountSummary.formatted;
  String mainClientID = AccountPage.mainClintID;

  @override
  Widget build(BuildContext context) {
    // return  _getDefaultPieChart();
    return Container(
      child: FutureBuilder<List<AccountsPortofioloObject>>(
        future:
            ExchangesAccounts().AccountPortfiolo(mainClientID, clientID, date),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          } else {
            return Container(
              child: SfCircularChart(
                  legend: Legend(isVisible: true),
                  series: <PieSeries<AccountsPortofioloObject, String>>[
                    PieSeries<AccountsPortofioloObject, String>(
                      radius: '100%',
                      dataSource: snapshot.data,
                      xValueMapper: (AccountsPortofioloObject data, _) =>
                          data.qty.toString(),
                      yValueMapper: (AccountsPortofioloObject data, _) =>
                          data.pCost,
                      dataLabelMapper: (AccountsPortofioloObject data, _) =>
                          data.symbol + ' (${data.pCost.toString()})',
                      startAngle: 90,
                      endAngle: 90,
                      enableSmartLabels: true,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    )
                  ]),
            );
          }
        },
      ),
    );
  }
}
