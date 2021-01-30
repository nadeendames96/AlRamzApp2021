import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountpage/accountpage.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountportfilio/searchportifilo.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountsummary/accountsummary.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:ns_utils/src.dart';

import 'executeportfiolio.dart';
import 'firstsection.dart';

class AccountPortifiolo extends StatefulWidget {
  static String pCost = '', symbol = '';
  AccountPortifiolo(symbol);

  @override
  _AccountPortifioloState createState() => _AccountPortifioloState();
}

class _AccountPortifioloState extends State<AccountPortifiolo> {
  String clientID = AccountPage.clientID;
  String date = AccountSummary.formatted;
  String mainClientID = AccountPage.mainClintID;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return SearchPortifiolo();
                            }));
                      });
                    },
                    child: FirstPortofilo(),
                  ),
                  Divider(color: AppColors.white),
                  ExecutePortfilo(),
                  Container(
                    margin: EdgeInsets.only(left: Sizes.s5, right: Sizes.s5),
                    child: Column(
                      children: [
                        Text(getTranslated(context, 'total')),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(getTranslated(context, 'value')),
                            Text(ExecutePortfilo.totalValue.toString())
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(getTranslated(context, 'totalmarketvalue')),
                            Text(ExecutePortfilo.totalMarket.toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(getTranslated(context, 'pl')),
                            Text(ExecutePortfilo.totalPL.toString()),
                          ],
                        )
                      ],
                    ),
                  )
                ])));
  }
}
