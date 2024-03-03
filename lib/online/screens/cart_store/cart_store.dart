// ignore_for_file: file_names, usekey_in_widgetconstructors, prefer_const_constructors, sizedbox_for_itespace, preferconst_literals_to_createimmutables, library__types_in_public_, use_buildcontext_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pastel/constants.dart';
import 'package:pastel/online/screens/home/components/custom_app_bar.dart';

class CartStore extends StatefulWidget {
  const CartStore({super.key});

  @override
  _CartStoreState createState() => _CartStoreState();
}

class _CartStoreState extends State<CartStore> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  final dbRef = FirebaseDatabase.instance.ref();

  List<Map<String, dynamic>> items = [];

  double totalQuantity = 0;
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _getCartData();
  }

  Future<void> _getCurrentUser() async {
    user = _auth.currentUser;
    setState(() {});
  }

  Future<void> _getCartData() async {
    final cartRef = dbRef.child("cart").child(user!.uid);

    final snapshot = await cartRef.once();
    final data = snapshot.snapshot.value as Map<dynamic, dynamic>?;
    if (data != null) {
      final List<Map<String, dynamic>> items = [];
      data.forEach((key, value) {
        final product = Map<String, dynamic>.from(value as dynamic);
        items.add({
          'key': key,
          'name': product['nombre'],
          'price': product['precio'],
          'img': product['imagen'],
          'quantity': product['quantity'],
        });
      });
      if (mounted) {
        setState(() {
          this.items = items;
          totalQuantity = 0;
          totalPrice = 0;
          for (final item in items) {
            totalQuantity += item['quantity'];
            totalPrice += item['quantity'] * item['price'];
          }
          totalQuantity = totalQuantity.toDouble();
          totalPrice = totalPrice.toDouble();
        });
      }
    }
  }

  void _incrementQuantity(String key) {
    final item = items.firstWhere((item) => item['key'] == key);
    final newQuantity = item['quantity'] + 1;
    if (newQuantity > 0) {
      _updateCartData(key, newQuantity);
    }
  }

  void _decrementQuantity(String key) {
    final item = items.firstWhere((item) => item['key'] == key);
    final newQuantity = item['quantity'] - 1;
    if (newQuantity >= 1) {
      _updateCartData(key, newQuantity);
    } else {
      _deleteCartData(key);
    }
  }

  Future<void> _updateCartData(String key, int newQuantity) async {
    await dbRef.child("cart").child(user!.uid).child(key).update({
      'quantity': newQuantity,
    });
    _getCartData();
  }

  Future<void> _deleteCartData(String key) async {
    await dbRef.child("cart").child(user!.uid).child(key).remove();
    _getCartData();
  }

  Future<void> _sendOrder() async {
    final orderRef = dbRef.child("orders").child(user!.uid);

    final order = {
      "products": items.map((item) {
        return {
          "name": item['name'],
          "price": item['price'],
          "quantity": item['quantity'],
        };
      }).toList(),
      "state": "pendiente",
      "totalPrice": totalPrice,
      "totalQuantity": totalQuantity,
      "timestamp": DateTime.now().microsecondsSinceEpoch,
    };

    await orderRef.push().set(order);

    _deleteCart();

    Navigator.pop(context);
  }

  Future<void> _deleteCart() async {
    await dbRef.child("cart").child(user!.uid).remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          CustomAppBar(),
          Padding(
            padding: EdgeInsets.only(top: 0, left: 5, bottom: 5),
            child: Text(
              'Lista de ordenes',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 9),
                              child: Container(
                                width: 400,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        offset: Offset(0, 3),
                                      ),
                                    ]),
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Image.network(
                                        item['img'],
                                        width: 130,
                                        height: 80,
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              item['name'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '\$${item['price'].toStringAsFixed(2)}',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: yellowPastel,
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: yellowPastel,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 70,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Text(
                'Total:',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                '\$ {price ?? ' '}',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ]),
            ElevatedButton.icon(
              onPressed: () {
                // enviarDatosRealtimeDatabase(name!, price!, img!);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(yellowPastel),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              icon: Icon(
                CupertinoIcons.cart,
                color: Colors.black,
              ),
              label: Text(
                'Comprar',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
