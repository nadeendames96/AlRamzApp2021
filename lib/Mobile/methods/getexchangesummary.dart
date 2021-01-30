import 'dart:convert';

import 'package:alramzapp2021/services/MarektWServices/exchane_object.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/statics_value/staticvalues.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

List item = List();
final List marketsNameE = List();
final List marketsNameA = List();
List currentValue = List();
List netChange = List();
List netChangePrec = List();
List turnover = List();
List volume = List();
List trades = List();
List symbolTrades = List();
List netFlow = List();
List cashMap = List();
List symbolUps = List();
List symbolDns = List();
List noChnages = List();

List<ExchangeMarketObject> items = List<ExchangeMarketObject>();
Future<List<ExchangeMarketObject>> getExchangeSummary() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String webcode = prefs.getString('webcode');
  var url =
      "http://develop.fitoman.com:8080/MobileServicesRamz/MarektWServices/GetExchangeSummary/$webcode";
  final response = await http.get(url, headers: {
    'Cookie': '${Config.cookieSave}'
  }).timeout(const Duration(seconds: Config.Timeout));
  var jsonDate = null;
  List<ExchangeMarketObject> list = [];
  print('response123');
  print(response.statusCode);
  if (response.statusCode == 200) {
    jsonDate = json.decode(response.body);
    for (var jsondata in jsonDate) {
      netFlow.add(jsondata['BuyCashFlowPerc']);
      cashMap.add(jsondata['BuyCashFlowPerc']);
      symbolUps.add(jsondata['SymbolsUP']);
      symbolDns.add(jsondata['SymbolsDown']);
      noChnages.add(jsondata['SymbolsUnChange']);
      turnover.add(jsondata['TurnOver']);
      volume.add(jsondata['Volume']);
      trades.add(jsondata['TotalExecuted']);
      symbolTrades.add(jsondata['SymbolsTraded']);
      item.add(jsondata['ExchangeID']);
      marketsNameE.add(jsondata['ExchangeNameE']);
      marketsNameA.add(jsondata['ExchangeNameA']);
      currentValue.add(jsondata['CurrentValue']);
      netChange.add(jsondata['NetChange']);
      netChangePrec.add(jsondata['NetChangePerc']);
      list.add(ExchangeMarketObject.fromJson(jsondata));
    }
    StaticValues.marketNameE = await marketsNameE[0];
    StaticValues.market = await item[0];
    StaticValues.turnover = await turnover[0];
    StaticValues.volume = await volume[0];
    StaticValues.trades = await trades[0];
    StaticValues.symbolTrades = await symbolTrades[0];
    StaticValues.currentValue = await currentValue[0];
    StaticValues.netChange = await netChange[0];
    StaticValues.netChangePrec = await netChangePrec[0];
    StaticValues.marketNameA = await marketsNameA[0];
  } else {
    print('cant able to fetch data from api');
  }
  return list;
}
