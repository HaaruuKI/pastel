import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FunctionCartStore {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static User? user;
  static final dbRef = FirebaseDatabase.instance.ref();

  static Future<void> incrementQuantity(String key, items) async {
    final item = items.firstWhere((item) => item['key'] == key);
    final newQuantity = item['quantity'] + 1;
    if (newQuantity > 0) {
      updateCartData(key, newQuantity);
    }
  }

  static Future<void> decrementQuantity(String key, items) async {
    final item = items.firstWhere((item) => item['key'] == key);
    final newQuantity = item['quantity'] - 1;
    if (newQuantity >= 1) {
      updateCartData(key, newQuantity);
    } else {
      deleteCartData(key);
    }
  }

  static Future<void> updateCartData(
    String key,
    int newQuantity,
  ) async {
    await dbRef.child("cart").child(user!.uid).child(key).update({
      'quantity': newQuantity,
    });
  }

  static Future<void> deleteCartData(String key) async {
    await dbRef.child("cart").child(user!.uid).child(key).remove();
  }

  static Future<void> sendOrder(List<Map<String, dynamic>> items,
      double totalPrice, double totalQuantity, BuildContext context) async {
    final orderRef = dbRef.child("order").child(user!.uid);

    final order = {
      "products": items.map((item) {
        return {
          "name": item['name'],
          "price": item['price'],
          "quantity": item['quantity'],
        };
      }).toList(),
      "totalPrice": totalPrice,
      "totalQuantity": totalQuantity,
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      'state': 'pendiente',
    };

    await orderRef.push().set(order);

    deleteCart();
    Navigator.pop(context);
  }

  static Future<void> deleteCart() async {
    await dbRef.child("cart").child(user!.uid).remove();
  }
}
