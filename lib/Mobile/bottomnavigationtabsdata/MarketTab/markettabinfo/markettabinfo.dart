import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformate.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/indecies/spacificformateindeces.dart';
import 'package:alramzapp2021/Mobile/lengthword/lengthword.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

class MarketTabInfo extends StatelessWidget {
  String indexName = '',
      fullName = '',
      low = '',
      high = '',
      lastTrades = '',
      netChange = '',
      netChangePrec = '',
      symbol = '';

  MarketTabInfo(this.symbol, this.fullName, this.low, this.high,
      this.lastTrades, this.netChange, this.netChangePrec);

  @override
  Widget build(BuildContext context) {
    return TabsInfo(this.symbol, this.fullName, this.low, this.high,
        this.lastTrades, this.netChange, this.netChangePrec);
  }

  Widget TabsInfo(
      symbol, fullname, low, high, currentValue, netChange, netChangePrec) {
    return Builder(builder: (context) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  symbol,
                  style: TextStyleApplied.Text,
                ),
                SizedBox(
                  height: Sizes.s5,
                ),
                LengthWord(fullName),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${getTranslated(context, 'low')}',
                          style: TextStyleApplied.Text,
                        ),
                        SizedBox(
                          width: Sizes.s2,
                        ),
                        SpacificFormate(low),
                      ],
                    ),
                    SizedBox(
                      width: FontSizes.s20,
                    ),
                    Row(
                      children: [
                        Text(
                          '${getTranslated(context, 'high')}',
                          style: TextStyleApplied.Text,
                        ),
                        SizedBox(
                          width: Sizes.s2,
                        ),
                        SpacificFormate(high),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SpacficTextColorIndex(currentValue, netChange, netChangePrec),
          ]);
    });
  }
}
