// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pastel/feactures/app/pages/home/components/custom_app_bar.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _results = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 15,
            ),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(children: [
                  Icon(
                    CupertinoIcons.search,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        autofocus: true,
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Buscar...',
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          _searchFirestore(text.toLowerCase());
                        },
                      ),
                    ),
                  ),
                  // Icon(Icons.filter_list),
                ]),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'details', arguments: {
                          'name': _results[index]['name'],
                          'price': _results[index]['price'],
                          'img': _results[index]['img_url'],
                          'des': _results[index]['description'],
                        });
                      },
                      child: ListTile(
                        title: Text(_results[index]['name']),
                        subtitle: Text('\$ ${_results[index]['price']}'),
                        // trailing: Text(
                        //   'mas detalles',
                        //   style: TextStyle(fontSize: 15),
                        // ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _searchFirestore(String text) {
    String startAt = text;
    String endAt = '$text\uf8ff';

    FirebaseFirestore.instance
        .collection('products')
        .where('name', isGreaterThanOrEqualTo: startAt)
        .where('name', isLessThanOrEqualTo: endAt)
        .get()
        .then((querySnapshot) {
      setState(() {
        _results = querySnapshot.docs;
      });
    });
  }
}
