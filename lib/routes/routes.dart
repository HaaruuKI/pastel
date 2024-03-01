import 'package:flutter/material.dart';
import 'package:pastel/offline/screens/profile/profile_user_guest.dart';
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
  'profileGuets': (BuildContext context) => const ProfileUserGuest(),
  'profile': (BuildContext context) => const ProfieUser(),
};
