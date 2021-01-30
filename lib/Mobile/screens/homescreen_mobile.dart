import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/tab_navigator/tab_navigator.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;
  GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalObjectKey<ScaffoldState>('HomeScreen');
  LocalStorage _storage = LocalStorage('AlRamz');
  int currect_index = 0;
  String _currentTab = AppStrings.appBarTitleMarket;
  int currentIndex = 1;
  List<String> pageKeys = [
    AppStrings.appBarTitleMarket,
    AppStrings.watch,
    AppStrings.appBarTitleOrders,
    AppStrings.trades,
    AppStrings.appBarTitleAccounts
  ];
  Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    AppStrings.appBarTitleMarket: GlobalKey<NavigatorState>(),
    AppStrings.watch: GlobalKey<NavigatorState>(),
    AppStrings.appBarTitleOrders: GlobalKey<NavigatorState>(),
    AppStrings.trades: GlobalKey<NavigatorState>(),
    AppStrings.appBarTitleAccounts: GlobalKey<NavigatorState>(),
  };
  int count = 5;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getHttp();
// Creates the connection by using the HubConnectionBuilder.
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteCurrentTab =
            !await navigatorKeys[_currentTab].currentState.maybePop();
        if (isFirstRouteCurrentTab) {
          if (_currentTab != AppStrings.appBarTitleMarket) {
            _selectTab(AppStrings.appBarTitleMarket, 1);
            return false;
          }
        }
        return isFirstRouteCurrentTab;
      },
      child: SafeArea(
          child: Scaffold(
        body: Stack(
          children: [
            _buildOffsettageNavigator(AppStrings.appBarTitleMarket),
            _buildOffsettageNavigator(AppStrings.watch),
            _buildOffsettageNavigator(AppStrings.appBarTitleOrders),
            _buildOffsettageNavigator(AppStrings.trades),
            _buildOffsettageNavigator(AppStrings.appBarTitleAccounts),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          child: BottomNavigationBar(
            backgroundColor: AppColors.transperant,
            selectedItemColor: AppColors.white,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.white54,
            selectedIconTheme: IconThemeData(color: Colors.white),
            // unselectedIconTheme: IconThemeData(color: Colors.white54),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 8,
            currentIndex: _selectedTab,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.white54,
                icon: Icon(Icons.multiline_chart_outlined),
                title: Text(
                  getTranslated(context, 'market'),
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white54,
                icon: Icon(Icons.watch_later_outlined),
                title: Text(
                  getTranslated(context, 'marketwatch'),
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white54,
                icon: Icon(Icons.shopping_cart),
                title: Text(
                  getTranslated(context, 'orders'),
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white54,
                icon: Icon(Icons.monetization_on_rounded),
                title: Text(
                  getTranslated(context, 'trades'),
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white54,
                icon: Icon(Icons.person),
                title: Text(
                  getTranslated(context, 'accountName'),
                ),
              ),
            ],
            onTap: (index) {
              _selectTab(pageKeys[index], index);
            },
          ),
        ),
      )),
    );
  }

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentTab) {
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = pageKeys[index];
        currentIndex = index;
      });
    }
  }

  Widget _buildOffsettageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
