import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/symbolinfo/symbolinfo.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/watchtabs/tabs.dart';
import 'package:alramzapp2021/services/WatchServices/watchsymbolsprofiles_object.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExchangeWatches.dart';
import 'package:alramzapp2021/statics_value/staticvalues.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class SymbolList extends StatefulWidget {
  @override
  _SymbolListState createState() => _SymbolListState();
}

class _SymbolListState extends State<SymbolList> {
  LocalStorage storage = LocalStorage('AlRamz');
  String profileID = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileID = storage.getItem('profileID');
    if (profileID != null) {
      profileID = storage.getItem('profileID');
    } else {
      profileID = '';
    }
  }

  bool isDivider = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<WatchesSymbolsListProfilesObject>>(
        future: ExchangesWatches().getExchangeWatchProfilesByID(
            profileID == '' ? StaticValues.profileID : profileID),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Column(
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
                Container(
                  child: Text(snapshot.error),
                )
              ],
            );
          } else {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {
                    isDivider = true;
                  } else {
                    isDivider = false;
                  }
                  return isDivider
                      ? Container(
                          color: Colors.black.withOpacity(.3),
                          child: Card(
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      WatchTabs.symbol =
                                          snapshot.data[index].symbol;
                                      WatchTabs.lasttrade =
                                          snapshot.data[index].lastTradePrice;
                                      WatchTabs.netchange = double.parse(
                                          snapshot.data[index].netChange);
                                      WatchTabs.netchangeprec =
                                          snapshot.data[index].netChangePerc;
                                      WatchTabs.bidprice =
                                          snapshot.data[index].bidPrice;
                                      WatchTabs.updatedate =
                                          snapshot.data[index].updateDateTime;
                                      AppRoutes.push(context, WatchTabs());
                                    });
                                  },
                                  child: SymbolInfo(
                                      snapshot.data[index].symbol,
                                      Localizations.localeOf(context)
                                                  .languageCode ==
                                              'en'
                                          ? snapshot.data[index].symbolNameE
                                          : snapshot.data[index].symbolNameA,
                                      snapshot.data[index].highPrice,
                                      snapshot.data[index].lowPrice,
                                      snapshot.data[index].executed,
                                      snapshot.data[index].lastTradePrice,
                                      snapshot.data[index].netChange,
                                      snapshot.data[index].netChangePerc))),
                        )
                      : Container(
                          padding: EdgeInsets.only(left: 2, top: 2, bottom: 2),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  WatchTabs.symbol =
                                      snapshot.data[index].symbol;
                                  WatchTabs.lasttrade =
                                      snapshot.data[index].lastTradePrice;
                                  WatchTabs.netchange = double.parse(
                                      snapshot.data[index].netChange);
                                  WatchTabs.netchangeprec =
                                      snapshot.data[index].netChangePerc;
                                  WatchTabs.bidprice =
                                      snapshot.data[index].bidPrice;
                                  WatchTabs.updatedate =
                                      snapshot.data[index].updateDateTime;
                                  AppRoutes.push(context, WatchTabs());
                                });
                              },
                              child: SymbolInfo(
                                  snapshot.data[index].symbol,
                                  Localizations.localeOf(context)
                                              .languageCode ==
                                          'en'
                                      ? snapshot.data[index].symbolNameE
                                      : snapshot.data[index].symbolNameA,
                                  snapshot.data[index].highPrice,
                                  snapshot.data[index].lowPrice,
                                  snapshot.data[index].executed,
                                  snapshot.data[index].lastTradePrice,
                                  snapshot.data[index].netChange,
                                  snapshot.data[index].netChangePerc)));
                });
          }
        },
      ),
    );
  }
}
