import 'dart:convert';

import 'package:alramzapp2021/services/Accounts/accountportofiolo_object.dart';
import 'package:alramzapp2021/services/Accounts/getaccountinfo_object.dart';
import 'package:alramzapp2021/services/Accounts/getaccountsummary.dart';
import 'package:alramzapp2021/services/Accounts/statement_object.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class ExchangesAccounts {
  Future<List<GetAccountInfo>> getAccountInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    http.Response response = await http.get("${Config.GetAccountUsers}$webcode",
        headers: {
          'Cookie': '${Config.cookieSave}'
        }).timeout(const Duration(seconds: Config.Timeout));
    var jsonDate = null;
    List<GetAccountInfo> list = [];
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      for (var jsondata in jsonDate) {
        list.add(GetAccountInfo.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }

  Future<GetAccountSummary> getExchangeSummaryByClientID(
      String date, String clientID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    String ucode = prefs.get('ucode');
    String brokerID = prefs.getString('brokerid');
    var response = await http.get(
        "${Config.GetAccountSummary}$ucode/$date/$clientID/$brokerID/$webcode",
        headers: {
          'Cookie': '${Config.cookieSave}'
        }).timeout(const Duration(seconds: Config.Timeout));
    var jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      prefs.setString('clentID', clientID);
      GetAccountSummary obj = GetAccountSummary.fromJson(jsonData);
      // print(obj.toString());
      return Future<GetAccountSummary>.value(obj);
    } else {
      throw Exception('Cant fetch data');
    }
  }

  Future<List<AccountsPortofioloObject>> AccountPortfiolo(
      String mainClientID, String clientID, String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    String brokerID = prefs.getString('brokerid');
    print(
        '${Config.GetAccountPortfiolio}$mainClientID/$clientID/$webcode/$date/$brokerID');
    var response = await http.get(
        "${Config.GetAccountPortfiolio}$mainClientID/$clientID/$webcode/$date/$brokerID",
        headers: {
          'Cookie': '${Config.cookieSave}'
        }).timeout(const Duration(seconds: Config.Timeout));
    var jsonDate = null;
    List<AccountsPortofioloObject> list = List<AccountsPortofioloObject>();
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      for (var jsondata in jsonDate) {
        list.add(AccountsPortofioloObject.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }

  Future<List<StatementObject>> AccountStatement(String mainClientID,
      String clientID, String datefrom, String dateto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    print(
        "${Config.Statement}$mainClientID/$clientID/$webcode/$datefrom/$dateto");
    var response = await http.get(
        "${Config.Statement}$mainClientID/$clientID/$webcode/$datefrom/$dateto",
        headers: {
          'Cookie': '${Config.cookieSave}'
        }).timeout(const Duration(seconds: Config.Timeout));
    var jsonDate = null;
    List<StatementObject> list = List<StatementObject>();
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      for (var jsondata in jsonDate) {
        list.add(StatementObject.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }
}
