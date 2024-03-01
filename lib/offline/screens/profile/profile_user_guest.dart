// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pastel/auth_google.dart';

class ProfileUserGuest extends StatefulWidget {
  const ProfileUserGuest({super.key});

  @override
  State<ProfileUserGuest> createState() => _ProfileUserGuestState();
}

class _ProfileUserGuestState extends State<ProfileUserGuest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Form(
        child: ListView(children: [
          Column(children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'login');
              },
              child: const Text('Entrar'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                User? user = await Authenticator.iniciarSesion(context);
                print(user?.displayName);
                if (user != null) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, 'homePage');
                }
              },
              icon: Image.asset('assets/images/google512px.png', scale: 25),
              label: const Text('Entrar con Google.'),
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   style: buttonPrimary,
            //   onPressed: () {
            //     Navigator.pushNamed(context, 'CrearProducto');
            //   },
            //   child: const Text('Crear producto'),
            // ),
          ]),
        ]),
      ),
    );
  }
}
