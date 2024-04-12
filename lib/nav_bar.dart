import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pastel/feactures/app/constants.dart';
import 'package:pastel/feactures/app/pages/home/home_screen.dart';
import 'package:pastel/feactures/app/pages/order/order_page.dart';
import 'package:pastel/feactures/app/pages/profile/profile_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  Stream<User?> _userStream = FirebaseAuth.instance.authStateChanges();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        final user = snapshot.data;
        return PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(user),
          items: _navBarsItems(user),
          confineInSafeArea: true,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style7, // Choose the nav bar style with this property.
        );
      },
    );
  }

  List<Widget> _buildScreens(User? user) {
    return [
      HomeScreen(),
      const OrderPage(),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(User? user) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home, color: CupertinoColors.black),
        title: ("Home"),
        activeColorPrimary: yellowPastel,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      // if (user != null)
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.ticket, color: CupertinoColors.black),
        title: ("Settings"),
        activeColorPrimary: yellowPastel,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings, color: CupertinoColors.black),
        title: ("Settings"),
        activeColorPrimary: yellowPastel,
        inactiveColorPrimary: CupertinoColors.black,
      ),
    ];
  }
}
