import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformate.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

class SpacficTextColor extends StatelessWidget {
  String currentValue = '', netChane = '', netChangePres = '';

  SpacficTextColor(this.currentValue, this.netChane, this.netChangePres);

  Widget build(BuildContext context) {
    return CurrentValue(this.currentValue, this.netChane, this.netChangePres);
  }

  Widget CurrentValue(currentValue, netChange, netChangePrec) {
    if (double.parse(netChange) > 0.0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpacificFormate(currentValue,
              valueText: TextStyleApplied.TextLargeGreen),
          SizedBox(
            width: Sizes.s5,
          ),
          Column(
            children: [
              Text(
                '+' + netChange,
                style: TextStyleApplied.TextSmallGreen,
              ),
              Row(
                children: [
                  Text(netChangePrec, style: TextStyleApplied.TextSmallGreen),
                  Text(
                    '%',
                    style: TextStyleApplied.Text,
                  ),
                ],
              )
            ],
          )
        ],
      );
    } else if (double.parse(netChange) < 0.0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpacificFormate(currentValue,
              valueText: TextStyleApplied.TextLargeRed),
          SizedBox(
            width: Sizes.s5,
          ),
          Column(
            children: [
              Text(
                netChange,
                style: TextStyleApplied.TextSmallRed,
              ),
              Row(
                children: [
                  Text(netChangePrec, style: TextStyleApplied.TextSmallRed),
                  Text(
                    '%',
                    style: TextStyleApplied.Text,
                  ),
                ],
              )
            ],
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpacificFormate(currentValue, valueText: TextStyleApplied.TextLarge),
          SizedBox(
            width: Sizes.s5,
          ),
          Column(
            children: [
              Text(netChange, style: TextStyleApplied.Text),
              Row(
                children: [
                  Text(netChangePrec, style: TextStyleApplied.Text),
                  Text(
                    '%',
                    style: TextStyleApplied.Text,
                  ),
                ],
              )
            ],
          )
        ],
      );
    }
  }
}
