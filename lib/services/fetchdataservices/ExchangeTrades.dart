import 'dart:convert';

import 'package:alramzapp2021/services/TradeService/tradeObject.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class ExchangeTrades {
  Future<List<TradeObject>> getTrades(String clientID, String orderID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    print("${Config.getTrades}$webcode/$clientID/$orderID");
    http.Response response = await http
        .get("${Config.getTrades}$webcode/$clientID/$orderID", headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(Duration(seconds: Config.Timeout));
    print(response.statusCode);
    var jsonDate = null;
    List<TradeObject> list = [];
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      print(jsonDate);
      for (var jsondata in jsonDate) {
        list.add(TradeObject.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }
}
