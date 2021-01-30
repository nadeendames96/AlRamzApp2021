import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformate.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/indecies/spacificformateindeces.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

class Indeies extends StatelessWidget {
  String indexName = '',
      low = '',
      high = '',
      currentValue = '',
      netChange = '',
      netChangePrec = '',
      sector = '';

  Indeies(this.indexName, this.low, this.high, this.currentValue,
      this.netChange, this.netChangePrec);

  @override
  Widget build(BuildContext context) {
    return Indecies(this.indexName, this.low, this.high, this.currentValue,
        this.netChange, this.netChangePrec);
  }

  Widget Indecies(
      indexName, low, high, currentValue, netChange, netChangePrec) {
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
                  indexName,
                  style: TextStyleApplied.Text,
                ),
                SizedBox(
                  height: Sizes.s10,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${getTranslated(context, 'low')}',
                          style: TextStyleApplied.Text,
                        ),
                        SizedBox(
                          width: Sizes.s4,
                        ),
                        SpacificFormate(
                          low,
                          valueText: TextStyleApplied.Text,
                        ),
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
                          width: Sizes.s4,
                        ),
                        SpacificFormate(
                          high,
                          valueText: TextStyleApplied.Text,
                        ),
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
