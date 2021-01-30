import 'package:alramzapp2021/Mobile/important/passwordscreen.dart';
import 'package:alramzapp2021/Mobile/screens/loginscreen_mobile.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/menues/menupopup.dart';
import 'package:alramzapp2021/services/aleartsetups/getalertobject.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExchangeAlerts.dart';
import 'package:alramzapp2021/settings/settings.dart';
import 'package:alramzapp2021/utils/assets.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addalerts.dart';

class AlertScreen extends StatefulWidget {
  @override
  _AlertScreen createState() => _AlertScreen();
}

class _AlertScreen extends State<AlertScreen> {
  final String image;
  final double size;

  _AlertScreen({this.image, this.size});
  bool isDivider = false;
  String alertID = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ExchnageAlearts().getAlerts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'alerts'),
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
              Icons.refresh,
              color: AppColors.white,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: AppColors.white,
              size: Sizes.s25,
            ),
          ),
          PopupMenuButton<String>(
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
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddAleart()));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<GetAlertObject>>(
        future: ExchnageAlearts().getAlerts(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Column(
              children: [CircularProgressIndicator(), Container()],
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  isDivider = true;
                } else {
                  isDivider = false;
                }
                return isDivider
                    ? InkWell(
                        onTap: () {},
                        child: Container(
                          color: AppColors.black.withOpacity(.3),
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      snapshot.data[index].symbol,
                                      style: TextStyleApplied.Text,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          getTranslated(context, 'when'),
                                          style: TextStyleApplied.TextCustom,
                                        ),
                                        _convertParametersReverse(
                                          snapshot.data[index].conditionName,
                                        ),
                                        _convertedCriteriaReserve(
                                          snapshot.data[index].condition,
                                        ),
                                        Text(
                                            snapshot.data[index].conditionValue,
                                            style: TextStyleApplied.TextCustom),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(snapshot.data[index].executed),
                                        Text(
                                          snapshot.data[index].validity,
                                          style: TextStyleApplied.Text,
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: AppColors.red,
                                        ),
                                        onPressed: () {
                                          alertID =
                                              snapshot.data[index].alertID;
                                          deleteAleart(alertID);
                                        })
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {},
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    snapshot.data[index].symbol,
                                    style: TextStyleApplied.Text,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        getTranslated(context, 'when'),
                                        style: TextStyleApplied.TextCustom,
                                      ),
                                      _convertParametersReverse(
                                          snapshot.data[index].conditionName),
                                      _convertedCriteriaReserve(
                                        snapshot.data[index].condition,
                                      ),
                                      Text(snapshot.data[index].conditionValue,
                                          style: TextStyleApplied.TextCustom),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(snapshot.data[index].executed),
                                      Text(
                                        snapshot.data[index].validity,
                                        style: TextStyleApplied.Text,
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: AppColors.red,
                                      ),
                                      onPressed: () {
                                        alertID = snapshot.data[index].alertID;
                                        deleteAleart(alertID);
                                      })
                                ],
                              )
                            ],
                          ),
                        ),
                      );
              },
            );
          }
        },
      ),
    );
  }

  _convertParametersReverse(String parameter) {
    if (parameter == 'MW_LAST_TRADE_PRICE') {
      parameter = 'Last Price';
      return Text(
        parameter,
        style: TextStyleApplied.TextCustom,
      );
    } else if (parameter == 'MW_HIGH_PRICE') {
      parameter = 'High Price';
      return Text(
        parameter,
        style: TextStyleApplied.TextCustom,
      );
    } else if (parameter == 'MW_LOW_PRICE') {
      parameter = 'Low Price';
      return Text(
        parameter,
        style: TextStyleApplied.TextCustom,
      );
    } else if (parameter == 'MW_MAX_PRICE') {
      parameter = 'Bid Price';
      return Text(
        parameter,
        style: TextStyleApplied.TextCustom,
      );
    } else if (parameter == 'MW_MIN_PRICE') {
      parameter = 'Offer Price';
      return Text(
        parameter,
        style: TextStyleApplied.TextCustom,
      );
    } else if (parameter == 'MW_NET_CHANGE') {
      parameter = 'Net Change';
      return Text(
        parameter,
        style: TextStyleApplied.TextCustom,
      );
    } else if (parameter == 'Net_Change_per') {
      parameter = 'Net Change %';
      return Text(
        parameter,
        style: TextStyleApplied.TextCustom,
      );
    } else if (parameter == 'MW_AVERAGE_PRICE') {
      parameter = 'Average Price';
      return Text(
        parameter,
        style: TextStyleApplied.TextCustom,
      );
    } else if (parameter == 'MW_LAST_TRADE_VOL') {
      parameter = 'Total Value';
      return Text(
        parameter,
        style: TextStyleApplied.TextCustom,
      );
    } else if (parameter == 'MW_TOTAL_VOLUME') {
      parameter = 'Total Volume';
      return Text(
        parameter,
        style: TextStyleApplied.TextCustom,
      );
    }
  }

  _convertedCriteriaReserve(String cretiriaString) {
    if (cretiriaString == 'E') {
      cretiriaString = '=';
      return Text(
        cretiriaString,
        style: TextStyleApplied.TextCustom,
      );
    } else if (cretiriaString == 'NE') {
      cretiriaString = '!=';
      return Text(
        cretiriaString,
        style: TextStyleApplied.TextCustom,
      );
    } else if (cretiriaString == 'GT') {
      cretiriaString = '>';
      return Text(
        cretiriaString,
        style: TextStyleApplied.TextCustom,
      );
    } else if (cretiriaString == 'GE') {
      cretiriaString = '>=';
      return Text(
        cretiriaString,
        style: TextStyleApplied.TextCustom,
      );
    } else if (cretiriaString == 'LT') {
      cretiriaString = '<';
      return Text(
        cretiriaString,
        style: TextStyleApplied.TextCustom,
      );
    } else if (cretiriaString == 'LE') {
      cretiriaString = '<=';
      return Text(
        cretiriaString,
        style: TextStyleApplied.TextCustom,
      );
    }
  }

  void choiceAction(Action) async {
    //    print("Mune PopUp");
    if (Action == MenuPopUpMobile.change_password) {
      AppRoutes.push(context, Changepassword());
    } else if (Action == MenuPopUpMobile.settings) {
      AppRoutes.push(context, Settings());
    } else if (Action == MenuPopUpMobile.aleart) {
      AppRoutes.push(context, AlertScreen());
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

  Future<GetAlertObject> deleteAleart(alertID) async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    String webcode = prfs.getString('webcode');
    var response = await http.post(
      '${Config.deleteAlert}$webcode/$alertID',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(Duration(seconds: Config.Timeout));
    if (response.statusCode == 200) {
      AppRoutes.push(context, AlertScreen());
    }
  }
}
