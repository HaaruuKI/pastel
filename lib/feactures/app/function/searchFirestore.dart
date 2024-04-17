import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FunctionSearchFirestore {
  static Stream<QuerySnapshot> getFirestoreStream(
      TextEditingController searchController) {
    String text = searchController.text.toLowerCase();
    String startAt = text;
    String endAt = '$text\uf8ff';

    return FirebaseFirestore.instance
        .collection('products')
        .where('name', isGreaterThanOrEqualTo: startAt)
        .where('name', isLessThanOrEqualTo: endAt)
        .snapshots();
  }
}
