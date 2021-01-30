import 'dart:ui';

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
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'orderdetail.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final String image;
  final double size;

  _OrderDetailsState({this.image, this.size});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text(
                getTranslated(context, 'orderdetails'),
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
                    Icons.notifications,
                    color: AppColors.white,
                    size: Sizes.s25,
                  ),
                ),
                Hero(
                  tag: 'AppStrings.heroMenuPopup04404',
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
            body: OrderDetail()));
  }

  void choiceAction(Action) async {
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
