import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

class ThirdSecPort extends StatelessWidget {
  String marketValue = '', marketValueValue = '', volue1 = '', volue1Volue = '';

  ThirdSecPort(
      this.marketValue, this.marketValueValue, this.volue1, this.volue1Volue);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Text(
              getTranslated(context, 'marketvalue'),
              style: TextStyleApplied.Text,
              textAlign: TextAlign.left,
            ),
            Text(marketValueValue, style: TextStyleApplied.Text),
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
              getTranslated(context, 'value'),
              style: TextStyleApplied.Text,
              textAlign: TextAlign.left,
            ),
            Text(volue1Volue, style: TextStyleApplied.Text),
          ],
        ),
      ],
    );
  }
}
