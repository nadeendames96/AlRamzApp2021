import 'dart:ui';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/Alearts/aleart.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/formate/spacificformate.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/mtrades/mtrade.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/orders/orders.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/overview/overview.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/symbolchart/symbolchart.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/trades/trades.dart';
import 'package:alramzapp2021/Mobile/important/passwordscreen.dart';
import 'package:alramzapp2021/Mobile/screens/loginscreen_mobile.dart';
import 'package:alramzapp2021/Mobile/transfetaccount/transferaccount.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/menues/menupopup.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/settings/settings.dart';
import 'package:alramzapp2021/utils/assets.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:ns_utils/src.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchTabs extends StatefulWidget {
  static String symbol = '',
      lasttrade = '',
      netchangeprec = '',
      bidprice = '',
      updatedate = '',
      offerprice = '',
      offervol = '',
      bidvol = '',
      limitup = '',
      limitdn = '',
      buypower = '',
      ownershr = '',
      cash = '',
      sellorder = '',
      buyorder = '';

  static double netchange = 0.0;
  @override
  _WatchTabsState createState() => _WatchTabsState();
}

class _WatchTabsState extends State<WatchTabs> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static List<Tab> myTabs = <Tab>[];
  final String image;
  final double size;

  _WatchTabsState({this.image, this.size});

  @override
  Widget build(BuildContext context) {
    myTabs = <Tab>[
      Tab(text: getTranslated(context, 'overview')),
      Tab(text: getTranslated(context, 'charts')),
      Tab(text: getTranslated(context, 'orders')),
      Tab(text: getTranslated(context, 'trades')),
      Tab(text: getTranslated(context, 'TodayTrades')),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            getTranslated(context, 'quotedetails'),
            style: TextStyleApplied.Text,
          ),
          actions: [
            Image(
              image: AssetImage(image ?? Assets.ramzicon),
              height: size ?? Sizes.s20,
              width: size ?? Sizes.s20,
              fit: BoxFit.contain,
            ),
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: AppColors.white,
              ),
            ),
            Hero(
              tag: 'kjifueifueif',
              child: PopupMenuButton<String>(
                offset: Offset(0, 100),
                onSelected: choiceAction,
                icon: Icon(
                  Icons.menu,
                  size: Sizes.s25,
                ),
                itemBuilder: (BuildContext context) {
                  return MenuPopUpMobile.choice.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColors.black.withOpacity(.3),
                child: RaisedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.only(left: Sizes.s5, right: Sizes.s10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          WatchTabs.symbol,
                          style: TextStyleApplied.Text,
                        ),
                        SpacficTextColor(
                            WatchTabs.lasttrade,
                            WatchTabs.netchange.toString(),
                            WatchTabs.netchangeprec),
                      ],
                    ),
                  ),
                ),
              ),
              Tabs()
            ],
          ),
        ),
      ),
    );
  }

  Widget Tabs() {
    return Container(
        // width: MediaQuery.of(context).size.width,
        child: Column(children: <Widget>[
      Container(
        // width: MediaQuery.of(context).size.width,
        child: TabBar(
          tabs: myTabs,
          unselectedLabelColor: AppColors.white,
          indicatorColor: AppColors.yellow,
          labelColor: AppColors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          indicatorWeight: 5,
          controller: _tabController,
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: Sizes.s1,
        child: Divider(),
      ),
      Container(
        height: MediaQuery.of(context).size.height / 1.50,
        width: MediaQuery.of(context).size.width,
        child: TabBarView(controller: _tabController, children: <Widget>[
          Container(
              child: Container(
            child: Overview(),
          )),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: SymbolChart(),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Orders(),
          ),
          Container(
            child: WatchTrades(),
          ),
          Container(child: WatchMTrades()),
        ]),
      ),
    ]));
  }

  void choiceAction(Action) async {
    //    print("Mune PopUp");
    if (Action == MenuPopUpMobile.aleart) {
      AppRoutes.push(context, AlertScreen());
    }
    if (Action == MenuPopUpMobile.transfer_account) {
      AppRoutes.push(context, TransferAmount());
    }
    if (Action == MenuPopUpMobile.change_password) {
      AppRoutes.push(context, Changepassword());
    } else if (Action == MenuPopUpMobile.settings) {
      AppRoutes.push(context, Settings());
    } else if (Action == MenuPopUpMobile.sign_out) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String webcode = prefs.getString('webcode');
      http.Response response = await http.post(
        '${Config.signout}$webcode',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: null,
      );
      if (response.statusCode == 200) {
        Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
        prefs.clear();
        prefs.commit();
      } else {
        throw Exception('cant sign out by api');
      }
    }
  }
}
