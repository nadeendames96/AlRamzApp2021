import 'dart:convert';

import 'package:alramzapp2021/Mobile/screens/loginscreen_mobile.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homescreen_mobile.dart';

class LocalAuthTouch extends StatefulWidget {
  @override
  _LocalAuthTouchState createState() => _LocalAuthTouchState();
}

class _LocalAuthTouchState extends State<LocalAuthTouch> {
  LocalStorage storage = LocalStorage('AlRamz');
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  initState() {
    super.initState();
    authenticate();
  }

  authenticate() async {
    if (await _isBiometricAvailable()) {
      await _getListOfBiometricTypes();
      await _authenticateUser();
    }
  }

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = await _localAuthentication.canCheckBiometrics;
    return isAvailable;
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics =
        await _localAuthentication.getAvailableBiometrics();
  }

  void _setCookies(http.Response response) {
    String cookie = response.headers['set-cookie'];
    if (cookie != null) {
      int index = cookie.indexOf(';');
      String _cookie = ((index == -1) ? cookie : cookie.substring(0, index));
      print('setCookie ' + _cookie);
      if (LoginScreen.Cookies.containsKey('cookie')) {
        LoginScreen.Cookies['cookie'] = _cookie;
        Config.cookieSave = LoginScreen.Cookies['cookie'];
      }
      // print('sss ' + Cookies.toString());
      // print('Config Cookie ' + Config.cookieSave);
    }
  }

  Future<void> _authenticateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    bool isAuthenticated =
        await _localAuthentication.authenticateWithBiometrics(
      localizedReason: "Use a biometric para possessor",
      useErrorDialogs: true,
      stickyAuth: true,
    );

    if (isAuthenticated) {
      if (storage.getItem('webcode') == webcode) {
        Fluttertoast.showToast(msg: Config.urlConfig);
        final http.Response response = await http
            .post(Config.UserAuthintications,
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  'Cookie': '${Config.cookieSave}',
                },
                body: jsonEncode(<String, String>{
                  'UserName': storage.getItem('username'),
                  'Password': storage.getItem('password'),
                  'MobileType': storage.getItem('mobiletype'),
                  'SessionID': '',
                  'UserIPAddress': storage.getItem('ipaddress'),
                  'TokenID': '',
                  'HdnKey': '',
                  'FingerPrintID': '',
                  'FingerPrintLevel': '',
                }))
            .timeout(Duration(seconds: Config.Timeout));
        if (response.statusCode == 200) {
          // _setCookies(response);
          if (storage.getItem('webcode') == prefs.getString('webcode')) {
            // AppRoutes.push(context, HomeScreen());
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen()),
                (Route<dynamic> route) => false);
          } else {
            //await storage.clear();
            // AppRoutes.push(context, HomeScreen());
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen()),
                (Route<dynamic> route) => false);
          }
        }

        // LoginScreen().createState().signIn(storage.getItem('username'), storage.getItem('password'), storage.getItem('mobiletype'), '', storage.getItem('ipaddress'),
        //     '', '', '', '');
      } else {
        Fluttertoast.showToast(
            msg: getTranslated(context, 'EnableFingerprintFaceID'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
