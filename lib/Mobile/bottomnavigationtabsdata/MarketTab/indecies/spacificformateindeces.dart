import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformate.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

class SpacficTextColorIndex extends StatelessWidget {
  String currentValue = '', netChane = '', netChangePres = '';

  SpacficTextColorIndex(this.currentValue, this.netChane, this.netChangePres);

  Widget build(BuildContext context) {
    return CurrentValue(this.currentValue, this.netChane, this.netChangePres);
  }

  Widget CurrentValue(currentValue, netChange, netChangePrec) {
    if (double.parse(netChange) > 0.0) {
      return Builder(
        builder: (context) {
          return Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SpacificFormate(currentValue,
                      valueText: TextStyleApplied.TextSmallGreen),
                  SizedBox(
                    height: Sizes.s10,
                  ),
                  Text(
                    getTranslated(context, 'netchg') +
                        '+' +
                        netChange +
                        '(${netChangePrec}%)',
                    style: TextStyleApplied.Text,
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          );
        },
      );
    } else if (double.parse(netChange) < 0.0) {
      return Builder(builder: (context) {
        return Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SpacificFormate(currentValue,
                    valueText: TextStyleApplied.TextSmallRed),
                SizedBox(
                  height: Sizes.s10,
                ),
                Text(
                  getTranslated(context, 'netchg') +
                      netChange +
                      '(${netChangePrec}%)',
                  style: TextStyleApplied.Text,
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        );
      });
    } else {
      return Builder(builder: (context) {
        return Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SpacificFormate(currentValue, valueText: TextStyleApplied.Text),
                SizedBox(
                  height: Sizes.s10,
                ),
                Text(
                    getTranslated(context, 'netchg') +
                        netChange +
                        '(${netChangePrec}%)',
                    style: TextStyleApplied.Text),
              ],
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        );
      });
    }
  }
}
