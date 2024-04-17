import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pastel/feactures/auth/models/Product.dart';

class FunctionAddToCart {
  static final firebaseDatabaseReference = FirebaseDatabase.instance.ref();
  static final firebaseAuth = FirebaseAuth.instance;

  static Future<void> sendDataToCart(Product product) async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final productImage = product.image;
      final productName = product.title;
      final productPrice = product.price;
      final productDescripcion = product.description;

      firebaseDatabaseReference
          .child('cart')
          .child(userId)
          .child(productName)
          .set({
        'image': productImage,
        'name': productName,
        'price': productPrice,
        'description': productDescripcion,
        'quantity': 1,
      });
    }
  }
}
