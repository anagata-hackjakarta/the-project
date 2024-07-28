import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:safina/config/them.dart';
import 'package:safina/pages/loginPage.dart';
import 'package:safina/pages/registerPage.dart';
import 'package:safina/screens/accountScreen.dart';
import 'package:safina/screens/homeScreen.dart';
import 'package:safina/screens/playScreen.dart';

import '../screens/behaviorScreen.dart';
import '../screens/notifScreen.dart';
import '../widgets/alertScreen.dart';
import '../widgets/customNavbarWidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    List<Widget> _buildScreens() {
      return [
        HomeScreen(),
        BehaviorScreen(),
        Playscreen(),
        // AlertScreen(),
        NotificationScreen(),
        AccountScreen()
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: ThemeConfig.primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          // scrollController: _scrollController1,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: "/",
            routes: {
              "/first": (final context) => LoginPage(),
              "/second": (final context) => RegisterPage(),
              "/3": (final context) => HomeScreen(),
            },
          ),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.insert_chart_sharp),
          title: ("MyDrive"),
          activeColorPrimary: ThemeConfig.primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          // scrollController: _scrollController2,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: "/",
            routes: {
              "/first": (final context) => LoginPage(),
              "/second": (final context) => RegisterPage(),
              "/3": (final context) => HomeScreen(),

            },
          ),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.play_arrow),
          title: ("START"),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          // scrollController: _scrollController2,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: "/",
            routes: {
              "/first": (final context) => LoginPage(),
              "/second": (final context) => RegisterPage(),
              "/3": (final context) => HomeScreen(),

            },
          ),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.messenger),
          title: ("Message"),
          activeColorPrimary: ThemeConfig.primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          // scrollController: _scrollController2,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: "/",
            routes: {
              "/first": (final context) => LoginPage(),
              "/second": (final context) => RegisterPage(),
              "/3": (final context) => HomeScreen(),
            },
          ),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          title: ("Account"),
          activeColorPrimary: ThemeConfig.primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          // scrollController: _scrollController2,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: "/",
            routes: {
              "/first": (final context) => LoginPage(),
              "/second": (final context) => RegisterPage(),
              "/3": (final context) => HomeScreen(),
            },
          ),
        ),
      ];
    }

    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      padding: const EdgeInsets.symmetric(vertical: 15),
      backgroundColor: Colors.white,
      isVisible: true,
      confineToSafeArea: true,
      navBarHeight: 80,
      navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property
    );
  }
}
