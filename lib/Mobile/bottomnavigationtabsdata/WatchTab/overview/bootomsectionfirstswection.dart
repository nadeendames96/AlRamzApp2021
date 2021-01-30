import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/OrdersTab/placeorder/placeorder.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

class BootomSection extends StatefulWidget {
  static bool isBuy = true;
  static int currentValue = 1;
  @override
  _BootomSectionState createState() => _BootomSectionState();
}

class _BootomSectionState extends State<BootomSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: Sizes.s5),
            height: Sizes.s30,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.white),
              color: AppColors.lightgreen,
            ),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  BootomSection.currentValue = 1;
                  BootomSection.isBuy = true;
                  AppRoutes.push(context, PlaceOrder());
                });
              },
              child: Text(getTranslated(context, 'buy'),
                  style: TextStyleApplied.Text),
            ),
          ),
          Text(
            getTranslated(context, 'marketbyprice'),
            style: TextStyleApplied.Text,
          ),
          Container(
            height: Sizes.s30,
            margin: EdgeInsets.only(right: Sizes.s10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.white),
              color: AppColors.red,
            ),
            child: FlatButton(
              child: Text(getTranslated(context, 'sell'),
                  style: TextStyleApplied.Text),
              onPressed: () {
                setState(() {
                  BootomSection.currentValue = 2;
                  BootomSection.isBuy = false;
                  AppRoutes.push(context, PlaceOrder());
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
