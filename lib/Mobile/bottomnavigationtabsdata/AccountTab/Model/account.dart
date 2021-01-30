import 'dart:ui';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountpage/accountpage.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/Alearts/aleart.dart';
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
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountTab extends StatefulWidget {
  @override
  _AccountTabState createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> with TickerProviderStateMixin {
  final String image;
  final double size;

  _AccountTabState({this.image, this.size});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            getTranslated(context, 'myaccounts'),
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
                size: Sizes.s25,
              ),
            ),
            Hero(
              tag: 'kdjjwodiefo',
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
                      child: Text(
                        choice,
                        style: TextStyleApplied.Text,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: Sizes.s80,
              color: AppColors.lightgreen2,
              child: Row(
                children: [
                  Icon(Icons.info_outline),
                  SizedBox(
                    width: Sizes.s20,
                  ),
                  Text(
                    getTranslated(context, 'chooseanaccounttoviewitsdetails'),
                    style: TextStyleApplied.Text,
                  )
                ],
              ),
            ),
            AccountPage()
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
