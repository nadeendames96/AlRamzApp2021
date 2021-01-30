import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/activies/actives.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/gainers/gainers.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/losers/losers.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/news/news.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/summaryMarket/summaries.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ns_utils/utils/sizes.dart';

class MarketMobileTabs extends StatefulWidget {
  MarketMobileTabs({Key key}) : super(key: key);

  @override
  _MarketMobileTabsState createState() => _MarketMobileTabsState();
}

class _MarketMobileTabsState extends State<MarketMobileTabs>
    with TickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Tab> myTabs = <Tab>[
      Tab(
        child: Text(
          getTranslated(context, 'summary'),
          style: TextStyleApplied.TextCustomTabs,
          textAlign: TextAlign.left,
        ),
      ),
      Tab(
        child: Text(
          getTranslated(context, 'gainers'),
          style: TextStyleApplied.TextCustomTabs,
          textAlign: TextAlign.left,
        ),
      ),
      Tab(
          child: Text(
        getTranslated(context, 'losers'),
        style: TextStyleApplied.TextCustomTabs,
        textAlign: TextAlign.left,
      )),
      Tab(
        child: Text(
          getTranslated(context, 'mostactive'),
          style: TextStyleApplied.TextCustomTabs,
          textAlign: TextAlign.left,
        ),
      ),
      Tab(
          child: Text(
        getTranslated(context, 'news'),
        style: TextStyleApplied.TextCustomTabs,
        textAlign: TextAlign.left,
      )),
    ];
    return Container(
        child: Column(children: <Widget>[
      Column(
        children: [
          TabBar(
            tabs: myTabs,
            labelStyle: TextStyleApplied.Text,
            unselectedLabelColor: AppColors.white,
            indicatorColor: AppColors.yellow,
            labelColor: AppColors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 5,
            controller: _tabController,
            isScrollable: true,
          ),
        ],
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: Sizes.s1,
        child: Divider(),
      ),
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: TabBarView(controller: _tabController, children: <Widget>[
          MarketSummary(),
          Gainers(),
          Losers(),
          Activies(),
          NewsTab(),
          // GainersTab(),
          // LossersTab(),
          // ActiviesTab(),
          // NewsTab(),
        ]),
      ),
    ]));
  }
}
