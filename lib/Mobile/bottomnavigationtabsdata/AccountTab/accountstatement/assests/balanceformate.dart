import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformate.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';

class Balance extends StatelessWidget {
  String balance = '0';

  Balance(this.balance);

  @override
  Widget build(BuildContext context) {
    return BalanceStatus(this.balance);
  }

  Widget BalanceStatus(balance) {
    if (double.parse(balance) > 0) {
      return SpacificFormate(
        balance.toString(),
        valueText: TextStyleApplied.TextSmallBlue,
      );
    } else if (double.parse(balance) < 0) {
      return SpacificFormate(
        balance.toString(),
        valueText: TextStyleApplied.TextSmallBlue,
      );
    } else {
      return SpacificFormate(
        balance.toString(),
        valueText: TextStyleApplied.TextSmallBlue,
      );
    }
  }
}
