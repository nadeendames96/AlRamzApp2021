import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountpage/accountpage.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountstatement/searchstatement.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/services/Accounts/statement_object.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExcahngesAccounts.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:ns_utils/utils/sizes.dart';

import 'accountstatement.dart';
import 'assests/balanceformate.dart';
import 'assests/dmt.dart';

class StatementRessults extends StatelessWidget {
  bool isDivider = false;
  int day = int.parse(SearchForm.datefrom) - int.parse(SearchForm.dateto);

  @override
  Widget build(BuildContext context) {
    // ignore: unrelated_type_equality_checks
    if (Statement.datefrom == SearchForm.datefrom &&
            // ignore: unrelated_type_equality_checks
            Statement.dateto == SearchForm.dateto ||
        SearchForm.dateto != Statement.formatted) {
      if (day <= 7) {
        return FutureBuilder<List<StatementObject>>(
          future: ExchangesAccounts().AccountStatement(AccountPage.mainClintID,
              AccountPage.clientID, Statement.datefrom, Statement.dateto),
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
                  Text(
                    snapshot.data[index].remarkE,
                    style: TextStyleApplied.Text,
                  );
                  return isDivider
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data[index].remarkE,
                                  style: TextStyleApplied.Text,
                                ),
                                Balance(snapshot.data[index].balance.toString())
                              ],
                            ),
                            Container(
                              color: AppColors.black.withOpacity(.3),
                              child: Card(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DMT(
                                            snapshot.data[index].balance
                                                .toString(),
                                            snapshot.data[index].dBAMT
                                                .toString()),
                                        Text(snapshot.data[index].remarkE),
                                        Row(
                                          children: [
                                            // Text(snapshot.data[index].postDate == ''
                                            //     ? '0'
                                            //     : snapshot.data[index].postDate),
                                            Text(
                                              getTranslated(context, 'qty') +
                                                          snapshot
                                                              .data[index].qTY
                                                              .toString() ==
                                                      ''
                                                  ? '0'
                                                  : snapshot.data[index].qTY
                                                      .toString(),
                                              style: TextStyleApplied.Text,
                                            ),
                                            SizedBox(
                                              width: Sizes.s20,
                                            ),
                                            Text(
                                                getTranslated(context,
                                                                'avgprc') +
                                                            snapshot.data[index]
                                                                .avgPrice
                                                                .toString() ==
                                                        ''
                                                    ? '0'
                                                    : snapshot
                                                        .data[index].avgPrice
                                                        .toString(),
                                                style: TextStyleApplied.Text)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Localizations.localeOf(context)
                                              .languageCode ==
                                          'en'
                                      ? snapshot.data[index].remarkE
                                      : snapshot.data[index].remarkA,
                                  style: TextStyleApplied.Text,
                                ),
                                Balance(snapshot.data[index].balance.toString())
                              ],
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DMT(
                                          snapshot.data[index].balance
                                              .toString(),
                                          snapshot.data[index].dBAMT
                                              .toString()),
                                      Localizations.localeOf(context)
                                                  .languageCode ==
                                              'en'
                                          ? Text(snapshot.data[index].remarkE)
                                          : Text(snapshot.data[index].remarkA),
                                      Row(
                                        children: [
                                          // Text(snapshot.data[index].postDate == ''
                                          //     ? '0'
                                          //     : snapshot.data[index].postDate),
                                          Text(
                                            getTranslated(context, 'qty') +
                                                        snapshot.data[index].qTY
                                                            .toString() ==
                                                    ''
                                                ? '0'
                                                : snapshot.data[index].qTY
                                                    .toString(),
                                            style: TextStyleApplied.Text,
                                          ),
                                          SizedBox(
                                            width: Sizes.s20,
                                          ),
                                          Text(
                                              getTranslated(context, 'avgprc') +
                                                          snapshot.data[index]
                                                              .avgPrice
                                                              .toString() ==
                                                      ''
                                                  ? '0'
                                                  : snapshot
                                                      .data[index].avgPrice
                                                      .toString(),
                                              style: TextStyleApplied.Text)
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                },
              );
            }
          },
        );
      } else {
        // Fluttertoast.showToast(msg: 'Not OK');
        return Container();
      }
    } else {
      return FutureBuilder<List<StatementObject>>(
        future: ExchangesAccounts().AccountStatement(AccountPage.mainClintID,
            AccountPage.clientID, Statement.formatted, Statement.formatted),
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
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Localizations.localeOf(context).languageCode == 'en'
                              ? snapshot.data[index].remarkE
                              : snapshot.data[index].remarkA,
                          style: TextStyleApplied.Text,
                        ),
                        Balance(snapshot.data[index].balance.toString())
                      ],
                    ),
                  ],
                );
              },
            );
          }
        },
      );
    }
  }
}
