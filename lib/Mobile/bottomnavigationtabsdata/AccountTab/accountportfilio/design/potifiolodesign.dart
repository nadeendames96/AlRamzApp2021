import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountportfilio/design/secondsection.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountportfilio/design/thirdsection.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

import '../accountportfiolio.dart';
import '../select.dart';
import 'firstsection.dart';
import 'fourthsec.dart';

class PortfilioDesign extends StatelessWidget {
  String symbolName = '',
      accountType = '',
      shares = '',
      sharesValue = '',
      closePrice = '',
      closeValue = '',
      cost = '',
      costValue = '',
      marketValue = '',
      marketValueValue = '',
      volue1 = '',
      volue1Volue = '',
      pl = '',
      plVoluePres = '',
      plVolueVolue = '',
      value2 = '',
      value2Value = '';

  PortfilioDesign(
      this.symbolName,
      this.accountType,
      this.shares,
      this.sharesValue,
      this.closePrice,
      this.closeValue,
      this.cost,
      this.costValue,
      this.marketValue,
      this.marketValueValue,
      this.volue1,
      this.volue1Volue,
      this.pl,
      this.plVoluePres,
      this.plVolueVolue,
      this.value2,
      this.value2Value);

  @override
  Widget build(BuildContext context) {
    return Portfolio(
        this.symbolName,
        this.accountType,
        this.shares,
        this.sharesValue,
        this.closePrice,
        this.closeValue,
        this.cost,
        this.costValue,
        this.marketValue,
        this.marketValueValue,
        this.volue1,
        this.volue1Volue,
        this.pl,
        this.plVoluePres,
        this.plVolueVolue,
        this.value2,
        this.value2Value);
  }

  Widget Portfolio(
      symbolName,
      accountType,
      shares,
      sharesValue,
      closePrice,
      closeValue,
      cost,
      costValue,
      marketValue,
      marketValueValue,
      volue1,
      volue1Volue,
      pl,
      plVoluePres,
      plVolueVolue,
      value2,
      value2Value) {
    return SingleChildScrollView(
      child: Builder(
        builder: (context) {
          AccountPortifiolo.symbol = symbolName;
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FirstSecPort(symbolName, accountType, shares, sharesValue),
                SizedBox(
                  width: Sizes.s6,
                ),
                SecondSecPort(closePrice, closeValue, cost, costValue),
                SizedBox(
                  width: Sizes.s6,
                ),
                ThirdSecPort(
                    marketValue, marketValueValue, volue1, volue1Volue),
                SizedBox(
                  width: Sizes.s6,
                ),
                ForthSecPort(pl, plVoluePres, plVoluePres, value2, value2Value),
                Select(),
              ]);
        },
      ),
    );
  }
}
