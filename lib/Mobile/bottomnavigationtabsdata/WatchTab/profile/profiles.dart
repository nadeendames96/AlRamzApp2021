import 'dart:ui';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/Models/watchmodel.dart';
import 'package:alramzapp2021/Mobile/important/passwordscreen.dart';
import 'package:alramzapp2021/Mobile/screens/loginscreen_mobile.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/menues/menupopup.dart';
import 'package:alramzapp2021/services/WatchServices/watchprofiles_object.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExchangeWatches.dart';
import 'package:alramzapp2021/settings/settings.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addprofile.dart';
import 'deleteprofile.dart';

class Profiles extends StatefulWidget {
  @override
  _ProfilesState createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  String ProfileName = '';
  String profileID = '';
  Future<List<WatchProfilesObject>> profilefuture =
      ExchangesWatches().getExchangeWatchProfiles();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profilefuture = ExchangesWatches().getExchangeWatchProfiles();
  }

  LocalStorage storage = LocalStorage('AlRamz');
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
            child: Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'profiles'),
          style: TextStyleApplied.TextNormal,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: AppColors.white,
            ),
          ),
          Hero(
            tag: 'kdfjeiofeiofufijef',
            child: PopupMenuButton<String>(
              offset: Offset(0, 100),
              onSelected: choiceAction,
              icon: Icon(
                Icons.menu,
                size: Sizes.s25,
              ),
              itemBuilder: (BuildContext context) {
                return MenuPopUpMobile.choice.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice, style: TextStyleApplied.Text),
                  );
                }).toList();
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: AppColors.white,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: AppColors.white,
            ),
            onPressed: () {
              setState(() {
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) {
                      return AddProfile();
                    }));
              });
            },
          ),
        ],
      ),
      body: ProfilesName(),
    )));
  }

  Widget ProfilesName() {
    return SingleChildScrollView(
      child: FutureBuilder<List<WatchProfilesObject>>(
        future: profilefuture,
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        ProfileName = snapshot.data[index].profileName;
                        profileID = snapshot.data[index].profileID;
                        storage.setItem('profileName', ProfileName);
                        storage.setItem('profileID', profileID);
                        AppRoutes.push(context, WatchModel());
                      });
                    },
                    title: Text(
                      snapshot.data[index].profileName,
                      style: TextStyleApplied.Text,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: AppColors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          profileID = snapshot.data[index].profileID;
                          storage.setItem('profileID', profileID);
                          Navigator.of(context).push(PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) {
                                return DeleteProfile();
                              }));
                        });
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  void choiceAction(Action) async {
    //    print("Mune PopUp");
    if (Action == MenuPopUpMobile.change_password) {
      AppRoutes.push(context, Changepassword());
    } else if (Action == MenuPopUpMobile.settings) {
      AppRoutes.push(context, Settings());
    } else if (Action == MenuPopUpMobile.sign_out) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String webcode = prefs.getString('webcode');
      http.Response response = await http.post(
        '${Config.signout}$webcode',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: null,
      );
      if (response.statusCode == 200) {
        Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
        prefs.clear();
        prefs.commit();
      } else {
        throw Exception('cant sign out by api');
      }
    }
  }
}
