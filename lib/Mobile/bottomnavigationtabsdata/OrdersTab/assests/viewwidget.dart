import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/OrdersTab/placeorder/placeorder.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/src.dart';
import 'package:ns_utils/utils/sizes.dart';

class ViewWidget extends StatefulWidget {
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
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              )
            : new Container(),
        viewVisible
            ? Column(children: [
                SizedBox(
                  height: Sizes.s5,
                ),
                PlaceOrder.isBuy
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Sizes.s200,
                                height: Sizes.s40,
                                color: AppColors.blue,
                                child: FlatButton(
                                  child: Text(
                                    getTranslated(context, 'OrderValue'),
                                    style: TextStyleApplied.TextBlack,
                                  ),
                                ),
                              ),
                              Container(
                                color: AppColors.white,
                                width: Sizes.s200,
                                height: Sizes.s40,
                                child: TextField(),
                              )
                            ],
                          ),
                          SizedBox(
                            height: Sizes.s5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Sizes.s200,
                                height: Sizes.s40,
                                color: AppColors.blue,
                                child: FlatButton(
                                  onPressed: () {
                                    PlaceOrder.allBalance = true;
                                  },
                                  child: Text(
                                    getTranslated(context, 'AllBalance'),
                                    style: TextStyleApplied.TextBlack,
                                  ),
                                ),
                              ),
                              Container(
                                color: AppColors.lightBlueAccent,
                                width: Sizes.s200,
                                height: Sizes.s40,
                                child: FlatButton(
                                  onPressed: null,
                                  child: Text(
                                    getTranslated(context, 'AllPositions'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Opacity(
                                opacity: .6,
                                child: Container(
                                  width: Sizes.s200,
                                  height: Sizes.s40,
                                  color: AppColors.pink,
                                  child: FlatButton(
                                    child: Text(
                                      getTranslated(context, 'OrderValue'),
                                      style: TextStyleApplied.Text,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                color: AppColors.primary,
                                width: Sizes.s200,
                                height: Sizes.s40,
                                child: TextField(),
                              )
                            ],
                          ),
                          SizedBox(
                            height: Sizes.s5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Opacity(
                                opacity: .6,
                                child: Container(
                                  width: Sizes.s200,
                                  height: Sizes.s40,
                                  color: AppColors.pink,
                                  child: FlatButton(
                                    child: Text(
                                      getTranslated(context, 'AllBalance'),
                                      style: TextStyleApplied.Text,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                color: AppColors.pink,
                                width: Sizes.s200,
                                height: Sizes.s40,
                                child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      PlaceOrder.allPosition = true;
                                      print(PlaceOrder.allPosition);
                                    });
                                  },
                                  child: Text(
                                      getTranslated(context, 'AllPositions')),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                FlatButton(
                  child: Text(
                    getTranslated(context, 'less'),
                    style: TextStyleApplied.Text,
                  ),
                  onPressed: hideWidget,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                ),
              ])
            : new Container(),
      ],
    );
  }
}
