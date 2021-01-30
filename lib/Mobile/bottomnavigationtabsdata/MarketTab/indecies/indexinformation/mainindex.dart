import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformate.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/formates/spacificformatetextcolor.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/MarketTab/indecies/indeciescharts/chart.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/services/MarektWServices/exchangemarketcharts_object.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExtangeMarkets.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ns_utils/src.dart';
import 'package:ns_utils/utils/sizes.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../index.dart';

class MainIndex extends StatefulWidget {
  @override
  _MainIndexState createState() => _MainIndexState();
}

class _MainIndexState extends State<MainIndex> {
  LocalStorage storage = LocalStorage('AlRamz');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(
            getTranslated(context, 'indexdetails'),
            style: TextStyleApplied.Text,
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Container(
                color: AppColors.black.withOpacity(.3),
                width: MediaQuery.of(context).size.width,
                height: Sizes.s50,
                child: RaisedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Localizations.localeOf(context).languageCode == 'en'
                            ? '${Indecies.nameE} :  ${Indecies.exchangeID}'
                            : '${Indecies.nameA} :  ${Indecies.exchangeID}',
                        style: TextStyleApplied.TextCustomLarge,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SpacficTextColor(Indecies.currentValue,
                            Indecies.netChange, Indecies.netChangePerc),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Sizes.s20,
              ),
              SizedBox(
                width: Sizes.s10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        getTranslated(context, 'turnover'),
                        style: TextStyleApplied.TextCustomNormal,
                      ),
                      SpacificFormate(Indecies.turnOver,
                          valueText: TextStyleApplied.TextCustomLarge),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        getTranslated(context, 'volume'),
                        style: TextStyleApplied.TextCustomNormal,
                      ),
                      SpacificFormate(Indecies.volume,
                          valueText: TextStyleApplied.TextCustomLarge),
                    ],
                  )
                ],
              ),
              Center(
                  child: Container(
                      child: FutureBuilder<List<ExchangeMArketChartObject>>(
                          future: ExtangesMarkets()
                              .getChartsSummaryByIDANDSECTOR(
                                  Indecies.sector, Indecies.exchangeID),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return SfCartesianChart();
                            } else {
                              return Chart(
                                dataSource: snapshot.data,
                              );
                            }
                          }))),
            ])));
  }
}
