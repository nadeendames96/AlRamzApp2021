import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:flutter/material.dart';

import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamz/AlRamz2020/alramz/lib/styles/textstyle.dart';

class DetermineType extends StatelessWidget {
  String orderType = '';

  DetermineType(this.orderType);

  @override
  Widget build(BuildContext context) {
    return determineType(this.orderType);
  }

  determineType(String ordertype) {
    if (orderType == 'B') {
      return Builder(builder: (context) {
        return Text(
          getTranslated(context, 'buy'),
          style: TextStyleApplied.TextSmallGreen,
        );
      });
    } else if (orderType == 'S') {
      return Builder(builder: (context) {
        return Text(
          getTranslated(context, 'sell'),
          style: TextStyleApplied.TextSmallRed,
        );
      });
    }
  }
}
