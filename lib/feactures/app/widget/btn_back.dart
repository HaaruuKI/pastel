import 'package:flutter/material.dart';

//Creando un boton de retroceso
Widget btnBack(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
        size: 50.0,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}








// import 'package:flutter/material.dart';

// //Creando un boton de retroceso
// Widget btnBack(BuildContext context) {
//   return IconButton(
//     icon: const Icon(
//       Icons.arrow_back,
//       color: Colors.black,
//       size: 50.0,
//     ),
//     onPressed: () {
//       Navigator.pop(context);
//     },
//   );
// }
