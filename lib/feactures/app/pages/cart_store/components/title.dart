// import 'package:flutter/material.dart';
// import 'package:pastel/constants.dart';
// import 'package:pastel/models/Product.dart';

// class Title extends StatelessWidget {
//   const Title({super.key, required this.product, required this.press});

//   final Product product;
//   final VoidCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
//       // Mostrar el id del producto en un Text
//       child: TextButton(
//         onPressed: press,
//         child: Text(
//           '${product.id}',
//           style: TextStyle(color: kTextLightColor),
//         ),
//       ),
//     );
//     //   child: Text(
//     //     "Carrito",
//     //     style: Theme.of(context)
//     //         .textTheme
//     //         .titleLarge!
//     //         .copyWith(fontWeight: FontWeight.bold),
//     //   ),
//     // );
//   }
// }
