// ignore_for_file: file_names, usekey_in_widgetconstructors, prefer_const_constructors, sizedbox_for_itespace, preferconst_literals_to_createimmutables, library__types_in_public_, use_buildcontext_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pastel/feactures/app/constants.dart';
import 'package:pastel/feactures/app/function/cartStore.dart';
import 'package:pastel/feactures/app/pages/home/components/custom_app_bar.dart';

class CartStore extends StatefulWidget {
  const CartStore({Key? key});

  @override
  _CartStoreState createState() => _CartStoreState();
}

class _CartStoreState extends State<CartStore> {
  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    FunctionCartStore.user = FunctionCartStore.auth.currentUser;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: StreamBuilder(
        stream: FunctionCartStore.dbRef
            .child("cart")
            .child(FunctionCartStore.user!.uid)
            .onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final data =
                snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
            if (data != null) {
              final List<Map<String, dynamic>> items = [];
              data.forEach((key, value) {
                final product = Map<String, dynamic>.from(value as dynamic);
                items.add({
                  'key': key,
                  'name': product['name'],
                  'price': product['price'],
                  'img': product['image'],
                  'quantity': product['quantity'],
                });
              });
              double totalQuantity = 0;
              double totalPrice = 0;
              for (final item in items) {
                totalQuantity += item['quantity'];
                totalPrice += item['quantity'] * item['price'].toDouble();
              }
              totalQuantity = totalQuantity.toDouble();
              totalPrice = totalPrice.toDouble();

              return Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(top: 0, left: 5, bottom: 5),
                    child: Text(
                      'Carrito',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 9),
                                      child: Container(
                                        width: 400,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: yellowPastel,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
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
                                                  children: [
                                                    Text(
                                                      item['name'],
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      '\$${item['price'].toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 13),
                                                  InkWell(
                                                    onTap: () {
                                                      FunctionCartStore
                                                          .incrementQuantity(
                                                              item['key'],
                                                              items);
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${item['quantity']}',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      FunctionCartStore
                                                          .decrementQuantity(
                                                              item['key'],
                                                              items);
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                  BottomAppBar(
                    color: yellowPastel,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 70,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Text(
                                'Cantidad:',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                totalQuantity.toStringAsFixed(0),
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ]),
                            ElevatedButton.icon(
                              onPressed: () {
                                FunctionCartStore.sendOrder(
                                    items, totalPrice, totalQuantity, context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(yellowPastel),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
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
                                '\$${totalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              );
            }
          }

          return Center(
            child: Text('No hay productos en el carrito'),
          );
        },
      ),
    );
  }
}
