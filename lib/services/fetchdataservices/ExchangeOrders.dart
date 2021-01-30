import 'dart:convert';

import 'package:alramzapp2021/services/OrdersService/getorderlist_object.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../lookups_object.dart';

class ExchangesOrders {
  // Future<List<GetOrderListObject>> getExchangeOrdersList() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String webcode = prefs.getString('webcode');
  //     http.Response response =
  //     await http.get("${Config.GetOrderList}$webcode");
  //     List<GetOrderListObject> list = [];
  //     if (response.statusCode == 200) {
  //       var jsonData = json.decode(response.body);
  //       for (var jsondata in jsonData) {
  //         list.add(GetOrderListObject.fromJson(jsondata));
  //       }
  //     }
  //
  //     else {
  //       throw Exception('cant fetch data');
  //     }
  //     return list;
  //
  // }

  Future<List<GetOrderListObject>> getOrdersList(String clientID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    http.Response response = await http
        .get("${Config.GetOrderList}/$clientID/$webcode", headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(const Duration(seconds: Config.Timeout));
    var jsonDate = null;
    List symbol = [];
    List exchange = [];
    List orderID = [];
    List accountId = [];
    List account = [];
    List type = [];
    List qun = [];
    List price = [];
    List valid = [];
    List date = [];
    List reminingQun = [];
    List avg = [];
    List status = [];
    List reason = [];
    List minFil = [];
    List visibleQun = [];
    List remarks = [];
    List<GetOrderListObject> list = [];
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      for (var jsondata in jsonDate) {
        symbol.add(jsondata['Symbol']);
        exchange.add(jsondata['Exchange']);
        orderID.add(jsondata['OrderID']);
        accountId.add(jsondata['AccountID']);
        account.add(jsondata['AccountNameE']);
        type.add(jsondata['SellBuyFlag']);
        qun.add(jsondata['ExecQty']);
        price.add(jsondata['Price']);
        valid.add(jsondata['ValidityCode']);
        date.add(jsondata['ModifyDate']);
        reminingQun.add(jsondata['Remaining']);
        avg.add(jsondata['AvgExePrice']);
        status.add(jsondata['StatusCode']);
        reason.add(jsondata['StatusCode']);
        minFil.add(jsondata['MinFillQty']);
        visibleQun.add(jsondata['VisibleQty']);
        remarks.add(jsondata['Remark']);
        list.add(GetOrderListObject.fromJson(jsondata));
      }

      // StaticValues.symbolOrder = symbol[0];
      // StaticValues.exchnageOrder = exchange[0];
      // StaticValues.orderID = orderID[0];
      // StaticValues.accountIDOrder = accountId[0];
      // StaticValues.accountOrder = account[0];
      // StaticValues.typeOrder = type[0];
      // StaticValues.qunOrder = qun[0];
      // StaticValues.priceOrder = price[0];
      // StaticValues.validOrder = valid[0];
      // StaticValues.dateOrder = date[0];
      // StaticValues.reminigQunOrder = reminingQun[0];
      // StaticValues.avgOrder = avg[0];
      // StaticValues.statusOrder = status[0];
      // StaticValues.reasonOrder = reason[0];
      // StaticValues.minFillOrder = minFil[0];
      // StaticValues.visibleQunOrder = visibleQun[0];
      // StaticValues.remarksOrder = remarks[0];
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }

  Future<List<GetOrderListObject>> getOrdersDeatils(
      String orderID, String clientID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    http.Response response = await http
        .get("${Config.GetOrderDetails}$orderID/$webcode/$clientID", headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(const Duration(seconds: Config.Timeout));
    var jsonDate = null;
    List<GetOrderListObject> list = [];
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      for (var jsondata in jsonDate) {
        list.add(GetOrderListObject.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }

  Future<List<GetLookupsObject>> getLookupsObject(String clientID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    print("${Config.GetLookups}$webcode");
    http.Response response = await http.get("${Config.GetLookups}$webcode",
        headers: {
          'Cookie': '${Config.cookieSave}'
        }).timeout(const Duration(seconds: Config.Timeout));
    var jsonDate = null;
    List<GetLookupsObject> list = [];
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      for (var jsondata in jsonDate) {
        list.add(GetLookupsObject.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }

  Future<GetOrderListObject> cancelOrder(String orderID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    String ipAddress = prefs.getString('ipAddress');
    var response = await http.delete(
        '${Config.cancelOrder}$orderID/$ipAddress/$webcode',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': '${Config.cookieSave}'
        }).timeout(const Duration(seconds: Config.Timeout));

    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
    } else {
      throw Exception('cant fetch data');
    }
  }
}
