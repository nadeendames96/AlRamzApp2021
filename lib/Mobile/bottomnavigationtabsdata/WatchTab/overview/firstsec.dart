import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/watchtabs/tabs.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/services/WatchServices/getWatchListBySymbol.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExchangeWatches.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamz/AlRamz2020/alramz/lib/utils/colors.dart';

import 'bootomsectionfirstswection.dart';
import 'firstsecdesign.dart';

class FirstSection extends StatefulWidget {
  @override
  _FirstSectionState createState() => _FirstSectionState();
}

class _FirstSectionState extends State<FirstSection> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          child: FutureBuilder<List<GetWatchListBySymbol>>(
              future: ExchangesWatches()
                  .getExchangeWatchListBySymbol(WatchTabs.symbol),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Column(
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                      Container(),
                    ],
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return FirstSectionDesign(
                            Localizations.localeOf(context).languageCode == 'en'
                                ? snapshot.data[index].symbolNameE
                                : snapshot.data[index].symbolNameA,
                            getTranslated(context, 'open'),
                            snapshot.data[index].openPrice,
                            getTranslated(context, 'LimitUp'),
                            snapshot.data[index].maxPrice,
                            getTranslated(context, 'high'),
                            snapshot.data[index].highPrice,
                            getTranslated(context, 'pe'),
                            snapshot.data[index].pE,
                            getTranslated(context, 'close'),
                            snapshot.data[index].closePrice,
                            getTranslated(context, 'LimitDown'),
                            snapshot.data[index].minPrice,
                            getTranslated(context, 'low'),
                            snapshot.data[index].lowPrice,
                            getTranslated(context, 'volume'),
                            snapshot.data[index].totalVolume,
                            getTranslated(context, 'value'),
                            snapshot.data[index].totalValue,
                            getTranslated(context, 'mktPrice'),
                            snapshot.data[index].wk52Range);
                      });
                }
              })),
      Container(
          margin: EdgeInsets.only(bottom: Sizes.s5), child: BootomSection()),
      Divider(
        color: AppColors.light_blue,
        thickness: 2,
      )
    ]);
  }
}
