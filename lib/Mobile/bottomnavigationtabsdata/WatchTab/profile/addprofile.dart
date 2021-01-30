import 'dart:convert';
import 'dart:ui';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/profile/profiles.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/services/WatchServices/AddProfileName_object.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProfile extends StatefulWidget {
  @override
  _AddProfileState createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  TextEditingController profile = TextEditingController();
  LocalStorage storage = LocalStorage('AlRamz');
  String profileID = '';
  String symbol = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileID = storage.getItem('profileID');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    profile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.90,
        child: Scaffold(
            body: Container(
          margin: EdgeInsets.only(top: Sizes.s100),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Opacity(
            opacity: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      getTranslated(context, 'createanewprofile'),
                      style: TextStyle(
                          color: AppColors.white, fontSize: FontSizes.s20),
                    ),
                    Hero(
                      tag: 'profilebackff',
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: AppColors.red,
                          size: Sizes.s40,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Sizes.s30,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    color: AppColors.white,
                    // ignore: missing_required_param
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: profile,
                            style: TextStyleApplied.TextBlack,
                            decoration: InputDecoration(
                              hintText:
                                  getTranslated(context, 'createanewprofile'),
                              hintStyle: TextStyleApplied.TextBlack,
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: Sizes.s10),
                  color: AppColors.lightgreen2,
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        AddProfileUser(profile.text);
                      });
                    },
                    color: AppColors.lightgreen2,
                    child: Text(
                      getTranslated(context, 'create'),
                      style: TextStyleApplied.Text,
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }

  Future<AddProfileName> AddProfileUser(
    profilename,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    final http.Response response = await http.post(
        '${Config.AddMarketWatchProfileName}$webcode/$profilename',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'profileName': profilename}));
    var jsonData = null;
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (BuildContext context) => Profiles()),
      //     (Route<dynamic> route) => false);
      AppRoutes.push(context, Profiles());
    } else {
      throw Exception('cant fetch data from api');
    }
  }
}
