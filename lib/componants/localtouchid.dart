// import 'package:alramz/mobileassests/screens/homescreen.dart';
// import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:localstorage/localstorage.dart';
// import 'package:ns_utils/utils/sizes.dart';
//
// import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamz/AlRamz2020/alramz/lib/utils/colors.dart';
// import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamz/AlRamz2020/alramz/lib/utils/routes.dart';
//
// class LocalAuthTouch extends StatefulWidget {
//   @override
//   _LocalAuthTouchState createState() => _LocalAuthTouchState();
// }
//
// class _LocalAuthTouchState extends State<LocalAuthTouch> {
//   LocalStorage storage = LocalStorage('AlRamz');
//   // 2. created object of localauthentication class
//   final LocalAuthentication _localAuthentication = LocalAuthentication();
//   // 3. variable for track whether your device support local authentication means
//   //    have fingerprint or face recognization sensor or not
//   bool _hasFingerPrintSupport = false;
//   // 4. we will set state whether user authorized or not
//   String _authorizedOrNot = "Not Authorized";
//   // 5. list of avalable biometric authentication supports of your device will be saved in this array
//   List<BiometricType> _availableBuimetricType = List<BiometricType>();
//
//   Future<void> _getBiometricsSupport() async {
//     // 6. this method checks whether your device has biometric support or not
//     bool hasFingerPrintSupport = false;
//     try {
//       hasFingerPrintSupport = await _localAuthentication.canCheckBiometrics;
//     } catch (e) {
//       print(e);
//     }
//     if (!mounted) return;
//     setState(() {
//       _hasFingerPrintSupport = hasFingerPrintSupport;
//     });
//   }
//
//   Future<void> _getAvailableSupport() async {
//     // 7. this method fetches all the available biometric supports of the device
//     List<BiometricType> availableBuimetricType = List<BiometricType>();
//     try {
//       availableBuimetricType =
//           await _localAuthentication.getAvailableBiometrics();
//     } catch (e) {
//       print(e);
//     }
//     if (!mounted) return;
//     setState(() {
//       _availableBuimetricType = availableBuimetricType;
//     });
//   }
//
//   Future<void> _authenticateMe() async {
//     // 8. this method opens a dialog for fingerprint authentication.
//     //    we do not need to create a dialog nut it popsup from device natively.
//     bool authenticated = false;
//     try {
//       authenticated = await _localAuthentication.authenticateWithBiometrics(
//         localizedReason: "Authenticate for Testing", // message for dialog
//         useErrorDialogs: true, // show error in dialog
//         stickyAuth: true, // native process
//       );
//     } catch (e) {
//       print(e);
//     }
//     if (!mounted)
//       return;
//     else {
//       if (storage.getItem('username') != null &&
//           storage.getItem('password') != null) {
//         AppRoutes.push(context, HomeScreen());
//       } else {
//         // Fluttertoast.showToast(
//         //     msg: 'please use login button to register Fingerprint/faceID',
//         //     backgroundColor: AppColors.red,
//         //     textColor: AppColors.white,
//         //     toastLength: Toast.LENGTH_LONG);
//       }
//     }
//     setState(() {
//       _authorizedOrNot = authenticated ? "Authorized" : "Not Authorized";
//     });
//   }
//
//   @override
//   void initState() {
//     _getBiometricsSupport();
//     _getAvailableSupport();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           color: AppColors.white,
//           child: IconButton(
//               icon: Icon(
//                 Icons.fingerprint_rounded,
//                 color: AppColors.lightgreen,
//                 size: Sizes.s300,
//               ),
//               onPressed: _authenticateMe),
//         ),
//       ),
//     );
//   }
// }
