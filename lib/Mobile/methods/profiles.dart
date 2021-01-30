import 'dart:convert';

import 'package:alramzapp2021/services/WatchServices/watchprofiles_object.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/statics_value/staticvalues.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

List profileNames = List();
List profileIDs = List();
List symbols = List();
Future<List<WatchProfilesObject>> getExchangeWatchProfiles() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String webcode = prefs.getString('webcode');
  http.Response response = await http.get(
      "http://develop.fitoman.com:8080/MobileServicesRamz/MarektWServices/GetAllProfilesLookupsByUSerCode/$webcode",
      headers: {
        'Cookie': '${Config.cookieSave}'
      }).timeout(const Duration(seconds: Config.Timeout));
  var jsonDate = null;
  print('pofile response code');
  print(response.statusCode);
  List<WatchProfilesObject> list = [];
  if (response.statusCode == 200) {
    jsonDate = json.decode(response.body);
    print('profile body');
    print(jsonDate);
    for (var jsondata in jsonDate) {
      profileIDs.add(jsondata['ProfileID']);
      profileNames.add(jsondata['ProfileName']);
      list.add(WatchProfilesObject.fromJson(jsondata));
    }
    StaticValues.profileName = await profileNames[0];
    StaticValues.profileID = await profileIDs[0];
  } else {
    print('cant able to fetch data from api');
  }
  return list;
}
