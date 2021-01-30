import 'dart:convert';

import 'package:alramzapp2021/services/OrdersService/getorderlist_object.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<GetOrderListObject>> getOrdersList(String clientID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String webcode = prefs.getString('webcode');
  http.Response response = await http
      .get("${Config.GetOrderList}/$clientID/$webcode")
      .timeout(const Duration(seconds: Config.Timeout));
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

    // StaticValues.symbolOrder = await symbol[0];
    // StaticValues.exchnageOrder = await exchange[0];
    // StaticValues.orderID = await orderID[0];
    // StaticValues.accountIDOrder = await accountId[0];
    // StaticValues.accountOrder = await account[0];
    // StaticValues.typeOrder = await type[0];
    // StaticValues.qunOrder = await qun[0];
    // StaticValues.priceOrder = await price[0];
    // StaticValues.validOrder = await valid[0];
    // StaticValues.dateOrder = await date[0];
    // StaticValues.reminigQunOrder = await reminingQun[0];
    // StaticValues.avgOrder = await avg[0];
    // StaticValues.statusOrder = await status[0];
    // StaticValues.reasonOrder = await reason[0];
    // StaticValues.minFillOrder = await minFil[0];
    // StaticValues.visibleQunOrder = await visibleQun[0];
    // StaticValues.remarksOrder = await remarks[0];
  } else {
    print('cant able to fetch data from api');
  }
  return list;
}
