import 'dart:convert';
import 'dart:io';

import 'package:alramzapp2021/services/MarektWServices/excangelosers_object.dart';
import 'package:alramzapp2021/services/MarektWServices/exchane_object.dart';
import 'package:alramzapp2021/services/MarektWServices/exchanenews_objext.dart';
import 'package:alramzapp2021/services/MarektWServices/exchangeactives_object.dart';
import 'package:alramzapp2021/services/MarektWServices/exchangegainers.dart';
import 'package:alramzapp2021/services/MarektWServices/exchangemarketcharts_object.dart';
import 'package:alramzapp2021/services/MarektWServices/exchangesymmaryindecies_object.dart';
import 'package:alramzapp2021/services/MarektWServices/market_object_byID.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CustomException.dart';
import '../config.dart';

class ExtangesMarkets {
  Future<MarketObjectByID> getExchangeSummaryBYID(String exchangeID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    try {
      final response = await http
          .get("${Config.GetSummaryByIDURL}$exchangeID/$webcode", headers: {
        'Cookie': '${Config.cookieSave}'
      }).timeout(Duration(seconds: Config.Timeout));
      var jsonData = null;
      print('response code by market summary by id');
      print(response.statusCode);
      if (response.statusCode == 200) {
        jsonData = json.decode(response.body);
        print('jsonDataResponse');
        print(jsonData);
        MarketObjectByID obj = MarketObjectByID.fromJson(jsonData);
        return Future<MarketObjectByID>.value(obj);
      } else {
        throw Exception('not display data');
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<List<ExchangeMArketIndexiesObject>> getExchangeSummaryIndecies(
      String exchangeid) async {
    // String webcode = prefs.
    //     // SharedPreferences prefs = await SharedPreferences.getInstance();getString('webcode');
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

  Future<List<ExchnageGainersMarketObject>> getExchangeSummaryGainers(
      String exchangeid) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String webcode = prefs.getString('webcode');
    // // var jsonDate=null;
    // print('Gainers Cookie ' + Config.cookieSave.toString());
    // http.Response response = await http
    //     .get("${Config.Gainers}$exchangeid/$webcode", headers: {
    //   'Cookie': '${Config.cookieSave}'
    // }).timeout(const Duration(seconds: Config.Timeout));
    // print('URL GAINERS');
    // print("${Config.Gainers}$exchangeid/$webcode");
    // List<ExchnageGainersMarketObject> list = [];
    // var jsonData = null;
    // if (response.statusCode == 200) {
    //   jsonData = json.decode(response.body);
    //   print('Gainers');
    //   print(jsonData);
    //   for (var jsondata in jsonData) {
    //     list.add(ExchnageGainersMarketObject.fromJson(jsondata));
    //   }
    // } else {
    //   throw Exception('Cant fetch data');
    // }
    //
    // // else{
    // //   print('cant able to fetch data from api');
    // // }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocalStorage _storage = LocalStorage('AlRamz');
    String webcode = prefs.getString('webcode');
    var url = "${Config.Gainers}$exchangeid/$webcode";
    final response = await http.get(url, headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(const Duration(seconds: Config.Timeout));
    var jsonDate = null;
    List<ExchnageGainersMarketObject> list = [];
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      print(jsonDate);
      for (var jsondata in jsonDate) {
        print(jsondata);
        list.add(ExchnageGainersMarketObject.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }

  Future<List<ExchnageLossersMarketObject>> getExchangeSummaryLosers(
      String exchangeid) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String webcode = prefs.getString('webcode');
    // // var jsonDate=null;
    // print('Lossers Cookie ' + Config.cookieSave);
    // http.Response response = await http
    //     .get("${Config.Losers}$exchangeid/$webcode", headers: {
    //   'Cookie': '${Config.cookieSave}'
    // }).timeout(const Duration(seconds: Config.Timeout));
    // List<ExchnageLossersMarketObject> list = [];
    // var jsonData = null;
    // if (response.statusCode == 200) {
    //   jsonData = json.decode(response.body);
    //   print('Lossers');
    //   print(jsonData);
    //   for (var jsondata in jsonData) {
    //     list.add(ExchnageLossersMarketObject.fromJson(jsondata));
    //   }
    // } else {
    //   throw Exception('Cant fetch data');
    // }
    // return list;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocalStorage _storage = LocalStorage('AlRamz');
    String webcode = prefs.getString('webcode');
    var url = "${Config.Losers}$exchangeid/$webcode";
    final response = await http.get(url, headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(const Duration(seconds: Config.Timeout));
    var jsonDate = null;
    List<ExchnageLossersMarketObject> list = [];
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      print(jsonDate);
      for (var jsondata in jsonDate) {
        print(jsondata);
        list.add(ExchnageLossersMarketObject.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }

  Future<List<ExchnageActiviesMarketObject>> getExchangeSummaryActivies(
      String exchangeid) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String webcode = prefs.getString('webcode');
    // // var jsonDate=null;
    // http.Response response = await http
    //     .get("${Config.ActivesMarket}$exchangeid/$webcode", headers: {
    //   'Cookie': '${Config.cookieSave}'
    // }).timeout(const Duration(seconds: Config.Timeout));
    // List<ExchnageActiviesMarketObject> list = [];
    // var jsonData = null;
    // if (response.statusCode == 200) {
    //   jsonData = json.decode(response.body);
    //
    //   for (var jsondata in jsonData) {
    //     list.add(ExchnageActiviesMarketObject.fromJson(jsondata));
    //   }
    // } else {
    //   throw Exception('Cant fetch data');
    // }
    //
    // return list;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocalStorage _storage = LocalStorage('AlRamz');
    String webcode = prefs.getString('webcode');
    var url = "${Config.ActivesMarket}$exchangeid/$webcode";
    final response = await http.get(url, headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(const Duration(seconds: Config.Timeout));
    var jsonDate = null;
    List<ExchnageActiviesMarketObject> list = [];
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      print(jsonDate);
      for (var jsondata in jsonDate) {
        print(jsondata);
        list.add(ExchnageActiviesMarketObject.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }

  Future<List<ExchangesMarketsNewsObject>> getExchangeSummaryNews(
      String exchangeid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    // var jsonDate=null;
    http.Response response = await http.get("${Config.NewsAllMarket}$webcode",
        headers: {
          'Cookie': '${Config.cookieSave}'
        }).timeout(const Duration(seconds: Config.Timeout));
    List<ExchangesMarketsNewsObject> list = [];
    var jsonData = null;
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      for (var jsondata in jsonData) {
        list.add(ExchangesMarketsNewsObject.fromJson(jsondata));
      }
    } else {
      throw Exception('cant fetch data');
    }
    return list;
  }

  Future<List<ExchangeMarketObject>> getExchangeSummary() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    var url = "${Config.GetSummaryURL}$webcode";
    http.Response response = await http.get(url, headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(const Duration(seconds: Config.Timeout));
    List jsonData = [];
    print('url ' + url);
    print('statuscode summary ' + response.statusCode.toString());
    List<ExchangeMarketObject> list = [];
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      print('jsonSummary');
      print(jsonData);
      for (var jsondata in jsonData) {
        list.add(ExchangeMarketObject.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }

  Future<List<ExchangeMArketChartObject>> getChartsSummaryByID(
      String exchangeid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    final response = await http
        .get("${Config.chartsSummary}$exchangeid/$webcode", headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(const Duration(seconds: Config.Timeout));
    print(
        "${Config.chartsSummary}$exchangeid/$webcode"); // check if soluation correct or not
    var jsonDate = null;
    List<ExchangeMArketChartObject> list = [];
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      for (var jsondata in jsonDate) {
        list.add(ExchangeMArketChartObject.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }

  Future<List<ExchangeMArketChartObject>> getChartsSummaryByIDANDSECTOR(
      String sector, String exchangeid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    http.Response response = await http
        .get("${Config.chartIndex}$sector/$exchangeid/$webcode", headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(const Duration(seconds: Config.Timeout));
    var jsonDate = null;
    List<ExchangeMArketChartObject> list = [];
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      for (var jsondata in jsonDate) {
        list.add(ExchangeMArketChartObject.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }
}
