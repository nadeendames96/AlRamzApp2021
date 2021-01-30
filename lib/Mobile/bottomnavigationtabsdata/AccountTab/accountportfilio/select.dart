import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountpage/accountpage.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/OrdersTab/placeorder/placeorder.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/overview/bootomsectionfirstswection.dart';
import 'package:alramzapp2021/menues/menuportifilo.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

import 'accountportfiolio.dart';

class Select extends StatefulWidget {
  @override
  _SelectState createState() => _SelectState();
}

class _SelectState extends State<Select> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'AppStrings.heroMenuPopup55434',
      child: PopupMenuButton<String>(
        offset: Offset(0, 100),
        icon: IconButton(
          icon: Icon(
            Icons.more_vert,
            size: Sizes.s25,
          ),
          color: AppColors.white,
        ),
        itemBuilder: (BuildContext context) {
          return MenuPopUpPortfilio.choice.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(
                choice,
                style: TextStyleApplied.Text,
              ),
            );
          }).toList();
        },
        onSelected: choiceAction,
      ),
    );
  }

  choiceAction(String choice) {
    if (choice == MenuPopUpPortfilio.buy) {
      setState(() {
        PlaceOrder.select = AccountPage.accountName;
        PlaceOrder.symbol.text = AccountPortifiolo.symbol;
        BootomSection.currentValue = 1;
        BootomSection.isBuy = true;
        AppRoutes.push(context, PlaceOrder());
      });
    } else if (choice == MenuPopUpPortfilio.sell) {
      setState(() {
        PlaceOrder.select = AccountPage.accountName;
        PlaceOrder.symbol.text = AccountPortifiolo.symbol;
        BootomSection.currentValue = 2;
        BootomSection.isBuy = false;
        AppRoutes.push(context, PlaceOrder());
      });
    }
  }
}
