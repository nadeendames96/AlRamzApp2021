import 'dart:convert';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/Alearts/aleart.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformate.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/OrdersTab/placeorder/placeorder.dart';
import 'package:alramzapp2021/Mobile/important/passwordscreen.dart';
import 'package:alramzapp2021/Mobile/screens/loginscreen_mobile.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/menues/menupopup.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/services/transferamountservice/transferamountservice.dart';
import 'package:alramzapp2021/settings/settings.dart';
import 'package:alramzapp2021/utils/assets.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ns_utils/src.dart';
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransferAmount extends StatefulWidget {
  @override
  _TransferAmount createState() => _TransferAmount();
}

class _TransferAmount extends State<TransferAmount> {
  final String image;
  final double size;
  _TransferAmount({this.image, this.size});
  List data = List(); //edited line
  bool isValid = false;
  Future<String> getAccountsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    var response = await http.get('${Config.GetAccountUsers}$webcode',
        headers: {
          "Accept": "application/json",
          "Cookie": "${Config.cookieSave}"
        });
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        data = jsonData;
      });
    } else {
      throw Exception('cant fetch data');
    }

    return "Sucess";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getAccountsData();
  }

  String _mySelection = 'Select';
  static String accountID = '';
  static String clientID = '';
  static String nin = '';
  static String accountName = '';
  static String avilable_balance = '';
  TextEditingController amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Image(
              image: AssetImage(image ?? Assets.ramzicon),
              height: size ?? Sizes.s20,
              width: size ?? Sizes.s20,
              fit: BoxFit.contain,
            ),
            IconButton(icon: Icon(Icons.refresh), onPressed: () {}),
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
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.s10, vertical: Sizes.s10),
              child: Row(
                children: [
                  Text(
                    getTranslated(context, 'transferAmount'),
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.s10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTranslated(context, 'accountno'),
                          style: TextStyleApplied.Text,
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: Sizes.s5),
                              width: Sizes.s200,
                              height: Sizes.s40,
                              color: AppColors.white,
                              child: new DropdownButton(
                                // underline: SizedBox(),
                                // validator: (value) => value == null
                                //     ? getTranslated(
                                //         context, 'accountisrequired')
                                //     : null,
                                // decoration: InputDecoration(
                                //   enabledBorder: UnderlineInputBorder(
                                //     borderSide: BorderSide(color: Colors.white),
                                //   ),
                                // ),
                                isExpanded: true,
                                hint: Text(
                                  PlaceOrder.select,
                                  style: TextStyleApplied.TextBlack,
                                ),
                                dropdownColor: AppColors.white,
                                style: TextStyleApplied.TextBlack,
                                items: data.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item['ClientNameE']),
                                    value: item['ClientNameE'].toString(),
                                    onTap: () {
                                      setState(() {
                                        transferAccount(amount.text);
                                        accountID = item['AccountID'];
                                        clientID = item['ClientID'];
                                        nin = item['NIN'];
                                      });
                                    },
                                  );
                                }).toList(),
                                onChanged: (newVal) {
                                  setState(() {
                                    _mySelection = newVal;
                                    accountName = newVal;
                                  });
                                },
                                value: _mySelection,
                              ),
                            ),
                            Container(
                              height: Sizes.s40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.white)),
                              child: Icon(
                                Icons.arrow_drop_down,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                )),
            SizedBox(
              height: Sizes.s5,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: Sizes.s200,
              decoration: BoxDecoration(
                border: Border.all(
                    width: .5, color: AppColors.blue.withOpacity(.3)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Sizes.s25,
                      horizontal: Sizes.s8,
                    ),
                    child: Row(
                      children: [
                        Text(
                          accountName == ''
                              ? getTranslated(context, 'accountno')
                              : accountName,
                          style: TextStyleApplied.Text,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.s8,
                    ),
                    child: Row(
                      children: [
                        Text(
                          getTranslated(context, 'investmentAccount'),
                          style: TextStyleApplied.Text,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.s8,
                      vertical: Sizes.s25,
                    ),
                    child: Row(
                      children: [
                        Text(
                          getTranslated(context, 'currentAccount'),
                          style: TextStyleApplied.Text,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.s8),
                    child: Row(
                      children: [
                        Text(
                          getTranslated(context, 'availableBalance'),
                          style: TextStyleApplied.Text,
                        ),
                        SizedBox(
                          width: Sizes.s30,
                        ),
                        SpacificFormate(avilable_balance)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Sizes.s5,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.s10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          getTranslated(context, 'Amount'),
                          style: TextStyleApplied.Text,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: Sizes.s200,
                          height: Sizes.s40,
                          child: TextField(
                            controller: amount,
                            style: TextStyleApplied.TextBlack,
                            decoration: InputDecoration(
                                // errorText: isValid
                                //     ? getTranslated(context, 'Amountrequired')
                                //     : '',
                                filled: true,
                                fillColor: Colors.white,
                                focusColor: Colors.black,
                                hintText: getTranslated(context, 'Amount'),
                                hintStyle: TextStyleApplied.TextBlack),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonTheme(
                    minWidth: Sizes.s20,
                    child: RaisedButton(
                      onPressed: () {
                        amount.text.isEmpty ? isValid = true : isValid = false;

                        if (double.parse(amount.text) >
                            double.parse(avilable_balance)) {
                          // Fluttertoast.showToast(
                          //     msg: getTranslated(context, 'amountLessBalance'),
                          //     textColor: AppColors.white,
                          //     backgroundColor: AppColors.red);
                        } else {
                          setState(() {
                            Navigator.of(context).push(PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) {
                                  return _sureTransfer();
                                }));
                          });
                        }
                      },
                      child: Text(getTranslated(context, 'crmRequestAlramz')),
                      color: Color(0xFF2F5165),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 1)),
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                    ),
                  ),
                ],
              ),
            )
          ],
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

  Future<TransferAmoutObject> transferAccount(String amountTransfer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    var response = await http.post('${Config.transferAmountService}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'AMOUNT': amountTransfer,
          'WEB_CODE': webcode,
          "CLIENT_ID": clientID,
          "BankName": "-1",
          "BranchName": "-1",
          "TransferType": "3",
        }));
    var jsonResponse = null;
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      setState(() {
        avilable_balance = jsonResponse['AVILABLE_BALANCE'].toString();
      });

      // if (double.parse(amountTransfer) < 0) {
      //   Fluttertoast.showToast(
      //       msg: getTranslated(context, 'amountMoreZero'),
      //       textColor: AppColors.white,
      //       backgroundColor: AppColors.red,
      //       toastLength: Toast.LENGTH_LONG);
      // } else if (double.parse(amountTransfer) > avilable_balance.toDOUBLE) {
      //   Fluttertoast.showToast(
      //       msg: getTranslated(context, 'amountLessBalance'),
      //       textColor: AppColors.white,
      //       backgroundColor: AppColors.red,
      //       toastLength: Toast.LENGTH_LONG);
      // } else {
      // Fluttertoast.showToast(
      //     msg: getTranslated(context, 'successRequestSent'),
      //     textColor: AppColors.white,
      //     backgroundColor: AppColors.lightgreen,
      //     toastLength: Toast.LENGTH_LONG);
      Navigator.pop(context);
      // if (jsonResponse['STATUS'] == '0') {
      //   Fluttertoast.showToast(
      //       msg: getTranslated(context, 'successRequestSent'),
      //       textColor: AppColors.white,
      //       backgroundColor: AppColors.lightgreen,
      //       toastLength: Toast.LENGTH_LONG);
      //   Navigator.pop(context);
      // } else if (jsonResponse['STATUS'] == '-1') {
      //   Fluttertoast.showToast(
      //       msg: getTranslated(context, 'amountLessBalance'),
      //       textColor: AppColors.white,
      //       backgroundColor: AppColors.red,
      //       toastLength: Toast.LENGTH_LONG);
      // } else if (jsonResponse['STATUS'] == '-2') {
      //   Fluttertoast.showToast(
      //       msg: getTranslated(context, 'missingBankInfo'),
      //       textColor: AppColors.white,
      //       backgroundColor: AppColors.red,
      //       toastLength: Toast.LENGTH_LONG);
      // } else if (jsonResponse['STATUS'] == '-3') {
      //   Fluttertoast.showToast(
      //       msg: getTranslated(context, 'failToRequest'),
      //       textColor: AppColors.white,
      //       backgroundColor: AppColors.red,
      //       toastLength: Toast.LENGTH_LONG);
      // } else if (jsonResponse['STATUS'] == '-4') {
      //   Fluttertoast.showToast(
      //       msg: getTranslated(context, 'TransferFailed'),
      //       textColor: AppColors.white,
      //       backgroundColor: AppColors.red,
      //       toastLength: Toast.LENGTH_LONG);
      // }
      // }
    } else {
      throw Exception('cant able to get service');
    }
  }

  Widget _sureTransfer() {
    return Opacity(
      opacity: 0.90,
      child: Container(
        color: AppColors.primary,
        child: AlertDialog(
          title: Text(getTranslated(context, 'confirmTransfer')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  getTranslated(context, 'youTransfer_X0_ofAmount_continue'),
                  style: TextStyleApplied.Text,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    color: AppColors.lightgreen2,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          getTranslated(context, 'yes'),
                          style: TextStyleApplied.Text,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              transferAccount(amount.text);
                            },
                          );
                        })),
                SizedBox(
                  height: Sizes.s5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  color: AppColors.lightgreen2,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(getTranslated(context, 'no'),
                        style: TextStyleApplied.Text),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
