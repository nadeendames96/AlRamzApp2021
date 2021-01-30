import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alramzapp2021/Mobile/methods/getexchangesummary.dart';
import 'package:alramzapp2021/Mobile/methods/profiles.dart';
import 'package:alramzapp2021/Mobile/screens/token_mobile.dart';
import 'package:alramzapp2021/componants/app_button.dart';
import 'package:alramzapp2021/componants/applogowidset.dart';
import 'package:alramzapp2021/componants/apptotch.dart';
import 'package:alramzapp2021/componants/background.dart';
import 'package:alramzapp2021/componants/passwordencription/password.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/services/Models/userinfo.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExcahngesAccounts.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/strings.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:ns_utils/src.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homescreen_mobile.dart';
import 'local_auth mobile.dart';

class LoginScreen extends StatefulWidget {
  static Map<String, String> Cookies = {};
  static void _setCookies(http.Response response) {
    String cookie = response.headers['set-cookie'];
    if (cookie != null) {
      int index = cookie.indexOf(';');
      String _cookie = ((index == -1) ? cookie : cookie.substring(0, index));
      print('setCookie ' + _cookie);
      if (Cookies.containsKey('cookie')) {
        Cookies['cookie'] = _cookie;
        Config.cookieSave = Cookies['cookie'];
      } else
        Cookies.add(key: 'cookie', value: _cookie);
      Config.cookieSave = Cookies['cookie'];
    }
    // print('sss ' + Cookies.toString());
    // print('Config Cookie ' + Config.cookieSave);
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool connected = false;
  int count = 2;
  Timer timer;
  static String UserNameUser = '';
  static String PasswordUser = '';
  static String UserIPAddress;
  static String deviceName;
  static String deviceVersion;
  static String identifier;
  static List<String> MobileType = [];
  GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalObjectKey<ScaffoldState>('LoginScreen');
  bool _isLoading = false;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    // _getBiometricsSupport();
    // _checkBiometric();
    // _getListOfBiometricTypes();
    isChecked = storage.getItem('isChecked');
    if (isChecked != null) {
      isChecked = storage.getItem('isChecked');
    } else {
      isChecked = false;
    }
    getDeviceDetails();
    NetworkInterface.list(includeLoopback: false, type: InternetAddressType.any)
        .then((List<NetworkInterface> interfaces) {
      setState(() {
        UserIPAddress = "";
        interfaces.forEach((interface) {
          int i = 0;
          interface.addresses.forEach((address) {
            UserIPAddress += "${address.address}";
          });
        });
      });
    });
    isRememberMe(isChecked);
  }

  int countLogin = 0;

  static Future<List<String>> getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId;
        if (MobileType.isEmpty) {
          MobileType.add(deviceName);
          MobileType.add(deviceVersion);
          MobileType.add(identifier);
        } else {
          MobileType.clear();
          MobileType.add(deviceName);
          MobileType.add(deviceVersion);
          MobileType.add(identifier);
        }
        //UUID for Android
      } else if (Platform.isIOS) {
        MobileType.clear();
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor;

        if (MobileType.isEmpty) {
          MobileType.add(deviceName);
          MobileType.add(deviceVersion);
          MobileType.add(identifier); //UUID for iOS
        } else {
          MobileType.clear();
          MobileType.add(deviceName);
          MobileType.add(deviceVersion);
          MobileType.add(identifier);
        }
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

    return MobileType;
  }

  final LocalStorage storage = new LocalStorage('AlRamz');
  bool isChecked = false;

  void isRememberMe(bool isCheckedBox) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isChecked = isCheckedBox;
      storage.setItem('isChecked', isChecked);
      if (isChecked) {
        usernameController.text = prefs.getString('username');
      } else {
        usernameController.text = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Form(
          key: _formKey,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              BackgroundImageWidget(),
              ListView(
                children: <Widget>[
                  Center(
                    child: AppLogoWidget(
                      padding: Sizes.defaultSpace,
                    ),
                  ),
                  SizedBox(
                    height: Sizes.s50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.s20,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border:
                            Border(bottom: BorderSide(color: AppColors.black)),
                      ),
                      height: Sizes.s50,
                      child: TextFormField(
                        controller: usernameController,
                        cursorColor: Colors.white,
                        style: TextStyleApplied.TextBlack,
                        decoration: InputDecoration(
                            hintText: getTranslated(context, 'username'),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70)),
                            hintStyle: TextStyleApplied.TextBlack),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.s20,
                      ),
                      child: Container(
                        height: Sizes.s50,
                        color: AppColors.white,
                        child: TextFormField(
                          controller: passwordController,
                          cursorColor: Colors.white,
                          obscureText: true,
                          style: TextStyleApplied.TextBlack,
                          decoration: InputDecoration(
                              hintText: getTranslated(context, 'password'),
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white70)),
                              hintStyle: TextStyleApplied.TextBlack),
                        ),
                      )),
                  SizedBox(
                    height: Sizes.s10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.s10,
                    ),
                    child: Row(
                      children: <Widget>[
                        Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.white),
                          child: Checkbox(
                            value: isChecked,
                            checkColor: Colors.green,
                            activeColor: Colors.white,
                            onChanged: isRememberMe,
                          ),
                        ),
                        // Text(
                        //   MobileType
                        // ),
                        // Text(
                        //    _networkInterface
                        // ),
                        Text(
                          getTranslated(context, 'rememberme'),
                          style: TextStyleApplied.Text,

//                          style: kLabelStyle,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: Sizes.s20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Sizes.s10, right: Sizes.s10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AppButton(
                          onTap: usernameController.text == "" ||
                                  passwordController.text == ""
                              ? null
                              : () {
                                  setState(() {
                                    // InternetChecker().checkConnection(context);
                                    _isLoading = true;
                                  });
                                  signIn(
                                    usernameController.text,
                                    passwordController.text,
                                    MobileType,
                                    '',
                                    UserIPAddress,
                                    '',
                                    '',
                                    '',
                                    '',
                                  );
                                },
                          text: getTranslated(context, 'login'),
                        ),
                        // _canCheckBiometric
                        //     ?
                        AppTouchIDWidget(
                          onTap: () {
                            AppRoutes.push(context, LocalAuthTouch());
                          },
                          // onPressed: _authenticateMe,
                        )
                        // : Container(),
                      ],
                    ),
                  ),
                  Container(
                    height: Sizes.s20,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.version,
                          style: TextStyleApplied.Text,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<UserInfo> signIn(UserName, Password, MobileType, SessionID,
      UserIPAddress, TokenID, HdnKey, FingerPrintID, FingerPrintLevel) async {
    var jsonResponse = null;
    getFtchDate();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserNameUser = Encription.encryptedString(UserName);
    PasswordUser = Encription.encryptedString(Password);
    try {
      final http.Response response = await http
          .post(Config.UserAuthintications,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'UserName': UserNameUser,
                'Password': PasswordUser,
                'MobileType': MobileType.toString(),
                'SessionID': SessionID,
                'UserIPAddress': UserIPAddress,
                'TokenID': TokenID,
                'HdnKey': HdnKey,
                'FingerPrintID': FingerPrintID,
                'FingerPrintLevel': FingerPrintLevel,
              }))
          .timeout(Duration(seconds: Config.Timeout));
      print('Login StausCode ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        print('status user login ');
        print(jsonResponse['Status']);
        if (jsonResponse['Status'] == '0') {
          LoginScreen._setCookies(response);
          prefs.setString('webcode', jsonResponse['WebCode']);
          prefs.setString('brokerid', jsonResponse['BrokerID']);
          prefs.setString('CompInit', jsonResponse['CompInit']);
          prefs.setString('ucode', jsonResponse['UCode']);
          prefs.setString('UserType', jsonResponse['UserType']);
          prefs.setString('ipAddress', UserIPAddress);
          prefs.setString('username', jsonResponse['UserName']);
          prefs.setString('password', jsonResponse['Password']);
          prefs.setString('mobType', MobileType.toString());
          storage.setItem('username', UserNameUser);
          storage.setItem('password', PasswordUser);
          storage.setItem('mobiletype', MobileType.toString());
          storage.setItem('ipaddress', UserIPAddress);
          Fluttertoast.showToast(
            msg: getTranslated(context, 'loggedinsuccessfully'),
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP_LEFT,
            backgroundColor: Colors.green,
          );
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
        } else if (jsonResponse['Status'] == '-1') {
          storage.setItem('username', UserName);
          Fluttertoast.showToast(
            msg: getTranslated(context, 'invalidusernamepassword'),
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP_LEFT,
            backgroundColor: Colors.red,
          );
        } else if (jsonResponse['Status'] == '-3') {
          LoginScreen._setCookies(response);
          prefs.setString('webcode', jsonResponse['WebCode']);
          prefs.setString('brokerid', jsonResponse['BrokerID']);
          prefs.setString('CompInit', jsonResponse['CompInit']);
          prefs.setString('ucode', jsonResponse['UCode']);
          prefs.setString('UserType', jsonResponse['UserType']);
          prefs.setString('ipAddress', UserIPAddress);
          prefs.setString('username', jsonResponse['UserName']);
          prefs.setString('password', jsonResponse['Password']);
          prefs.setString('mobType', MobileType.toString());
          storage.setItem('username', UserName);
          storage.setItem('password', Password);
          storage.setItem('mobiletype', MobileType.toString());
          storage.setItem('ipaddress', UserIPAddress);
          Fluttertoast.showToast(
            msg: getTranslated(context, 'tokenIDrequired'),
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP_LEFT,
            backgroundColor: Colors.green,
          );
          if (storage.getItem('webcode') == prefs.getString('webcode')) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (BuildContext context) => Token()),
                (Route<dynamic> route) => false);
          } else {
            //await storage.clear();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (BuildContext context) => Token()),
                (Route<dynamic> route) => false);
          }
        } else if (jsonResponse['Status'] == '-7') {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: AppColors.primary.withOpacity(.3),
                  title: Text(getTranslated(context, 'confirmchange')),
                  content: Text(getTranslated(context, 'userAlreadyLoggedIn')),
                  actions: <Widget>[
                    Column(
                      children: [
                        Container(
                          color: AppColors.light_green,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: FlatButton(
                                onPressed: () {
                                  signIn(
                                      UserName,
                                      Password,
                                      MobileType,
                                      SessionID,
                                      UserIPAddress,
                                      '1',
                                      HdnKey,
                                      FingerPrintID,
                                      FingerPrintLevel);
                                },
                                child: Text(getTranslated(context, 'yes'))),
                          ),
                        ),
                        SizedBox(
                          height: Sizes.s5,
                        ),
                        Container(
                          color: AppColors.light_green,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: FlatButton(
                                onPressed: () {
                                  AppRoutes.pop(context);
                                },
                                child: Text(getTranslated(context, 'no'))),
                          ),
                        )
                      ],
                    )
                  ],
                );
              });

          Fluttertoast.showToast(
            msg: response.request.toString(),
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP_LEFT,
            backgroundColor: Colors.red,
          );
        }
        String webcode = prefs.getString('webcode');
        storage.setItem('webcode', webcode);
      } else {
        throw Exception('cant able to get data');
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
    } on SocketException catch (e) {
      print('Socket Error: $e');
    } on Error catch (e) {
      print('General Error: $e');
    }
  }

  getFtchDate() {
    count = 2;
    if (timer != null) {
      timer.cancel();
    }
    timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        if (count > 0) {
          getExchangeWatchProfiles();
          getExchangeSummary();
          // ExtangesMarkets().getExchangeSummary();
          ExchangesAccounts().getAccountInfo();
          count--;
        } else {
          timer.cancel();
        }
      });
    });
  }
}
