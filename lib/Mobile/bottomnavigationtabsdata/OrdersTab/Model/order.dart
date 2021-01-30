import 'dart:ui';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/Alearts/aleart.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/OrdersTab/orderlist/orderlist.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/OrdersTab/placeorder/placeorder.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/OrdersTab/searchorder/search.dart';
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
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderTab extends StatefulWidget {
  static String symbol = '',
      exchangeID = '',
      orderId = '',
      accountId = '',
      account = '',
      type = '',
      quantity = '',
      price = '',
      validity = '',
      date = '',
      remaining_quan = '',
      avg_ex_price = '',
      status = '',
      reason = '',
      min_fill = '',
      visible_quan = '',
      remark = '',
      totalVolume = '',
      origin = '',
      nin = '';
  @override
  _OrderTabState createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab> {
  final String image;
  final double size;

  _OrderTabState({this.image, this.size});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            getTranslated(context, 'orders'),
            style: TextStyleApplied.Text,
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
                Icons.notifications,
                color: AppColors.white,
                size: Sizes.s25,
              ),
            ),
            Hero(
              tag: 'jkdcdiojdkfjf',
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
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(),
                    FlatButton(
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.add_shopping_cart,
                              color: AppColors.white,
                            ),
                          ),
                          Text(
                            getTranslated(context, 'placeorder'),
                            style: TextStyleApplied.Text,
                          )
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          AppRoutes.push(context, PlaceOrder());
                        });
                      },
                    ),
                    FlatButton(
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              color: AppColors.white,
                            ),
                          ),
                          Text(getTranslated(context, 'searchorders'),
                              style: TextStyleApplied.Text)
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          AppRoutes.push(context, SearchOrder());
                        });
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                color: AppColors.light_blue,
              ),
              OrderList()
            ],
          ),
        ));
  }

  void choiceAction(Action) async {
    //    print("Mune PopUp");
    if (Action == MenuPopUpMobile.change_password) {
      AppRoutes.push(context, Changepassword());
    } else if (Action == MenuPopUpMobile.settings) {
      AppRoutes.push(context, Settings());
    } else if (Action == MenuPopUpMobile.aleart) {
      AppRoutes.push(context, AlertScreen());
    } else if (Action == MenuPopUpMobile.transfer_account) {
      AppRoutes.push(context, TransferAmount());
    } else if (Action == MenuPopUpMobile.sign_out) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String webcode = prefs.getString('webcode');
      prefs.clear();
      prefs.commit();
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
      } else {
        throw Exception('cant sign out by api');
      }
    }
  }
}
