import 'package:alramzapp2021/services/MarektWServices/exchanenews_objext.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExtangeMarkets.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ns_utils/src.dart';

import 'newsinfo.dart';

class NewsTab extends StatefulWidget {
  static String news = '', newsDesc = '', marketId = '', symbol = '';

  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  DateFormat dateFormat = DateFormat("dd/MM/yyyy", "en");
  LocalStorage storage = LocalStorage('AlRamz');
  String market = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    market = storage.getItem('market');
    if (market != null) {
      market = storage.getItem('market');
    } else {
      market = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<ExchangesMarketsNewsObject>>(
      future: ExtangesMarkets().getExchangeSummaryNews(market),
      builder: (context, snaoshot) {
        if (snaoshot.data == null) {
          return Column(
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              Container()
            ],
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snaoshot.data.length,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () {
                        NewsTab.news =
                            snaoshot.data[index].newsDescE.substring(0, 20) +
                                '...';
                        NewsTab.newsDesc = snaoshot.data[index].newsDescE;
                        NewsTab.marketId = snaoshot.data[index].marketID;
                        NewsTab.symbol = snaoshot.data[index].symbol;
                        AppRoutes.push(context, NewsInfo());
                      },
                      title: Text(
                        snaoshot.data[index].newsDescE.substring(0, 20) + '...',
                        style: TextStyleApplied.Text,
                      ),
                      subtitle: Text(
                        snaoshot.data[index].newsDescE,
                        style: TextStyleApplied.Text,
                      ),
                      trailing: Text(
                        snaoshot.data[index].newsDate.substring(0, 8),
                        style: TextStyleApplied.Text,
                      ),
                    ),
                    SizedBox(
                      height: Sizes.s10,
                    )
                  ],
                ),
              );
            },
          );
        }
      },
    ));
  }
}
