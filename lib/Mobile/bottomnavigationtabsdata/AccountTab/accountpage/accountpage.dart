import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accounttabs/accounttabs.dart';
import 'package:alramzapp2021/services/Accounts/getaccountinfo_object.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExcahngesAccounts.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountPage extends StatefulWidget {
  static String clientID = '';
  static String mainClintID = '';
  static String accountName = '';

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('ddMMyyyy000000');
  static String formatted = formatter.format(now);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<GetAccountInfo>>(
        future: ExchangesAccounts().getAccountInfo(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Container(
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        AccountPage.accountName =
                            snapshot.data[index].clientNameE;
                        AccountPage.clientID = snapshot.data[index].clientID;
                        AccountPage.mainClintID =
                            snapshot.data[index].mainClientID;
                        // SearchForm.datefrom = formatted;
                        // SearchForm.dateto = formatted;
                        AppRoutes.push(context, AccountTabs());
                      });
                    },
                    title: Text(snapshot.data[index].clientNameE,
                        style: TextStyleApplied.Text),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.white,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
