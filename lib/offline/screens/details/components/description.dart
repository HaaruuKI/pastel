import 'package:flutter/material.dart';
import 'package:pastel/feactures/auth/models/Product.dart';

import '../../../../feactures/app/constants.dart';

class DescriptionGuest extends StatelessWidget {
  const DescriptionGuest({super.key, required this.product});

  final Product product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Text(
        product.description,
        style: TextStyle(height: 1.5),
      ),
    );
  }
}
