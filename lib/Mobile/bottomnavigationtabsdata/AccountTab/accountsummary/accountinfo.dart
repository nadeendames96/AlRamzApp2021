import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformate.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ns_utils/src.dart';

class AccountInfo extends StatelessWidget {
  String buyPower = '',
      expectedProfitLoss = '',
      remainingBalance = '',
      realisedProfitLoss = '',
      facilityAmount = '',
      marketValue,
      holdingCost = '',
      netProfitLoss = '';

  AccountInfo(
      this.buyPower,
      this.expectedProfitLoss,
      this.remainingBalance,
      this.realisedProfitLoss,
      this.facilityAmount,
      this.marketValue,
      this.holdingCost,
      this.netProfitLoss);

  @override
  Widget build(BuildContext context) {
    return summary(
        this.buyPower,
        this.expectedProfitLoss,
        this.remainingBalance,
        this.realisedProfitLoss,
        this.facilityAmount,
        this.marketValue,
        this.holdingCost,
        this.netProfitLoss);
  }

  Widget summary(
      buyPower,
      expectedProfitLoss,
      remainingBalance,
      realisedProfitLoss,
      facilityAmount,
      marketValue,
      holdingCost,
      netProfitLoss) {
    return Builder(builder: (context) {
      return Padding(
        padding: EdgeInsets.only(left: Sizes.s5, right: Sizes.s5),
        child: ListView(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(getTranslated(context, 'buypower'),
                  style: TextStyleApplied.Text),
              Row(
                children: [
                  SpacificFormate(
                    buyPower,
                    valueText: TextStyleApplied.Text,
                  ),
                  Text(' AED', style: TextStyleApplied.Text),
                ],
              )
            ]),
            Divider(
              color: AppColors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getTranslated(context, 'expectedpl'),
                    style: TextStyleApplied.Text),
                Text(expectedProfitLoss + ' AED', style: TextStyleApplied.Text),
              ],
            ),
            Divider(
              color: AppColors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getTranslated(context, 'availablecash'),
                    style: TextStyleApplied.Text),
                Text(remainingBalance + ' AED', style: TextStyleApplied.Text),
              ],
            ),
            Divider(
              color: AppColors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getTranslated(context, 'realizedpl'),
                    style: TextStyleApplied.Text),
                Text(realisedProfitLoss + ' AED', style: TextStyleApplied.Text),
              ],
            ),
            Divider(
              color: AppColors.white,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(getTranslated(context, 'facility'),
                  style: TextStyleApplied.Text),
              Row(
                children: [
                  SpacificFormate(
                    facilityAmount,
                    valueText: TextStyleApplied.TextSmallGreen,
                  ),
                  Text(' AED', style: TextStyleApplied.TextSmallGreen),
                ],
              ),
            ]),
            Divider(
              color: AppColors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getTranslated(context, 'holdingcost'),
                    style: TextStyleApplied.Text),
                Text(holdingCost + ' AED', style: TextStyleApplied.Text),
              ],
            ),
            Divider(
              color: AppColors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getTranslated(context, 'marketvalue'),
                    style: TextStyleApplied.Text),
                Row(
                  children: [
                    SpacificFormate(
                      marketValue,
                      valueText: TextStyleApplied.Text,
                    ),
                    Text(' AED', style: TextStyleApplied.Text),
                  ],
                )
              ],
            ),
            Divider(
              color: AppColors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getTranslated(context, 'netPortfolioValue'),
                    style: TextStyleApplied.Text),
                Text(netProfitLoss + ' AED', style: TextStyleApplied.Text),
              ],
            ),
          ],
        ),
      );
    });
  }
}
