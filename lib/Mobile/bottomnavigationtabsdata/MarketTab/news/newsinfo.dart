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
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'news.dart';

class NewsInfo extends StatefulWidget {
  @override
  _NewsInfoState createState() => _NewsInfoState();
}

class _NewsInfoState extends State<NewsInfo> {
  String news = NewsTab.news,
      newsDesc = NewsTab.newsDesc,
      marketID = NewsTab.marketId,
      symbol = NewsTab.symbol;
  final String image;
  final double size;

  _NewsInfoState({this.image, this.size});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Builder(
      builder: (context) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                getTranslated(context, 'news'),
                style: TextStyleApplied.TextNormal,
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
                  tag: 'kefjueifueifueifueifu',
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
            body: News(this.news, this.newsDesc, this.marketID, this.symbol));
      },
    ));
  }

  Widget News(news, newsDesc, marketID, symbol) {
    return Container(
      margin: EdgeInsets.only(top: Sizes.s10, left: Sizes.s5),
      child: Container(
        padding:
            EdgeInsets.only(top: Sizes.s20, bottom: Sizes.s20, right: Sizes.s5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(news, style: TextStyleApplied.Text),
              Container(
                child: Row(children: [
                  Text(
                    marketID,
                    style: TextStyleApplied.Text,
                  ),
                  Text(':', style: TextStyleApplied.Text),
                  Text(symbol, style: TextStyleApplied.Text)
                ]),
              ),
              Container(
                  margin: EdgeInsets.only(top: Sizes.s10),
                  child: Text(newsDesc, style: TextStyleApplied.Text)),
            ]),
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
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
            (Route<dynamic> route) => false);
        prefs.clear();
        prefs.commit();
      } else {
        throw Exception('cant sign out by api');
      }
    }
  }
}
