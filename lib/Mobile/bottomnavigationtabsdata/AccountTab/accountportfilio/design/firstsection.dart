import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

class FirstSecPort extends StatelessWidget {
  String symbolName = '', accountType = '', shares = '', sharesValue = '';

  FirstSecPort(
      this.symbolName, this.accountType, this.shares, this.sharesValue);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              symbolName,
              style: TextStyleApplied.Text,
              textAlign: TextAlign.left,
            ),
            Text(accountType, style: TextStyleApplied.Text),
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
              getTranslated(context, 'shares'),
              style: TextStyleApplied.Text,
              textAlign: TextAlign.left,
            ),
            Text(sharesValue, style: TextStyleApplied.Text),
          ],
        ),
      ],
    );
  }
}
