import 'package:alramzapp2021/services/aleartsetups/aleartservice.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<AleartSetupsObject> addAleart(
    String selectMarket,
    String symbol,
    String mySelection3,
    String value,
    String mySelection2,
    DateTime today,
    String isSms) async {
  var jsonResponse = null;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String webcode = prefs.getString('webcode');
  print(
      '${Config.aleartUrl}$webcode/$selectMarket/$symbol/$mySelection3/$value/$mySelection2/${today}/$isSms');
  var response = await http.post(
    '${Config.aleartUrl}$webcode//$selectMarket/$symbol/$mySelection3/$value/$mySelection2/${today}/$isSms',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Cookie': '${Config.cookieSave}'
    },
  ).timeout(Duration(seconds: Config.Timeout));
  print(response.statusCode);
  if (response.statusCode == 200) {
    Fluttertoast.showToast(msg: 'OK');
  } else {
    Fluttertoast.showToast(msg: 'not ok');
  }
}
