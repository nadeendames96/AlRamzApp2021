import 'dart:convert';

import 'package:http/http.dart' as http;

import 'CustomException.dart';

class Config {
  static const urlConfig = 'http://develop.fitoman.com:8080/MobileServices';
  static const deleteAlert =
      '${urlConfig}/NotificationWServices/DeleteAlertByAlertID/'; // webcode alertID
  static const getAlert =
      '${urlConfig}/NotificationWServices/GetAlertByUSerCode/'; //webcode
  static const UserAuthintications =
      '${urlConfig}/GeneralWServices/UserAuthintications';
  static const String GetSummaryURL =
      '${urlConfig}/MarektWServices/GetExchangeSummary/';
  static const String GetSummaryByIDURL =
      '${urlConfig}/MarektWServices/GetExchangeSummaryByID/';
  static const String chartsSummary =
      '${urlConfig}/NotificationwServices/GetIntraDayIndexChart/9999/';
  static const String summaryIndecues =
      '${urlConfig}/RealTimewServices/GetMarketIndicies/';
  static const String Gainers =
      '${urlConfig}/RealTimewServices/GetTopGainerObject/';
  static const Losers = '${urlConfig}/RealTimewServices/GetTopLoserObject/';
  static const ActivesMarket =
      '${urlConfig}/RealTimeWServices/GetMostActiveObject/';
  static const NewsAllMarket = '${urlConfig}/MarektWServices/GetAllMarketNews/';
  static const chartIndex =
      '${urlConfig}/NotificationwServices/GetIntraDayIndexChart/';
  static const GetAllProfilesLookupsByUSerCode =
      '${urlConfig}/MarektWServices/GetAllProfilesLookupsByUSerCode/';
  static const GetMarketWatchByProfileID =
      '${urlConfig}/MarektWServices/GetMarketWatchByProfileID/';
  static const AddMarketWatchProfileSymbol =
      '${urlConfig}/MarektWServices/AddMarketWatchProfileSymbol/'; // profile id and symbol and webcode
  static const GetALLMarketWatch =
      'http://develop.fitoman.com:8080/MobileServicesRamz/MarektWServices/GetALLMarketWatch/'; //webcode
  static const GetCompaniesLookups =
      '${urlConfig}/GeneralWServices/GetCompaniesLookups/';
  static const AddMarketWatchProfileName =
      '${urlConfig}/MarektWServices/AddMarketWatchProfileName/'; // webcode profilename
  static const DeleteMarketWatchProfile =
      '${urlConfig}/MarektWServices/DeleteMarketWatchProfile/'; //profileid webcode
  static const GetSymbolTradesObject =
      '${urlConfig}/RealTimeWServices/GetSymbolTradesObject/'; //webcode symbol
  static const GetSymbolTradesSummaryObject =
      '${urlConfig}/RealTimeWServices/GetSymbolTradesSummaryObject/'; //webcode symbol
  static const GetDailySymbolChart =
      '${urlConfig}/NotificationWServices/GetDailySymbolChart/'; // symbol echange webcode
  static const GetOrderDetails =
      '${urlConfig}/RealTimeWServices/GetOrderDetails/'; // orderID webcode clientID
  static const GetAccountUsers =
      '${urlConfig}/GeneralWServices/GetUserAccounts/'; //webcode
  static const GetAccountSummary =
      '${urlConfig}/FinancialWServices/GetAccSummary/'; // ucode date clientID brokerID
  static const GetAccountPortfiolio =
      '${urlConfig}/FinancialwServices//GetExpectedProfitLoss/'; // mainClientID datatoday clientID BorkerID webcode
  static const GetOrderList =
      '${urlConfig}/RealTimeWServices/GetOrdersList/'; // orderid clientID webcode
  static const GetLookups =
      '${urlConfig}/GeneralWServices/GetLookups/'; //webcode
  static const addOrder =
      '${urlConfig}/RealTimeWServices/AddOrders/'; //sellbuy symbol price webcode VALIDITYCODE IPADDRESS ISALLORNONE ACCOUNTID CLIENTID NIN CUSTODIANID SETT_TYPE TOTALVOLUME ORIGIN
  static const signout = '${urlConfig}/GeneralWServices/UsersLogOff/';
  static const changesPassword =
      '${urlConfig}/GeneralWServices/ChangesPassword';
  static const Statement =
      '${urlConfig}/FinancialWServices/GetGroupByOrderStatmentOfAccount/'; // mainclienrID clientID webcode datefrom dateto
  static const getTrades =
      '${urlConfig}/RealTimeWServices/GetClientTrades/'; //webcode clientID orderID
  static const cancelOrder =
      '${urlConfig}/RealTimeWServices/CancelOrder/{ORDERID}/{IP_ADDRESS}/{WEBCODE}'; //orderID ipAddress webcode
  static const deleteSymbolProfile =
      '${urlConfig}/arektWServices/DeleteMarketWatchProfileSymbol/'; // profileID symbol webcode
  static const getOrderDetails =
      '${urlConfig}/ealTimeWServices/GetOrderDetails/'; // orderID webcode clientID
  static const GetMarketWatchListBySymbol =
      '${urlConfig}/RealTimeWServices/GetMarketWatchListBySymbols/'; // webcode symbol
  static const Timeout = 15;
  static const getClientTrades =
      '${urlConfig}/RealTimewServices/GetClientTrades/'; // webcode clientID orderID
  static const aleartUrl =
      '${urlConfig}/NotificationWServices/AddAlert/'; //{WEBCODE}/{EXCHANGE}/{SYMBOL}/{CONDITION}/{CONDITIONVALUE}/{CONDITIONNAME}/{VALIDITY}/{BYSMS}
  static const clientID = '-1';
  static const orderId = '-1';
  static const transferAmountService =
      '${urlConfig}/FinancialWServices/GetAccountTransferInfo';
  // static const Map<String, String> Cookies = {};
  static String cookieSave = '';
  // Future<ExchangeMarketObject> getExchangeSummaryBYID(String exchangeID) async {
  //   var responseJson = null;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String webcode = prefs.getString('webcode');
  //   try {
  //     final response = await http
  //         .get("$GetSummaryByIDURL$exchangeID" '/' "$webcode", headers: {
  //       'Cookie': '${Config.cookieSave}'
  //     }).timeout(const Duration(seconds: Timeout));
  //
  //     responseJson = _response(response);
  //     ExchangeMarketObject obj = ExchangeMarketObject.fromJson(responseJson);
  //     return Future<ExchangeMarketObject>.value(obj);
  //   } on SocketException {
  //     throw FetchDataException('No Internet connection');
  //   }
  // }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        // print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
