// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pastel/feactures/app/constants.dart';
import 'package:pastel/offline/screens/home/home_screen_guest.dart';
import 'package:pastel/offline/screens/profile/profile_user_guest.dart';
import 'package:pastel/feactures/app/pages/home/home_screen.dart';
import 'package:pastel/feactures/app/pages/order/order_page.dart';
import 'package:pastel/feactures/app/pages/profile/profile_user.dart';
//Importando las 'Pages' tab.

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  //Arreglo de objetos.
  final List<Widget> _widgetOptions = [
    HomeScreen(),
    OrderPage(),
    const ProfieUser(),
  ];

  final List<Widget> _widgetOptionsGuest = [
    HomeScreenGuest(),
    const ProfileUserGuest(),
  ];

  //declaracion variable tipo entero para jugar con los indices del arreglo.
  int _selectedItem = 0;
  int _selectedItemGuest = 0;

  // Obtén el usuario actual
  void _cambioWidgetGuest(int index) {
    setState(() {
      _selectedItemGuest = index;
    });
  }

  void _cambioWidget(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user;
    try {
      user = FirebaseAuth.instance.currentUser;
    } on FirebaseException {
      return Scaffold(
        body: _widgetOptions.elementAt(_selectedItemGuest),
        bottomNavigationBar: _bottomNavBar(context),
      );
    }

    if (user != null) {
      return Scaffold(
        body: _widgetOptions.elementAt(_selectedItem),
        bottomNavigationBar: _bottomNavBar(context),
      );
    } else {
      return Scaffold(
        body: _widgetOptionsGuest.elementAt(_selectedItemGuest),
        bottomNavigationBar: _bottomNavBarGuest(context),
      );
    }
  }

  Widget _bottomNavBarGuest(BuildContext context) {
    return BottomNavigationBar(
        iconSize: 30.0,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedItemGuest,
        onTap: _cambioWidgetGuest,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: yellowPastel),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined, color: yellowPastel),
            label: 'Perfil',
          ),
        ]);
  }

  Widget _bottomNavBar(BuildContext context) {
    return BottomNavigationBar(
        iconSize: 30.0,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedItem,
        onTap: _cambioWidget,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: yellowPastel),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle, color: yellowPastel),
            label: 'Orden',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.bolt_rounded),
          //   label: 'Favoritos',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined, color: yellowPastel),
            label: 'Perfil',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.account_circle_outlined),
          //   label: 'Pruebas',
          // ),
        ]);
  }
}
