import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pastel/constants.dart';

class ProfileUserGuest extends StatefulWidget {
  const ProfileUserGuest({Key? key}) : super(key: key);

  @override
  _ProfileUserGuestState createState() => _ProfileUserGuestState();
}

class _ProfileUserGuestState extends State<ProfileUserGuest> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Constraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _signInWithEmailAndPassword(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: const Text('Iniciar sesion'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'register');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey,
              ),
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (snapshot.exists) {
          final userData = snapshot.data();
          final String? userName = (userData as Map<String, dynamic>)['name'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: yellowPastel,
              content: Text(
                'Inicio de sesión exitoso. Usuario: $userName',
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: yellowPastel,
              content: const Text(
                'Datos de usuario no encontrados',
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        }

        Navigator.pushNamed(context, 'navBar');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: yellowPastel,
            content: const Text(
              'Inicio de sesión fallido',
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: yellowPastel,
          content: Text(
            'Error durante el inicio de sesión: $e',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
  }
}
