import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/orders/orderinfo.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/watchtabs/tabs.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/services/TradeService/tradeObject.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExchangeTrades.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

class WatchTrades extends StatefulWidget {
  @override
  _WatchTradesState createState() => _WatchTradesState();
}

class _WatchTradesState extends State<WatchTrades> {
  String symbol = WatchTabs.symbol;
  bool isDivider = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(children: <Widget>[
      Container(
          padding: EdgeInsets.only(
              left: Sizes.s10, right: Sizes.s10, top: Sizes.s10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                                Icons.refresh,
                                color: AppColors.white,
                              ),
                            ),
                            Text(getTranslated(context, 'refresh'),
                                style: TextStyleApplied.Text)
                          ],
                        ),
                        onPressed: () {
                          //
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
                SingleChildScrollView(
                  child: FutureBuilder<List<TradeObject>>(
                      future: ExchangeTrades()
                          .getTrades(Config.clientID, Config.orderId),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            padding: EdgeInsets.only(left: Sizes.s10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(
                                  color: AppColors.light_blue,
                                  thickness: .2,
                                ),
                                Text(getTranslated(context, 'nodata'))
                              ],
                            ),
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
                                              '',
                                              snapshot.data[index].price,
                                              '',
                                              '',
                                              ''),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.only(
                                          left: Sizes.s2,
                                          top: Sizes.s2,
                                          bottom: Sizes.s2),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {});
                                        },
                                        child: OrderInfo(
                                            snapshot.data[index].symbol,
                                            '',
                                            '',
                                            snapshot.data[index].price,
                                            '',
                                            '',
                                            ''),
                                      ),
                                    );
                            },
                          );
                        }
                      }),
                )
              ]
              //

              ))
    ]));
  }
}
