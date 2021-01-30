import 'package:flutter/material.dart';

import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamz/AlRamz2020/alramz/lib/styles/textstyle.dart';

class DMT extends StatelessWidget {
  String balance = '', dmt = '';
  DMT(this.balance, this.dmt);

  @override
  Widget build(BuildContext context) {
    return BalanceStatus(this.balance, this.dmt);
  }

  Widget BalanceStatus(balance, dmt) {
    if (double.parse(balance) > 0) {
      return Text(
        dmt.toString(),
        style: TextStyleApplied.TextSmallGreen,
      );
    } else if (double.parse(balance) < 0) {
      return Text(
        dmt.toString(),
        style: TextStyleApplied.TextSmallRed,
      );
    } else {
      return Text(
        dmt.toString(),
        style: TextStyleApplied.Text,
      );
    }
  }
}
