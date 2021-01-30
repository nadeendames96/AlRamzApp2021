import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

class SecondSecPort extends StatelessWidget {
  String closePrice = '', closeValue = '', cost = '', costValue = '';

  SecondSecPort(this.closePrice, this.closeValue, this.cost, this.costValue);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Text(
              getTranslated(context, 'closeprice'),
              style: TextStyleApplied.Text,
              textAlign: TextAlign.left,
            ),
            Text(closeValue, style: TextStyleApplied.Text),
          ],
        ),
        SizedBox(
          height: Sizes.s10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated(context, 'cost'),
              style: TextStyleApplied.Text,
              textAlign: TextAlign.left,
            ),
            Text(costValue, style: TextStyleApplied.Text),
          ],
        ),
      ],
    );
  }
}
