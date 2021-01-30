import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountpage/accountpage.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountportfilio/searchportifilo.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountsummary/accountsummary.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/services/Accounts/accountportofiolo_object.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExcahngesAccounts.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:flutter/material.dart';

import 'accountportfiolio.dart';
import 'design/potifiolodesign.dart';

class ExecutePortfilo extends StatelessWidget {
  String clientID = AccountPage.clientID;
  String date = AccountSummary.formatted;
  String mainClientID = AccountPage.mainClintID;
  static double totalValue = 0;
  static double totalMarket = 0;
  static double totalPL = 0;
  bool isDivider = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AccountsPortofioloObject>>(
      future:
          ExchangesAccounts().AccountPortfiolo(mainClientID, clientID, date),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Column(
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              Container()
            ],
          );
        } else {
          if (SearchPortifiolo.symbol.isNotEmpty) {
            return Column(
              children: [
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      totalValue = 0;
                      totalMarket = 0;
                      totalPL = 0;
                      if (SearchPortifiolo.symbol ==
                          snapshot.data[index].symbol) {
                        totalValue +=
                            snapshot.data[index].totalExpectedProfitLoss;
                        totalMarket += snapshot.data[index].totalMarketValue;
                        totalPL += snapshot.data[index].totalNetProfitLoss;
                        AccountPortifiolo.symbol = snapshot.data[index].symbol;
                        if (index % 2 == 0) {
                          isDivider = true;
                        } else {
                          isDivider = false;
                        }
                        return isDivider
                            ? Container(
                                color: AppColors.black.withOpacity(.3),
                                child: Card(
                                  child: PortfilioDesign(
                                      snapshot.data[index].symbol,
                                      'AED',
                                      getTranslated(context, 'shares'),
                                      snapshot.data[index].qty.toString(),
                                      getTranslated(context, 'closeprice'),
                                      snapshot.data[index].prClosePrice
                                          .toString(),
                                      getTranslated(context, 'cost'),
                                      snapshot.data[index].pCost.toString(),
                                      getTranslated(context, 'marketvalue'),
                                      snapshot.data[index].profit.toString(),
                                      getTranslated(context, 'value'),
                                      snapshot.data[index].psValue.toString(),
                                      getTranslated(context, 'pl'),
                                      snapshot.data[index].pPerc.toString(),
                                      snapshot.data[index].pProf.toString(),
                                      getTranslated(context, 'eqprice'),
                                      snapshot.data[index].ePrice.toString()
                                      //
                                      ),
                                ),
                              )
                            : Container(
                                child: PortfilioDesign(
                                    snapshot.data[index].symbol,
                                    'AED',
                                    getTranslated(context, 'shares'),
                                    snapshot.data[index].qty.toString(),
                                    getTranslated(context, 'closeprice'),
                                    snapshot.data[index].prClosePrice
                                        .toString(),
                                    getTranslated(context, 'cost'),
                                    snapshot.data[index].pCost.toString(),
                                    getTranslated(context, 'marketvalue'),
                                    snapshot.data[index].profit.toString(),
                                    getTranslated(context, 'value'),
                                    snapshot.data[index].psValue.toString(),
                                    getTranslated(context, 'pl'),
                                    snapshot.data[index].pPerc.toString(),
                                    snapshot.data[index].pProf.toString(),
                                    getTranslated(context, 'eqprice'),
                                    snapshot.data[index].ePrice.toString()
                                    //
                                    ),
                              );
                      }
                      // ignore: missing_return
                      else {
                        return Container();
                      }
                    }
                    // },
                    ),
                Divider()
              ],
            );
          } else {
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    totalValue = 0;
                    totalMarket = 0;
                    totalPL = 0;
                    totalValue += snapshot.data[index].totalExpectedProfitLoss;
                    totalMarket += snapshot.data[index].totalMarketValue;
                    totalPL += snapshot.data[index].totalNetProfitLoss;
                    AccountPortifiolo.symbol = snapshot.data[index].symbol;
                    if (index % 2 == 0) {
                      isDivider = true;
                    } else {
                      isDivider = false;
                    }
                    return isDivider
                        ? Container(
                            color: AppColors.black.withOpacity(.3),
                            child: Card(
                              child: PortfilioDesign(
                                  snapshot.data[index].symbol,
                                  'AED',
                                  getTranslated(context, 'shares'),
                                  snapshot.data[index].qty.toString(),
                                  getTranslated(context, 'closeprice'),
                                  snapshot.data[index].prClosePrice.toString(),
                                  getTranslated(context, 'cost'),
                                  snapshot.data[index].pCost.toString(),
                                  getTranslated(context, 'marketvalue'),
                                  snapshot.data[index].profit.toString(),
                                  getTranslated(context, 'value'),
                                  snapshot.data[index].psValue.toString(),
                                  getTranslated(context, 'pl'),
                                  snapshot.data[index].pPerc.toString(),
                                  snapshot.data[index].pProf.toString(),
                                  getTranslated(context, 'eqprice'),
                                  snapshot.data[index].ePrice.toString()
                                  //
                                  ),
                            ),
                          )
                        : Container(
                            child: PortfilioDesign(
                                snapshot.data[index].symbol,
                                'AED',
                                getTranslated(context, 'shares'),
                                snapshot.data[index].qty.toString(),
                                getTranslated(context, 'closeprice'),
                                snapshot.data[index].prClosePrice.toString(),
                                getTranslated(context, 'cost'),
                                snapshot.data[index].pCost.toString(),
                                getTranslated(context, 'marketvalue'),
                                snapshot.data[index].profit.toString(),
                                getTranslated(context, 'value'),
                                snapshot.data[index].psValue.toString(),
                                getTranslated(context, 'pl'),
                                snapshot.data[index].pPerc.toString(),
                                snapshot.data[index].pProf.toString(),
                                getTranslated(context, 'eqprice'),
                                snapshot.data[index].ePrice.toString()
                                //
                                ),
                          );
                  },
                ),
                Divider(
                  color: AppColors.white,
                ),
              ],
            );
          }
        }
      },
    );
  }
}
