import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/indecies/index.dart';
import 'package:alramzapp2021/scrolling/scroll.dart';
import 'package:flutter/material.dart';

import 'charts/mainchart.dart';
import 'firstsec.dart';

class SummaryMobile extends StatefulWidget {
  @override
  _SummaryMobileState createState() => _SummaryMobileState();
}

class _SummaryMobileState extends State<SummaryMobile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [FirstSection(), MainChart(), Indecies(), Scroll()],
      ),
    );
  }
}
