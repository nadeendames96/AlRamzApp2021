import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountpage/accountpage.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountstatement/searchstatement.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accountstatement/statementresult.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:ns_utils/utils/sizes.dart';


class Statement extends StatefulWidget {
  String mainClientID = AccountPage.mainClintID;
  String clientID = AccountPage.clientID;
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('ddMMyyyy000000');
  static String formatted = formatter.format(now);
  String selectedDateTo = formatted;
  String selectedDateFrom = formatted;
  static String datefrom = formatted;
  static String dateto = formatted;

  Statement(datefrom, dateto);

  @override
  _StatementState createState() => _StatementState();
}

class _StatementState extends State<Statement> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Statement(SearchForm.datefrom, SearchForm.dateto);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Statements(),
    );
  }

  Widget Statements() {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: Sizes.s10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: Sizes.s5,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.of(context).push(PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) {
                                return SearchForm();
                              }));
                        });
                      },
                      child: Hero(
                        tag: 'Herostags',
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.search,
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              getTranslated(context, 'search'),
                              style: TextStyleApplied.Text,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  color: AppColors.white,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  getTranslated(context, 'credit') + '/',
                                  textAlign: TextAlign.left,
                                  style: TextStyleApplied.Text,
                                ),
                                Text(
                                  getTranslated(context, 'debit'),
                                  textAlign: TextAlign.left,
                                  style: TextStyleApplied.Text,
                                ),
                              ],
                            ),
                            Text(
                              getTranslated(context, 'balance'),
                              style: TextStyleApplied.Text,
                            )
                          ],
                        ),
                        Text(
                          getTranslated(context, 'remarks'),
                          style: TextStyleApplied.Text,
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                    Divider(color: AppColors.white),
                    StatementRessults()
                  ],
                ),
              ],
            ),
          ),
        ],
        //
      ),
    );
  }
}
