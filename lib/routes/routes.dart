import 'package:flutter/material.dart';
import 'package:pastel/nav_bar.dart';
import 'package:pastel/offline/screens/home/home_screen_guest.dart';
import 'package:pastel/offline/screens/profile/profile_user_guest.dart';
import 'package:pastel/offline/screens/search/search.dart';
import 'package:pastel/online/screens/profile/profile_user.dart';
import 'package:pastel/product_create/create_product.dart';
import 'package:pastel/online/screens/cart_store/cart_store.dart';
import 'package:pastel/online/screens/home/home_screen.dart';
import 'package:pastel/online/screens/search/search.dart';

/// Rutas de la aplicación
final routes = <String, WidgetBuilder>{
  'homePage': (BuildContext context) => HomeScreen(),
  'search': (BuildContext context) => const Search(),
  'cartStore': (BuildContext context) => const CartStore(),
  'crearProducto': (BuildContext context) => CreateProductPage(),
  'profile': (BuildContext context) => const ProfieUser(),

  // invitados
  'homePageGuest': (BuildContext context) => HomeScreenGuest(),
  'searchGuest': (BuildContext context) => const SearchGuestGuest(),
  'profileGuest': (BuildContext context) => const ProfileUserGuest(),

  // inicializador
  'navBar': (BuildContext context) => const NavBar(),
};
