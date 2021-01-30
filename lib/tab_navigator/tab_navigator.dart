import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/Model/account.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/Models/marketmodel.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/OrdersTab/Model/order.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/TradesTab/Model/trades.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/Models/watchmodel.dart';
import 'package:flutter/material.dart';

import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamz/AlRamz2020/alramz/lib/utils/strings.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  TabNavigator({this.navigatorKey, this.tabItem});

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (tabItem == AppStrings.appBarTitleMarket) {
      child = Container(
        child: MarketModel(),
      );
    } else if (tabItem == AppStrings.watch) {
      child = Container(
        child: WatchModel(),
      );
    } else if (tabItem == AppStrings.appBarTitleOrders) {
      child = Container(
        child: OrderTab(),
      );
      // OrderTab();
    } else if (tabItem == AppStrings.trades) {
      child = Container(child: TradesTab());
      // TradesTab();
    } else if (tabItem == AppStrings.appBarTitleAccounts) {
      child = Container(child: AccountTab());
      // AccountTabs();
    }
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
