import 'dart:convert';

import 'package:alramzapp2021/Mobile/screens/loginscreen_mobile.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/menues/menupopup.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/services/general_service/changepassword_object.dart';
import 'package:alramzapp2021/settings/settings.dart';
import 'package:alramzapp2021/utils/assets.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Changepassword extends StatefulWidget {
  static String newPassword = '';
  @override
  _ChangepasswordState createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalObjectKey<ScaffoldState>('ChangePassword');
  TextEditingController oldPassword = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  final String image;
  final double size;

  _ChangepasswordState({this.image, this.size});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            actions: <Widget>[
              Image(
                image: AssetImage(image ?? Assets.ramzicon),
                height: size ?? Sizes.s20,
                width: size ?? Sizes.s20,
                fit: BoxFit.contain,
              ),
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: AppColors.white,
                  size: Sizes.s25,
                ),
              ),
              Hero(
                tag: 'heroMenuPopup44432',
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
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ),
            ],
          ),
          body: Hero(
              tag: "password",
              child: Container(
                  child: ListView(children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: Sizes.s8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: Sizes.s20,
                            ),
                            Text(
                              getTranslated(context, 'changePassword'),
                              textAlign: TextAlign.left,
                              style: TextStyleApplied.Text,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: Sizes.s10),
                        width: double.infinity,
                        child: Column(children: <Widget>[
                          TextFormField(
                              controller: password,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText:
                                      getTranslated(context, 'oldPassword'),
                                  labelStyle:
                                      TextStyle(color: AppColors.white)),
                              style: TextStyleApplied.Text),
                        ]),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.only(left: Sizes.s10),
                        width: double.infinity,
                        child: Column(children: <Widget>[
                          TextFormField(
                              controller: password,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: getTranslated(context, 'password'),
                                  labelStyle:
                                      TextStyle(color: AppColors.white)),
                              style: TextStyleApplied.Text),
                        ]),
                      ),
                      Divider(),
                      Container(
                        padding:
                            EdgeInsets.only(left: Sizes.s10, right: Sizes.s10),
                        width: double.infinity,
                        child: Column(children: <Widget>[
                          TextFormField(
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              controller: confirmPassword,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText:
                                      getTranslated(context, 'conpassword'),
                                  labelStyle:
                                      TextStyle(color: AppColors.white)),
                              style: TextStyleApplied.Text),
                        ]),
                      ),
                      SizedBox(
                        height: Sizes.s10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: Sizes.s10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: Sizes.s200,
                                height: Sizes.s40,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.white)),
                                child: SizedBox.expand(
                                  child: FlatButton(
                                    child: Text(
                                      getTranslated(context, 'save'),
                                      style: TextStyleApplied.Text,
                                    ),
                                    onPressed: () {
                                      if (password.text ==
                                          confirmPassword.text) {
                                        saveNewPassword(
                                            password.text,
                                            confirmPassword.text,
                                            oldPassword.text);
                                      } else {
                                        // Fluttertoast.showToast(
                                        //   msg: getTranslated(context,
                                        //       'passwordnotmatchconfirmedpassword'),
                                        //   textColor: Colors.white,
                                        //   toastLength: Toast.LENGTH_LONG,
                                        //   gravity: ToastGravity.TOP_LEFT,
                                        //   backgroundColor: Colors.red,
                                        // );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ])
              ])))),
    );
  }

  Future<ChangePassword> saveNewPassword(
      newpassword, newpassword2, oldPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String UserName = prefs.getString('username');
    String webCode = prefs.getString('webcode');
    String ipAddress = prefs.getString('ipAddress');
    String mobType = prefs.getString('mobType');
    var response = await http
        .post('${Config.changesPassword}',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              "UserName": UserName, //Security.User.Username,
              "Password": newpassword,
              "Password2": newpassword2,
              "MobileType": mobType,
              "SessionID": "",
              "UserIPAddress": ipAddress,
              "TokenID": "",
              "WebCode": webCode,
              "OldPassword": oldPassword,
            }))
        .timeout(const Duration(seconds: 15));
    var jsonData = null;
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      print(jsonData);
      if (jsonData['Status'] == '0') {
        // Fluttertoast.showToast(
        //   msg: getTranslated(context, 'passwordchangeed'),
        //   textColor: Colors.white,
        //   toastLength: Toast.LENGTH_LONG,
        //   gravity: ToastGravity.TOP_LEFT,
        //   backgroundColor: Colors.green,
        // );
        SharedPreferences perfs = await SharedPreferences.getInstance();
        await perfs.remove('oldpassword');
        Navigator.pop(context);
      } else {
        // Fluttertoast.showToast(
        //   msg: getTranslated(context, 'passwordcountspecialchar_X0'),
        //   textColor: Colors.white,
        //   toastLength: Toast.LENGTH_LONG,
        //   gravity: ToastGravity.TOP_LEFT,
        //   backgroundColor: Colors.red,
        // );
      }
    }
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
