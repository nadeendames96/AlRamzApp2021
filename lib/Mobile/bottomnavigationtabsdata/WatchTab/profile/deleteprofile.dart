import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/profile/profiles.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/services/WatchServices/watchprofiles_object.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:ns_utils/src.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteProfile extends StatefulWidget {
  @override
  _DeleteProfileState createState() => _DeleteProfileState();
}

class _DeleteProfileState extends State<DeleteProfile> {
  Future<WatchProfilesObject> deleteProfile(String profileID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    final http.Response response = await http.post(
      '${Config.DeleteMarketWatchProfile}$profileID/$webcode',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      AppRoutes.push(context, Profiles());
    } else {
      throw Exception('Failed to delete profile.');
    }
  }

  String profileID = '';
  LocalStorage storage = LocalStorage('AlRamz');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileID = storage.getItem('profileIDMobile');
    if (profileID != null) {
      profileID = storage.getItem('profileIDMobile');
    } else {
      profileID = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.90,
      child: Card(
        child: AlertDialog(
          title: Text(getTranslated(context, 'attention')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  getTranslated(context, 'areyousuretodelete'),
                  style: TextStyleApplied.Text,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    color: AppColors.lightgreen2,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          getTranslated(context, 'yes'),
                          style: TextStyleApplied.Text,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              Delete();
                            },
                          );
                        })),
                SizedBox(
                  height: Sizes.s5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  color: AppColors.lightgreen2,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(getTranslated(context, 'no'),
                        style: TextStyleApplied.Text),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget Delete() {
    return FutureBuilder<WatchProfilesObject>(
      future: deleteProfile(profileID),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Text('${snapshot.error}');
        } else {
          return Back();
        }
      },
    );
  }

  Widget Back() {
    setState(() {
      Navigator.pop(context);
    });
  }
}
