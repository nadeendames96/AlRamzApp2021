import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/overview/pricedepth.dart';
import 'package:flutter/material.dart';

import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamz/AlRamz2020/alramz/lib/utils/colors.dart';

import 'depthview.dart';
import 'firstsec.dart';
import 'orderdepth.dart';

class Overview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FirstSection(),
          DepthView(),
          PriceDepth(),
          Divider(
            color: AppColors.light_blue,
            thickness: 2,
          ),
          OrderDepth(),
        ],
      ),
    );
  }
}
