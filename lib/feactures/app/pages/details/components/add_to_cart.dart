// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pastel/feactures/app/function/addToCart.dart';
import 'package:pastel/feactures/auth/models/Product.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../constants.dart';

class AddToCart extends StatefulWidget {
  final Product product;
  const AddToCart({super.key, required this.product});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
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
                if (FirebaseAuth.instance.currentUser != null) {
                  FunctionAddToCart.sendDataToCart(widget.product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Producto agregado al carro',
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: yellowPastel,
                    ),
                  );
                } else {
                  Navigator.pushNamed(context, 'profile');
                }
              },
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (FirebaseAuth.instance.currentUser != null) {
                  FunctionAddToCart.sendDataToCart(widget.product);
                  Navigator.pushNamed(context, 'cartStore');
                } else {
                  Navigator.pushNamed(context, 'profile');
                }
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
