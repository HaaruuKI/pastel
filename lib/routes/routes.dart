import 'package:flutter/material.dart';
import 'package:pastel/product_create/create_product.dart';
import 'package:pastel/screens/cart_store/cart_store.dart';
import 'package:pastel/screens/home/home_screen.dart';
import 'package:pastel/screens/search/search.dart';

/// Rutas de la aplicación
final routes = <String, WidgetBuilder>{
  'homePage': (BuildContext context) => HomeScreen(),
  'search': (BuildContext context) => const Search(),
  'cartStore': (BuildContext context) => const CartStore(),
  'crearProducto': (BuildContext context) => CreateProductPage(),
};
