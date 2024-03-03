// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pastel/models/Product.dart';
// import 'package:firebase_database/firebase_database.dart';

import '../../../../../constants.dart';

class AddToCartGuest extends StatefulWidget {
  final Product product;
  const AddToCartGuest({super.key, required this.product});

  @override
  State<AddToCartGuest> createState() => _AddToCartGuestState();
}

class _AddToCartGuestState extends State<AddToCartGuest> {
  // final firebaseDatabaseReference = FirebaseDatabase.instance.ref();

  // void sendDataToCart(Product product) {
  //   // final productId = product.id;
  //   final productImage = product.image;
  //   final productName = product.title;
  //   final productPrice = product.price;
  //   final productDescripcion = product.description;

  //   firebaseDatabaseReference.child('cart').child(productName).set({
  //     // 'id': productId,
  //     'image': productImage,
  //     'name': productName,
  //     'price': productPrice,
  //     'description': productDescripcion,
  //     'quantity': 1,
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: IconButton(
              icon: const Icon(CupertinoIcons.cart),
              onPressed: () {
                Navigator.pushNamed(context, 'profileGuest');
                // sendDataToCart(widget.product);
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text(
                //       'Producto agregado al carro',
                //       style: TextStyle(color: Colors.black),
                //     ),
                //     backgroundColor: yellowPastel, // Change the color here
                //   ),
                // );
              },
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // sendDataToCart(widget.product);
                Navigator.pushNamed(context, 'profileGuest');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                backgroundColor: yellowPastel,
              ),
              child: Text(
                "Buy  Now".toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
