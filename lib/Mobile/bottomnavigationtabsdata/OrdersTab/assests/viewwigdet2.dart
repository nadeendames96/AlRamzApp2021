import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

class ViewWidget2 extends StatefulWidget {
  @override
  ViewWidgetState createState() => ViewWidgetState();
}

class ViewWidgetState extends State {
  bool viewVisible = false;

  bool viewMore = true;

  void showWidget() {
    setState(() {
      viewVisible = true;
      viewMore = false;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
      viewMore = true;
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        viewMore
            ? FlatButton(
                child: Text(
                  getTranslated(context, 'more'),
                  style: TextStyleApplied.Text,
                ),
                onPressed: showWidget,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              )
            : new Container(),
        viewVisible
            ? Column(children: [
                SizedBox(
                  height: Sizes.s3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, 'visiblequantity'),
                      style: TextStyleApplied.Text,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: Sizes.s5),
                      color: AppColors.white,
                      width: Sizes.s200 + 25,
                      height: Sizes.s40,
                      child: TextField(
                        style: TextStyleApplied.TextBlack,
                        decoration: InputDecoration(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Sizes.s3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, 'minimumfill'),
                      style: TextStyleApplied.Text,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: Sizes.s5),
                      color: AppColors.white,
                      width: Sizes.s200 + 25,
                      height: Sizes.s40,
                      child: TextField(
                        style: TextStyleApplied.TextBlack,
                        decoration: InputDecoration(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Sizes.s3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, 'Takeprofit'),
                      style: TextStyleApplied.Text,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: Sizes.s5),
                      color: AppColors.white,
                      width: Sizes.s200 + 25,
                      height: Sizes.s40,
                      child: TextField(
                        style: TextStyleApplied.TextBlack,
                        decoration: InputDecoration(
                            hintText: '0',
                            hintStyle: TextStyleApplied.TextBlack),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Sizes.s3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, 'Stoploss'),
                      style: TextStyleApplied.Text,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: Sizes.s5),
                      color: AppColors.white,
                      width: Sizes.s200 + 25,
                      height: Sizes.s40,
                      child: TextField(
                        style: TextStyleApplied.TextBlack,
                        decoration: InputDecoration(
                            hintText: '0',
                            hintStyle: TextStyleApplied.TextBlack),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Sizes.s3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, 'remarks'),
                      style: TextStyleApplied.Text,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: Sizes.s5),
                      color: AppColors.white,
                      width: Sizes.s200 + 25,
                      height: Sizes.s40,
                      child: TextField(
                        style: TextStyleApplied.TextBlack,
                      ),
                    ),
                  ],
                ),
                FlatButton(
                  child: Text(
                    getTranslated(context, 'less'),
                    style: TextStyleApplied.Text,
                  ),
                  onPressed: hideWidget,
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                ),
              ])
            : new Container(),
      ],
    );
  }
}
