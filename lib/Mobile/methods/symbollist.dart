import 'dart:convert';

import 'package:alramzapp2021/services/WatchServices/watchsymbolsprofiles_object.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

List symbol = List();
List symbolNameEn = List();
List LastTradePrice = List();
List netChnageSymbol = List();
List netChangePrecSymbol = List();
List open = List();
List maxPrice = List();
List minPrice = List();
List bidVol = List();
List bidPrice = List();
List volume = List();
List offerVol = List();
List offerPrice = List();
List closePrice = List();
List value = List();
List symbolNameAr = List();
List symbolNameA = List();
Future<List<WatchesSymbolsListProfilesObject>> getExchangeWatchProfilesByID(
    String profileID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String webcode = prefs.getString('webcode');
  print("${Config.GetMarketWatchByProfileID}$profileID/$webcode");
  http.Response response = await http
      .get("${Config.GetMarketWatchByProfileID}$profileID/$webcode")
      .timeout(const Duration(seconds: Config.Timeout));
  print(response.statusCode);
  var jsonDate = null;
  List<WatchesSymbolsListProfilesObject> list = [];
  if (response.statusCode == 200) {
    jsonDate = json.decode(response.body);
    for (var jsondata in jsonDate) {
      symbol.add(jsondata['Symbol']);
      symbolNameEn.add(jsondata['SymbolNameEnglish']);
      open.add(jsondata['OpenPrice']);
      maxPrice.add(jsondata['MaxPrice']);
      minPrice.add(jsondata['MinPrice']);
      bidPrice.add(jsondata['BidPrice']);
      bidVol.add(jsondata['BidVolume']);
      offerPrice.add(jsondata['OfferPrice']);
      offerVol.add(jsondata['OfferVolume']);
      volume.add(jsondata['TotalVolume']);
      value.add(jsondata['TotalValue']);
      closePrice.add(jsondata['ClosePrice']);
      symbolNameAr.add(jsondata['SymbolNameArabic']);
      symbolNameA.add(jsondata['SymbolNameA']);
      LastTradePrice.add(jsondata['LastTradePrice']);
      netChnageSymbol.add(jsondata['NetChange']);
      netChangePrecSymbol.add(jsondata['NetChangePerc']);
      list.add(WatchesSymbolsListProfilesObject.fromJson(jsondata));
    }
    // StaticValues.symbol = symbol[0];
    // StaticValues.symbolNameEn = symbolNameEn[0];
    // StaticValues.open = open[0];
    // StaticValues.minPrice = minPrice[0];
    // StaticValues.maxPrice = maxPrice[0];
    // StaticValues.bidVol = bidVol[0];
    // StaticValues.bidPrice = bidPrice[0];
    // StaticValues.offerVol = offerVol[0];
    // StaticValues.offerPrice = offerPrice[0];
    // StaticValues.volumeSymbol = volume[0];
    // StaticValues.valueSymbol = value[0];
    // StaticValues.closePrice = closePrice[0];
    // StaticValues.symbolNameAr = symbolNameAr[0];
    // StaticValues.symbolNameA = symbolNameA[0];
    // StaticValues.lastTradePrice = LastTradePrice[0];
    // StaticValues.netChangeSymbol = netChnageSymbol[0];
    // StaticValues.netChangePrecSymbol = netChangePrecSymbol[0];
  } else {
    throw Exception('cant able to fetch data from api');
  }

  return list;
}
