import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/watchtabs/tabs.dart';
import 'package:alramzapp2021/determinetype/determinetypes.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/services/WatchServices/gettrades_object.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExchangeWatches.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

class WatchMTrades extends StatefulWidget {
  @override
  _WatchMTradesState createState() => _WatchMTradesState();
}

class _WatchMTradesState extends State<WatchMTrades> {
  String symbol = WatchTabs.symbol;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isDivider = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<GetSymbolTradesObject>>(
      future: ExchangesWatches().GetSymbolTradesObjectWatches(symbol),
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
                  thickness: 2,
                ),
                Text('no display data')
              ],
            ),
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
                    ? Container(
                        padding: EdgeInsets.only(
                            left: Sizes.s2, top: Sizes.s2, bottom: Sizes.s2),
                        color: AppColors.black.withOpacity(.3),
                        child: Card(
                            child: MTrdsInfo(
                                snapshot.data[index].tradeTime,
                                snapshot.data[index].sellBuyFlag,
                                getTranslated(context, 'volume'),
                                snapshot.data[index].volume,
                                snapshot.data[index].price,
                                snapshot.data[index].netChange)))
                    : Container(
                        padding: EdgeInsets.only(
                            left: Sizes.s2, bottom: Sizes.s2, top: Sizes.s2),
                        child: MTrdsInfo(
                            snapshot.data[index].tradeTime,
                            snapshot.data[index].sellBuyFlag,
                            getTranslated(context, 'volume'),
                            snapshot.data[index].volume,
                            snapshot.data[index].price,
                            snapshot.data[index].netChange));
              });
        }
      },
    ));
  }

  Widget MTrdsInfo(
      date, typeorder, volume, volumeValue, currentValue, netChange) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyleApplied.Text,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetermineType(typeorder),
                SizedBox(
                  width: Sizes.s10,
                ),
                Text(volume, style: TextStyleApplied.Text),
                SizedBox(
                  width: Sizes.s10,
                ),
                Text(volumeValue, style: TextStyleApplied.Text),
              ],
            )
          ],
        ),
        Row(
          children: [
            Text(currentValue, style: TextStyleApplied.Text),
            Text('($netChange)', style: TextStyleApplied.Text)
          ],
        )
      ],
    );
  }
}
