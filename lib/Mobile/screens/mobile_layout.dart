import 'package:after_layout/after_layout.dart';
import 'package:alramzapp2021/Mobile/screens/loginscreen_mobile.dart';
import 'package:alramzapp2021/componants/applogowidset.dart';
import 'package:alramzapp2021/componants/background.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/src.dart';

class Mobile extends StatefulWidget {
  @override
  _MobileState createState() => _MobileState();
}

class _MobileState extends State<Mobile> with AfterLayoutMixin<Mobile> {
  @override
  void afterFirstLayout(BuildContext context) {
    Sizes.initScreenAwareSizes(context);
    Future.delayed(Duration(milliseconds: 1000), () {
      context.makeFirst(LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            BackgroundImageWidget(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: AppLogoWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
