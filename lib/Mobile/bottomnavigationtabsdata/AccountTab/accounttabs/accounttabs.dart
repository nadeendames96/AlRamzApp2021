import 'dart:ui';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountchart/chart.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountportfilio/accountportfiolio.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountstatement/accountstatement.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountsummary/accountsummary.dart';
import 'package:alramzapp2021/Mobile/important/passwordscreen.dart';
import 'package:alramzapp2021/Mobile/screens/loginscreen_mobile.dart';
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
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountTabs extends StatefulWidget {
  @override
  _AccountTabsState createState() => _AccountTabsState();
}

class _AccountTabsState extends State<AccountTabs>
    with TickerProviderStateMixin {
  DateTime dateTime;
  TabController _tabController;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final String image;
  final double size;

  _AccountTabsState({this.image, this.size});

  @override
  Widget build(BuildContext context) {
    final List<Tab> myTabs = <Tab>[
      Tab(
        child: Text(
          getTranslated(context, 'summary'),
          style: TextStyleApplied.TextCustomTabs,
          textAlign: TextAlign.left,
        ),
      ),
      Tab(
          child: Text(
        getTranslated(context, 'statement'),
        style: TextStyleApplied.TextCustomTabs,
        textAlign: TextAlign.left,
      )),
      Tab(
        child: Text(
          getTranslated(context, 'portfolio'),
          style: TextStyleApplied.TextCustomTabs,
          textAlign: TextAlign.left,
        ),
      ),
      Tab(
          child: Text(
        getTranslated(context, 'charts'),
        style: TextStyleApplied.TextCustomTabs,
        textAlign: TextAlign.left,
      )),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            getTranslated(context, 'account'),
            style: TextStyleApplied.TextNormal,
          ),
          actions: <Widget>[
            Image(
              image: AssetImage(image ?? Assets.ramzicon),
              height: size ?? Sizes.s20,
              width: size ?? Sizes.s20,
              fit: BoxFit.contain,
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: AppColors.white,
                size: Sizes.s25,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: AppColors.white,
                size: Sizes.s25,
              ),
            ),
            Hero(
              tag: 'eifeifeuifyh',
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
          child: Container(
              // width: MediaQuery.of(context).size.width,
              child: Column(children: <Widget>[
            Container(
              // width: MediaQuery.of(context).size.width,
              child: TabBar(
                tabs: myTabs,
                labelStyle: TextStyleApplied.Text,
                unselectedLabelColor: AppColors.white,
                indicatorColor: AppColors.yellow,
                labelColor: AppColors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 5,
                controller: _tabController,
                isScrollable: true,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: Sizes.s1,
              child: Divider(),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: TabBarView(controller: _tabController, children: <Widget>[
                AccountSummary(),
                Statement('', ''),
                AccountPortifiolo(''),
                AccountCharts(),
              ]),
            ),
          ])),
        ),
      ),
    );
  }

  void choiceAction(Action) async {
    //    print("Mune PopUp");
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
