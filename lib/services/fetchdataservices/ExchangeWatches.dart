import 'dart:convert';

import 'package:alramzapp2021/services/WatchServices/getWatchListBySymbol.dart';
import 'package:alramzapp2021/services/WatchServices/gettrades_object.dart';
import 'package:alramzapp2021/services/WatchServices/gettradessummary_object.dart';
import 'package:alramzapp2021/services/WatchServices/watchallmarkets_object.dart';
import 'package:alramzapp2021/services/WatchServices/watchessymbolchart.dart';
import 'package:alramzapp2021/services/WatchServices/watchprofiles_object.dart';
import 'package:alramzapp2021/services/WatchServices/watchsymbolsprofiles_object.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamz/AlRamz2020/alramz/lib/defaultvalues/defaultvalues.dart';

import '../config.dart';

class ExchangesWatches {
  Future<List<WatchProfilesObject>> getExchangeWatchProfiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    http.Response response = await http
        .get("${Config.GetAllProfilesLookupsByUSerCode}$webcode", headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(const Duration(seconds: Config.Timeout));
    var jsonDate = null;
    List<WatchProfilesObject> list = [];
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      for (var jsondata in jsonDate) {
        Statics.profileIDsWatch.add(jsondata['ProfileID']);
        Statics.profileNamesWatch.add(jsondata['ProfileName']);
        list.add(WatchProfilesObject.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }

  Future<List<WatchesSymbolsListProfilesObject>> getExchangeWatchProfilesByID(
      String profileID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    print("${Config.GetMarketWatchByProfileID}$profileID/$webcode");
    http.Response response = await http.get(
        "${Config.GetMarketWatchByProfileID}$profileID/$webcode",
        headers: {
          'Cookie': '${Config.cookieSave}'
        }).timeout(const Duration(seconds: Config.Timeout));
    print(response.statusCode);
    var jsonDate = null;
    List<WatchesSymbolsListProfilesObject> list = [];
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      for (var jsondata in jsonDate) {
        list.add(WatchesSymbolsListProfilesObject.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }

    return list;
  }

  Future<WatchesSymbolsListProfilesObject> getExchangeWatchProfilesSymbolByID(
      String profileID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    http.Response response = await http.get(
        "${Config.GetMarketWatchByProfileID}$profileID/$webcode",
        headers: {
          'Cookie': '${Config.cookieSave}'
        }).timeout(const Duration(seconds: Config.Timeout));
    if (response.statusCode == 200) {
      var jsonDate = json.decode(response.body);
      WatchesSymbolsListProfilesObject obj =
          WatchesSymbolsListProfilesObject.fromJson(jsonDate);
      return Future<WatchesSymbolsListProfilesObject>.value(obj);
    } else {
      throw Exception('Cant fetch data');
    }
  }

  static List<WatchALLMarketsObjects> list = [];
  Future<List<WatchALLMarketsObjects>> GetALLMarketWatch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    http.Response response = await http
        .get('${Config.GetALLMarketWatch}$webcode', headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(const Duration(seconds: Config.Timeout));
    var jsonData = null;

    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      for (var json in jsonData) {
        list.add(WatchALLMarketsObjects.fromJson(json));
      }
    } else {
      throw Exception('cant fetch data from api');
    }
    return list;
  }

  Future<List<GetSymbolTradesObject>> GetSymbolTradesObjectWatches(
      String symbol) async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    String webcode = prfs.getString('webcode');
    print('${Config.GetSymbolTradesObject}$webcode/$symbol');
    http.Response response = await http
        .get('${Config.GetSymbolTradesObject}$webcode/$symbol', headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(const Duration(seconds: Config.Timeout));
    List<GetSymbolTradesObject> list = List<GetSymbolTradesObject>();
    var jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      for (var json in jsonData) {
        list.add(GetSymbolTradesObject.fromJson(json));
      }
    } else {
      throw Exception('cant fetch data');
    }
    return list;
  }

  Future<List<GetSymbolSummearyTradesObject>>
      GetSymbolSummaryTradesObjectWatches(String symbol) async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    String webcode = prfs.getString('webcode');
    http.Response response = await http
        .get('${Config.GetSymbolTradesObject}$webcode/$symbol', headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(const Duration(seconds: Config.Timeout));
    List<GetSymbolSummearyTradesObject> list =
        List<GetSymbolSummearyTradesObject>();
    var jsonData = null;
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      for (var json in jsonData) {
        list.add(GetSymbolSummearyTradesObject.fromJson(json));
      }
    } else {
      throw Exception('cant fetch data');
    }
    return list;
  }

  Future<List<GetSymbolDialyChartObject>> getChartsWatchesBySymbol(
      String symbol, String exchangeid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    print("${Config.GetDailySymbolChart}$symbol/$exchangeid/$webcode");
    http.Response response = await http.get(
        "${Config.GetDailySymbolChart}$symbol/$exchangeid/$webcode",
        headers: {
          'Cookie': '${Config.cookieSave}'
        }).timeout(const Duration(seconds: Config.Timeout));
    var jsonDate = null;
    List<GetSymbolDialyChartObject> list = [];
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      for (var jsondata in jsonDate) {
        list.add(GetSymbolDialyChartObject.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }

  Future<List<GetWatchListBySymbol>> getExchangeWatchListBySymbol(
      String symbol) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    print("${Config.GetMarketWatchListBySymbol}$webcode/$symbol");
    http.Response response = await http
        .get("${Config.GetMarketWatchListBySymbol}$webcode/$symbol", headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(const Duration(seconds: Config.Timeout));
    var jsonDate = null;
    List<GetWatchListBySymbol> list = [];
    if (response.statusCode == 200) {
      jsonDate = json.decode(response.body);
      for (var jsondata in jsonDate) {
        list.add(GetWatchListBySymbol.fromJson(jsondata));
      }
    } else {
      print('cant able to fetch data from api');
    }
    return list;
  }
}
