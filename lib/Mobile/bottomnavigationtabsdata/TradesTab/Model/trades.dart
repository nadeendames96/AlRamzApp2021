import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/Alearts/aleart.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/TradesTab/tradessearch/search.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/orders/orderinfo.dart';
import 'package:alramzapp2021/Mobile/important/passwordscreen.dart';
import 'package:alramzapp2021/Mobile/screens/loginscreen_mobile.dart';
import 'package:alramzapp2021/Mobile/transfetaccount/transferaccount.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/menues/menupopup.dart';
import 'package:alramzapp2021/services/TradeService/tradeObject.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExchangeTrades.dart';
import 'package:alramzapp2021/settings/settings.dart';
import 'package:alramzapp2021/utils/assets.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TradesTab extends StatefulWidget {
  @override
  _TradesTabState createState() => _TradesTabState();
}

class _TradesTabState extends State<TradesTab> {
  final String image;
  final double size;

  _TradesTabState({this.image, this.size});
  bool isDivider = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          getTranslated(context, 'trades'),
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
            tag: 'mcndfjkdfidjf',
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
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(width: Sizes.s5),
                      FlatButton(
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.search,
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              getTranslated(context, 'searchtrades'),
                              style: TextStyleApplied.Text,
                            )
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            AppRoutes.push(context, SearchTrade());
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Divider(
                    color: AppColors.white,
                  ),
                ),
                Container(
                    child: FutureBuilder<List<TradeObject>>(
                  future: ExchangeTrades()
                      .getTrades(Config.clientID, Config.orderId),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Column(
                        children: [
                          CircularProgressIndicator(),
                          Container(
                            child: Text(getTranslated(context, 'nodata')),
                          )
                        ],
                      );
                    } else {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index % 2 == 0) {
                            isDivider = true;
                          } else {
                            isDivider = false;
                          }
                          return isDivider
                              ? Container(
                                  color: AppColors.black.withOpacity(.3),
                                  padding: EdgeInsets.only(
                                      left: Sizes.s2,
                                      top: Sizes.s2,
                                      bottom: Sizes.s2),
                                  child: Card(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {});
                                      },
                                      child: OrderInfo(
                                          snapshot.data[index].symbol,
                                          '',
                                          snapshot.data[index].qTY,
                                          snapshot.data[index].price,
                                          snapshot.data[index].tradeValue,
                                          snapshot.data[index].clientID,
                                          ''),
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.only(
                                      left: Sizes.s2,
                                      bottom: Sizes.s2,
                                      top: Sizes.s2),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {});
                                    },
                                    child: OrderInfo(
                                        snapshot.data[index].symbol,
                                        '',
                                        snapshot.data[index].qTY,
                                        snapshot.data[index].price,
                                        snapshot.data[index].tradeValue,
                                        snapshot.data[index].clientID,
                                        ''),
                                  ),
                                );
                        },
                      );
                    }
                  },
                )),
                SizedBox(
                  height: Sizes.s30,
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(getTranslated(context, 'totalbuy'),
                                  style: TextStyleApplied.Text),
                              Text(" 0", style: TextStyleApplied.Text)
                            ],
                          ),
                          Row(
                            children: [
                              Text(getTranslated(context, 'value'),
                                  style: TextStyleApplied.Text),
                              Text(" 0.000", style: TextStyleApplied.Text)
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: Sizes.s80,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(getTranslated(context, 'totalsell'),
                                  style: TextStyleApplied.Text),
                              Text(" 0", style: TextStyleApplied.Text)
                            ],
                          ),
                          Row(
                            children: [
                              Text(getTranslated(context, 'value'),
                                  style: TextStyleApplied.Text),
                              Text(" 0.000", style: TextStyleApplied.Text)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        //
      ),
    );
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
