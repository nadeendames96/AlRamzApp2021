import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountpage/accountpage.dart';
import 'package:alramzapp2021/services/Accounts/getaccountsummary.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExcahngesAccounts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'accountinfo.dart';

class AccountSummary extends StatefulWidget {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('MMddyyyy000000');
  static String formatted = formatter.format(now);
  @override
  _AccountSummaryState createState() => _AccountSummaryState();
}

class _AccountSummaryState extends State<AccountSummary> {
  String clientID = AccountPage.clientID;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<GetAccountSummary>(
      future: ExchangesAccounts()
          .getExchangeSummaryByClientID(AccountSummary.formatted, clientID),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.buyPower == 'null') {
            snapshot.data.buyPower = '0';
          }
          if (snapshot.data.expectedProfitLoss == 'null') {
            snapshot.data.expectedProfitLoss = '0';
          }
          if (snapshot.data.remainingBalance == 'null') {
            snapshot.data.remainingBalance = '0';
          }
          if (snapshot.data.expectedProfitLoss == 'null') {
            snapshot.data.expectedProfitLoss = '0';
          }
          if (snapshot.data.realisedProfitLoss == 'null') {
            snapshot.data.realisedProfitLoss = '0';
          }
          if (snapshot.data.facilityAmount == 'null') {
            snapshot.data.facilityAmount = '0';
          }
          if (snapshot.data.holdingCost == 'null') {
            snapshot.data.holdingCost = '0';
          }
          if (snapshot.data.marketValue == 'null') {
            snapshot.data.marketValue = '0';
          }
          if (snapshot.data.netProfitLoss == 'null') {
            snapshot.data.netProfitLoss = '0';
          } // return Text('ok');
          return AccountInfo(
              snapshot.data.buyPower,
              snapshot.data.expectedProfitLoss,
              snapshot.data.remainingBalance,
              snapshot.data.realisedProfitLoss,
              snapshot.data.facilityAmount,
              snapshot.data.marketValue,
              snapshot.data.holdingCost,
              snapshot.data.netProfitLoss);
        } else {
          return AccountInfo('0', '0', '0', '0', '0', '0', '0', '0');
        }
      },
    ));
  }
}
