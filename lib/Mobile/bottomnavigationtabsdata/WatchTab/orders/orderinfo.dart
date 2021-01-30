import 'package:alramzapp2021/determinetype/determinetypes.dart';
import 'package:alramzapp2021/determinetype/status.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/menues/menupoporder.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ns_utils/utils/sizes.dart';

class OrderInfo extends StatelessWidget {
  String symbolName,
      orderType,
      currentValue,
      netChange,
      status,
      account,
      reason;

  OrderInfo(this.symbolName, this.orderType, this.currentValue, this.netChange,
      this.status, this.account, this.reason);

  @override
  Widget build(BuildContext context) {
    return OrdersInfo(this.symbolName, this.orderType, this.currentValue,
        this.netChange, this.status, this.account, this.reason);
  }

  Widget OrdersInfo(
      symbolName, orderType, currentValue, netChange, status, account, reason) {
    return Builder(builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  symbolName,
                  style: TextStyleApplied.Text,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: Sizes.s3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetermineType(orderType == '' ? 'B' : orderType),
                    SizedBox(
                      width: Sizes.s20,
                    ),
                    Text(
                      currentValue,
                      style: TextStyleApplied.Text,
                    ),
                    SizedBox(
                      width: Sizes.s10,
                    ),
                    Text(
                      (netChange),
                      style: TextStyleApplied.Text,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              width: Sizes.s20,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Status(status,
                        style: orderType == 'B'
                            ? TextStyleApplied.TextSmallGreen
                            : TextStyleApplied.TextSmallRed),
                    Text(account, style: TextStyleApplied.Text),
                  ],
                ),
              ],
            ),
          ]),
          Row(
            children: [
              Text(
                getTranslated(context, 'reason'),
                style: TextStyleApplied.Text,
                textAlign: TextAlign.start,
              ),
              Text(reason, style: TextStyleApplied.TextReason),
            ],
          ),
        ],
      );
    });
  }

  choiceAction(String choice) {
    return Builder(builder: (context) {
      // ignore: missing_return
      if (choice == MenuPopUpOrder.modifier) {
        // AppRoutes.push(context, PlaceOrder());
      }
      // ignore: missing_return
      else if (choice == MenuPopUpOrder.cancel) {
        // AppRoutes.push(context, CancelOrder());
      }
    });
  }
}
