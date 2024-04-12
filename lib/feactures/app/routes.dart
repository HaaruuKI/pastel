import 'package:flutter/material.dart';
import 'package:pastel/nav_bar.dart';
import 'package:pastel/offline/screens/home/home_screen_guest.dart';
import 'package:pastel/offline/screens/profile/profile_user_guest.dart';
import 'package:pastel/offline/screens/register/register.dart';
import 'package:pastel/offline/screens/search/search.dart';
import 'package:pastel/feactures/app/pages/order/order_page.dart';
import 'package:pastel/feactures/app/pages/profile/profile_user.dart';
import 'package:pastel/product_create/create_product.dart';
import 'package:pastel/feactures/app/pages/cart_store/cart_store.dart';
import 'package:pastel/feactures/app/pages/home/home_screen.dart';
import 'package:pastel/feactures/app/pages/search/search.dart';
import 'package:pastel/product_create/update_product.dart';

/// Rutas de la aplicación
final routes = <String, WidgetBuilder>{
  'homePage': (BuildContext context) => HomeScreen(),
  'search': (BuildContext context) => const Search(),
  'cartStore': (BuildContext context) => const CartStore(),
  'crearProducto': (BuildContext context) => CreateProductPage(),
  'editarProducto': (BuildContext context) => EditProductScreen(),
  'profile': (BuildContext context) => const ProfieUser(),

  // invitados
  'homePageGuest': (BuildContext context) => HomeScreenGuest(),
  'searchGuest': (BuildContext context) => const SearchGuestGuest(),
  'profileGuest': (BuildContext context) => const ProfileUserGuest(),

  // inicializador
  'navBar': (BuildContext context) => const NavBar(),

  'register': (BuildContext context) => const RegisterScreen(),
  'order': (context) => OrderPage(),
};
