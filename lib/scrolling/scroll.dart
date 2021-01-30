import 'package:alramzapp2021/services/MarektWServices/exchangesymmaryindecies_object.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExtangeMarkets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

class Scroll extends StatefulWidget {
  @override
  _ScrollState createState() => _ScrollState();
}

class _ScrollState extends State<Scroll> {
  LocalStorage storage = LocalStorage('AlRamz');
  String market = '';
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    market = storage.getItem('market');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: 1,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
              child: FutureBuilder<List<ExchangeMArketIndexiesObject>>(
                  future: ExtangesMarkets().getExchangeSummaryIndecies(market),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Column(
                        children: [Container()],
                      );
                    } else {
                      return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                padding: EdgeInsets.only(
                                    left: 3, top: 10, bottom: 10),
                                child: Column(
                                  children: [
                                    Text(''),
                                    Text(''),
                                    Text(''),
                                    Text(''),
                                  ],
                                ));
                          });
                    }
                  }));
        });
  }
}
