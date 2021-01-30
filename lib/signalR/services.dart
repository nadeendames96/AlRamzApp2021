import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alramzapp2021/services/MarektWServices/exchangesymmaryindecies_object.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/exchangeObject.dart';

class ServicesSignalRUpdate {
  Future<List<ExchangeObjectSignalR>> getExchangeSummary() async {
    sleep(Duration(milliseconds: 300));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    var url = "${Config.GetSummaryURL}$webcode";
    print('getSummaryURL ' + url);
    http.Response response = await http.get(url, headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(const Duration(seconds: Config.Timeout));
    var jsonDate = null;
    List<ExchangeObjectSignalR> list = [];
    print('statuscode summary ' + response.statusCode.toString());
    LocalStorage _storage = LocalStorage('AlRamz');
    var qs = "ischat=true&username" +
        _storage.getItem('username') +
        "&webCode=" +
        webcode +
        "&baseurl=";
    List jsonConvert = null;
    // SignalR signalR = SignalR(
    //     'http://109.107.237.83:8080/MobileServices/sr/signalr/hubs', "MyHub",
    //     queryString: qs,
    //     headers: {'Cookie': '${Config.cookieSave}'},
    //     statusChangeCallback: (status) =>
    //         print('statusChangeCallback connection signalR \t' + status),
    //     hubCallback: (message, message2) {
    //       print('message \t ' + message);
    //       print('message2 \t ' + message2);
    //       jsonDate = message2;
    //       prefs.setString('jsonData', jsonDate);
    //       print('prefs');
    //       print(prefs.getString('jsonData'));
    //       print('JsonData inside this method');
    //       print(jsonDate);
    //     });
    // print('prefs2');
    // print(prefs.getString('jsonData'));
    // jsonDate = prefs.getString('jsonData');
    // print('JsonData outside fsthis method');
    // print(jsonDate);
    // print('JsonData outside this method');
    // print(jsonDate);
    // signalR.connect();
    // signalR.subscribeToHubMethod('sendExchangeMarketObject');
    // print('statuscode summary2 ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      print('jsonRes');
      print(jsonDate);
      for (var jsondata in jsonDate) {
        list.add(ExchangeObjectSignalR.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }

  Future<List<ExchangeMArketIndexiesObject>> getExchangeSummaryIndecies(
      String exchangeid) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String webcode = prefs.getString('webcode');
    // var url = "${Config.summaryIndecues}$exchangeid/$webcode";
    // http.Response response = await http.get(url, headers: {
    //   'Cookie': '${Config.cookieSave}'
    // }).timeout(const Duration(seconds: Config.Timeout));
    // var jsonDate = null;
    // List<ExchangeMArketIndexiesObject> list = [];
    // if (response.statusCode == 200) {
    //   jsonDate = json.decode(response.body);
    //   for (var jsondata in jsonDate) {
    //     list.add(ExchangeMArketIndexiesObject.fromJson(jsondata));
    //   }
    // } else {
    //   print('cant able to fetch data from api');
    // }
    // return list;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocalStorage _storage = LocalStorage('AlRamz');
    String webcode = prefs.getString('webcode');
    var url = "${Config.summaryIndecues}$exchangeid/$webcode";
    final response = await http.get(url, headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(const Duration(seconds: Config.Timeout));
    var jsonDate = null;
    List<ExchangeMArketIndexiesObject> list = [];
    var qs = "ischat=true&username" +
        _storage.getItem('username') +
        "&webCode=" +
        webcode +
        "&baseurl=";
    List jsonConvert = null;
    List result = null;
    List CurrentValue = [];
    // SignalR signalR = SignalR(
    //     'http://109.107.237.83:8080/MobileServices/sr/signalr/hubs', "MyHub",
    //     queryString: qs,
    //     headers: {'Cookie': '${Config.cookieSave}'},
    //     statusChangeCallback: (status) =>
    //         print('status connection signalR \t' + status),
    //     hubCallback: (message, message2) {
    //       jsonConvert = json.decode(message2);
    //       //    print('message \t ' + message);
    //       //      print('message \t ' + message2);
    //       jsonDate = json.decode(message2);
    //       print('status code exchange');
    //       print(response.statusCode);
    //     });
    // final res = await signalR.invokeMethod("getMarketIndexObject",
    //     arguments: ['$exchangeid', '$webcode']).catchError((error) {
    //   print('error');
    //   print(error.toString());
    // });
    // await signalR.connect(); //last step
    // signalR.subscribeToHubMethod('getMarketIndexObject');
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      print(jsonDate);
      for (var jsondata in jsonDate) {
        list.add(ExchangeMArketIndexiesObject.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    // List<ExchangeMarketObject> list = [];
    // jsonDate = json.decode(response.body);
    return list;
  }
}
