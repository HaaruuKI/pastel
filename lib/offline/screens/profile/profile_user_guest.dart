// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pastel/auth_google.dart';
// import 'package:pastel/constants.dart';
// import 'package:pastel/offline/screens/home/components/btn_back.dart';
// import 'package:pastel/offline/screens/home/components/categorries.dart';
// import 'package:pastel/online/screens/home/components/custom_app_bar.dart';

class ProfileUserGuest extends StatefulWidget {
  const ProfileUserGuest({super.key});

  @override
  State<ProfileUserGuest> createState() => _ProfileUserGuestState();
}

class _ProfileUserGuestState extends State<ProfileUserGuest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: ListView(children: [
          Column(
            children: [
              // const BtnBack(),
              // const CircleAvatar(
              //   radius: 50,
              //   backgroundImage: NetworkImage(
              //       'https://s3-us-west-2.amazonaws.com/s.cdpn.io/764024/profile/profile-512.jpg'),
              // ),
              // const SizedBox(height: 16),
              // const Text(
              //   'Kelly Chen',
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
              // const Text(
              //   'Front-end Web Designer',
              //   style: TextStyle(fontSize: 16),
              // ),
              const SizedBox(height: 300),
              Text(
                'Inicia sesión con:',
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // IconButton(
                  //   icon: Icon(CupertinoIcons.person_alt, size: 50),
                  //   onPressed: () {},
                  // ),
                  // const SizedBox(width: 16),
                  IconButton(
                    icon:
                        Image.asset('assets/images/google512px.png', scale: 10),
                    onPressed: () async {
                      User? user = await Authenticator.iniciarSesion(context);
                      print(user?.displayName);
                      if (user != null) {
                        // ignore: use_build_context_synchronously
                        // Navigator.pushNamed(context, 'navBar');
                        Navigator.pushNamed(context, 'navBar');
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}









// class ProfileUserGuest extends StatefulWidget {
//   const ProfileUserGuest({super.key});

//   @override
//   State<ProfileUserGuest> createState() => _ProfileUserGuestState();
// }

// class _ProfileUserGuestState extends State<ProfileUserGuest> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         child: ListView(children: [
//           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             BtnBack(),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
//               child: Text(
//                 "Reposteria",
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleLarge!
//                     .copyWith(fontWeight: FontWeight.bold),
//               ),
//             ),
//             CategoriesGuest(),
                      //                 User? user = await Authenticator.iniciarSesion(context);
//                 print(user?.displayName);
//                 if (user != null) {
//                   // ignore: use_build_context_synchronously
//                   // Navigator.pushNamed(context, 'navBar');
//                   Navigator.pushNamed(context, 'navBar');

//             // ElevatedButton(
//             //   onPressed: () {
//             //     Navigator.pushNamed(context, 'login');
//             //   },
//             //   child: const Text('Entrar'),
//             // ),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: () async {
//                 User? user = await Authenticator.iniciarSesion(context);
//                 print(user?.displayName);
//                 if (user != null) {
//                   // ignore: use_build_context_synchronously
//                   // Navigator.pushNamed(context, 'navBar');
//                   Navigator.pushNamed(context, 'navBar');
//                 }
//               },
//               icon: Image.asset('assets/images/google512px.png', scale: 25),
//               label: const Text('Entrar con Google.'),
//             ),
//             const SizedBox(height: 20),
//             // ElevatedButton(
//             //   style: buttonPrimary,
//             //   onPressed: () {
//             //     Navigator.pushNamed(context, 'CrearProducto');
//             //   },
//             //   child: const Text('Crear producto'),
//             // ),
//           ]),
//         ]),
//       ),
//     );
//   }
// }
