import 'package:alramzapp2021/services/config.dart';
import 'package:signalr_flutter/signalr_flutter.dart';

class SignalRConnectionService {
  static SignalR connection;
  static String _signalRStatus = 'Unknown';
  static String _signalRStatusIndex = 'Unknown';
  static var jsondata = null;
  static List jsonData = [];
  static List jsonDataIndex = [];
  static String exchangeID = 'DFM';
  static String currentValue2 = '',
      TurnOver = '',
      TotalExecuted = '',
      NetChange = '',
      NetChangePerc = '',
      Volume = '',
      SymbolsTraded = '';

  static Future<void> initPlatformState(
      _onStatusChange, _onNewMessage, methodName) async {
    connection = SignalR(
        'http://109.107.237.83:8080/MobileServices/sr/signalr/hubs', "MyHub",
        headers: {'Cookie': '${Config.cookieSave}'},
        // hubMethods: ['sendExchangeMarketObject'],
        hubMethods: methodName,
        statusChangeCallback: _onStatusChange,
        hubCallback: _onNewMessage);
    await connection.connect();
    // _invokedMethods();
  }

//   static _onStatusChange(dynamic status) {
//     _signalRStatus = status as String;
//     _signalRStatusIndex = status as String;
//     Fluttertoast.showToast(msg: _signalRStatus);
//
// //    Fluttertoast.showToast(msg: 'index ' + _signalRStatusIndex);
//   }
//
// //   static void _invokedMethods() async {
// //     final res = await connection
// //         .invokeMethod('getMarketIndexObject', arguments: ['DFM', '50']);
// //     jsonDataIndex = json.decode(res);
// //   }
// // }
//
//   static _onNewMessage(String methodName, dynamic message) {
//     print('MethodName = $methodName, Message = $message');
//     jsonData = json.decode(message);
//     print('jsonDataSignalR');
//     print(jsonData);
//     for (var jsondata in jsonData) {
//       if (exchangeID == jsondata['ExchangeID']) {
//         currentValue2 = jsondata['CurrentValue'];
//         TurnOver = jsondata['TurnOver'];
//         NetChange = jsondata['NetChange'];
//         NetChangePerc = jsondata['NetChangePerc'];
//         Volume = jsondata['Volume'];
//         TotalExecuted = jsondata['TotalExecuted'];
//         SymbolsTraded = jsondata['SymbolsTraded'];
//       } else {}
//     }
//   }
}
