import 'dart:convert';

import 'package:alramzapp2021/services/aleartsetups/getalertobject.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class ExchnageAlearts {
  Future<List<GetAlertObject>> getAlerts() async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    String webcode = prfs.getString('webcode');
    var response = await http.get('${Config.getAlert}$webcode', headers: {
      'Cookie': '${Config.cookieSave}'
    }).timeout(Duration(seconds: Config.Timeout));
    print('${Config.getAlert}$webcode');
    print('alert status code');
    print(response.statusCode);

    var jsonResponse = null;
    List<GetAlertObject> list = List<GetAlertObject>();
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      for (var jsonresponse in jsonResponse) {
        list.add(GetAlertObject.fromJson(jsonresponse));
      }
    } else {
      throw Exception('cant get data from service');
    }
    return list;
  }
}
