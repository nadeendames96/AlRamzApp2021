import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamzApp2021/alramz_app2021/lib/Mobile/screens/mobile_layout.dart';

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide < 600;
    useMobileLayout
        ? SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ])
        : SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft,
          ]);
    return Scaffold(
      // body: useMobileLayout ? Mobile() : Tablet(),
      body: Mobile(),
    );
  }
}
